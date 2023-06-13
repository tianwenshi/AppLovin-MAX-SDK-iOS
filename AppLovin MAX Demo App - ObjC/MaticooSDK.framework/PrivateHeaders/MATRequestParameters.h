//
//  MATRequestParam.h
//  MaticooSDK
//
//  Created by root on 2023/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MATRequestParameters : NSObject
+(NSMutableDictionary *) buildBaseParameters;
+(NSString *) buildLogUrl;
+(NSString *) buildLogUrl:(NSString*) key;
+(NSString *) buildInitUrl:(NSString*) key;
+(NSMutableDictionary *) buildBannerParameters:(NSMutableDictionary*) dict pid:(NSInteger)pid cwidth:(NSInteger)width cheight:(NSInteger)height;
+(NSString *) buildBannerUrl;
+(NSString *) buildFullScreenAdUrl:(BOOL) isVideo;
+ (NSMutableDictionary *)buildNativeParameters:(NSMutableDictionary*)dic pid:(NSInteger)pid;
+ (NSString *) buildNativeUrl;
+ (NSMutableDictionary *)buildInteractParameters:(NSMutableDictionary*)dic pid:(NSInteger)pid;
+ (NSString *) buildInteractUrl;
+(void) setAppkey:(NSString*)key;
+(NSString*) getAppkey;
@end

NS_ASSUME_NONNULL_END
