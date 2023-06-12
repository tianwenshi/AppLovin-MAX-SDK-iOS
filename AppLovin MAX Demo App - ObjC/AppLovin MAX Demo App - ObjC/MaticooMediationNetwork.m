//
//  NetworkManager.m
//  ApplinsSDK
//
//  Created by Mirinda on 16/5/30.
//  Copyright © 2016年 Mirinda. All rights reserved.
//

#import "MaticooMediationNetwork.h"
#import "MATURLSessionNet.h"
#import "MATMarco.h"
#import "MATDevice.h"

//#import "MATReachability.h"
//#import "NSData+ALSAES.h"

@interface MaticooMediationNetwork ()
@end

@implementation MaticooMediationNetwork
//初始化
+ (instancetype)manager
{
    return [[[self class]alloc]init];
}

//get requeset
+ (id)GET:(NSString *)path parameters:(NSDictionary *)params isRetJson:(BOOL)isJson completeHandler:(void(^)(id responseObj, NSError* error))complete
{
    if(nil == path || ![path isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSMutableString* requestPath = [NSMutableString stringWithString:path];
    if(nil != params && params.count > 0) {
        [requestPath appendString:@"?"];
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [requestPath appendString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
        }];
    }
    NSString* urlStr = [requestPath stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL* url = [NSURL URLWithString:urlStr];
    
#ifdef Debug
    if ([url.host isEqualToString:@"v.adthor.com"] || [url.host isEqualToString:@"52.221.205.188"] || [url.absoluteString rangeOfString:[ALSTools stitchingRequestLinkWithHost:ALS_MRAIDURL]].location != NSNotFound) {
        APPLINSLOG(@"request : %@", url.absoluteString);
    }
#endif
    MATURLSessionNet* session = [MATURLSessionNet session];
    return [session GET:url isRetJson:isJson completeHandler:^(id responseObj, NSError *error) {
        if (error)
        {
//            DLog(@"ERR_002_NetError");
            complete(nil,error);
        }else
        {
            complete(responseObj,nil);
        }
    }];

}

//post request
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params postCiphertext:(BOOL)isCiphertext completeHandle:(void (^)(id responseObj, NSError* error))complete
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *ua = [MATDevice getUserAgent:^{}];
    if (MAT_NSSTRING_NOT_NULL(ua)) {
        [request addValue:ua forHTTPHeaderField:@"User-Agent"];
    }
    
    NSError* parseError = nil;
    request.HTTPMethod = @"POST";
    
    NSData* postData = nil;
    if (!MAT_NSDICTIONARY_NOT_EMPTY(params)) {
        complete(nil,nil);
        return nil;
    }
    @try
    {
        postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&parseError];
    }
    @catch (NSException *exception){
        NSLog(@"Error(try-catch):MATNetWorkManager->POST,exception name is %@,reason is %@",exception.name,exception.reason);
        return nil;
    }
    
    if ([postData isKindOfClass:[NSData class]] && postData.length > 0)
    {
        if (isCiphertext)
        {
//            if (flag) {
//                request.HTTPBody = [postData mix_ALSAES256Encrypt];
//            }else {
//                request.HTTPBody = [[[postData ALSAES256Encrypt:ALS_DINFO_K] ALSConvertDataToHexStr] dataUsingEncoding:NSUTF8StringEncoding];
//            }
        }
        else
        {
            request.HTTPBody = postData;
        }
        
    }
    else
    {
        request.HTTPBody = nil;
    }
        
    MATURLSessionNet* session = [MATURLSessionNet session];
    
    return [session POST:request completeHandler:^(id responseObj, NSError *error) {
        if (error)
        {
//            DLog(@"ERR_002_NetError");
            complete(nil,error);
        }
        else
        {
            complete(responseObj,nil);
        }
    }];
}

//FOR DEVICE INFO
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completeHandle:(void (^)(id responseObj, NSError* error))complete
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *ua = [MATDevice getUserAgent:^{}];
    if (MAT_NSSTRING_NOT_NULL(ua)) {
        [request addValue:ua forHTTPHeaderField:@"User-Agent"];
    }
    
    NSError* parseError = nil;
    request.HTTPMethod = @"POST";
    
    NSData* postData = nil;
    if (!MAT_NSDICTIONARY_NOT_EMPTY(params)) {
        complete(nil,nil);
        return nil;
    }
    
    @try
    {
        postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&parseError];
    }
    @catch (NSException *exception){
        NSLog(@"Error(try-catch):MATNetWorkManager->POST,exception name is %@,reason is %@",exception.name,exception.reason);
        return nil;
    }
    
    if ([postData isKindOfClass:[NSData class]] && postData.length > 0)
    {
        request.HTTPBody = postData;
    }else{
        request.HTTPBody = nil;
    }
        
    MATURLSessionNet* session = [MATURLSessionNet session];
    
    return [session POST:request completeHandler:^(id responseObj, NSError *error) {
        if (error)
        {
//            DLog(@"ERR_002_NetError");
            complete(responseObj,error);
        }
        else
        {
            complete(responseObj,nil);
        }
    }];
}


//加载网络图片
+(void)getImageFromURL:(NSString *)fileURL img:(void(^)(UIImage *ig))image
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage imageWithData:data];
        image(result);
    });

}


#pragma mark -session delegate
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler
{
    if (response.statusCode == 301 || response.statusCode == 302) {
        //NSLog(@"requeset [ %ld ] url [ %@ ]",urlResponse.statusCode,dic[@"Location"]);
        completionHandler(request);
    }else{
        completionHandler(nil);
    }
}

@end
