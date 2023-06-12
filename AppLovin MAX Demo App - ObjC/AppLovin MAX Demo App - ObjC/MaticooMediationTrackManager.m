//
//  MATTrackManager.m
//  MaticooSDK
//
//  Created by root on 2023/5/4.
//

#import "MaticooMediationTrackManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "MaticooMediationNetwork.h"

#define TIMESTAMP_MS [[NSDate date] timeIntervalSince1970] * 1000
static NSString *logURL = @"";

@implementation MaticooMediationTrackManager

+(NSString *) buildLogUrl{
    Class requestClass = NSClassFromString(@"MATRequestParameters");
    if(requestClass && [logURL isEqualToString:@""]){
        logURL = ((NSString* (*)(id, SEL))objc_msgSend)((id)requestClass, @selector(buildLogUrl));
    }
    return logURL;
}

+ (void)trackMediationInitSuccess{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:203],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS],@"adapter_flat":@"MAX"}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

+ (void)trackMediationInitFailed:(NSError*)error{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:204],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS], @"adapter_flat":@"MAX", @"msg": error.description}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

+ (void)trackMediationAdRequest:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL)isAuto{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:201],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS],@"ad_type": [NSNumber numberWithInteger:adtype], @"adapter_flat":@"MAX"}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

+ (void)trackMediationAdRequestFilled:(NSString*)pid adType:(NSInteger)adtype{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:205],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS],@"ad_type": [NSNumber numberWithInteger:adtype], @"adapter_flat":@"MAX"}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

+ (void)trackMediationAdRequestFailed:(NSString*)pid adType:(NSInteger)adtype{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:206],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS],@"ad_type": [NSNumber numberWithInteger:adtype], @"adapter_flat":@"MAX"}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

+ (void)trackMediationAdImp:(NSString*)pid adType:(NSInteger)adtype{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:207],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS],@"ad_type": [NSNumber numberWithInteger:adtype], @"adapter_flat":@"MAX"}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

+ (void)trackMediationAdImpFailed:(NSString*)pid adType:(NSInteger)adtype{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:208],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS],@"ad_type": [NSNumber numberWithInteger:adtype], @"adapter_flat":@"MAX"}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

+ (void)trackMediationAdClick:(NSString*)pid adType:(NSInteger)adtype{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    [jsonArray addObject:@{ @"eid": [NSNumber numberWithInt:209],@"ts": [NSNumber numberWithLongLong:TIMESTAMP_MS],@"ad_type": [NSNumber numberWithInteger:adtype], @"adapter_flat":@"MAX"}];
    [dict setValue:jsonArray forKey:@"data"];
    NSString *url = [self buildLogUrl];
    [MaticooMediationNetwork POST:url parameters:dict completeHandle:^(id responseObj, NSError *error) {}];
}

@end
