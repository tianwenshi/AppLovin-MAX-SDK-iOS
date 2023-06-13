//
//  MATTrackManager.h
//  MaticooSDK
//
//  Created by root on 2023/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MATTrackManager : NSObject
+ (void)trackSDKInitStart:(NSString*)key dict:(NSDictionary*)baseDictionary;
+ (void)trackSDKInitSuccess:(NSDictionary*)baseDictionary;
+ (void)trackSDKInitFailed:(NSInteger) eventCode msg:(NSString*)msg dict:(NSDictionary*)baseDictionary; //"1、初始化前置检查异常（AppKey、权限）2、初始化期间发生的crash3、配置文件请求成功之后，响应码错误。4、配置文件请求结果为空。5、配置文件请求的配置项为空。6、配置信息，网络请求失败"
+ (void)trackAdRequest:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL) isAuto dict:(NSDictionary*)baseDictionary;
+ (void)trackAdRequestInProcess:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL) isAuto dict:(NSDictionary*)baseDicionary;
+ (void)trackAdRequestInTraffic:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL) isAuto dict:(NSDictionary*)baseDictionary; //广告走网络请求
+ (void)trackAdHitCache:(NSString*)pid adType:(NSInteger)adtype dict:(NSDictionary*)baseDictionary; //广告走网络请求
+ (void)trackAdRequestSuccess:(NSString*)pid adType:(NSInteger)adtype duration:(NSTimeInterval) duration dict:(NSDictionary*)baseDictionary;
+ (void)trackAdRequestNetworkFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg dict:(NSDictionary*)baseDictionary;
+ (void)trackAdRequestFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg dict:(NSDictionary*)baseDictionary;
+ (void)trackAdShowFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg dict:(NSDictionary*)baseDictionary;
+ (void)trackVideoPlayed:(NSString*)pid adType:(NSInteger)adtype dict:(NSDictionary*)baseDictionary;
+ (void)trackVideoCompleted:(NSString*)pid adType:(NSInteger)adtype dict:(NSDictionary*)baseDictionary;
+ (void)trackVideoClick:(NSString*)pid adType:(NSInteger)adtype position:(NSString*)position dict:(NSDictionary*)baseDictionary;
+ (void)trackVideoClose:(NSString*)pid adType:(NSInteger)adtype dict:(NSDictionary*)baseDictionary;
+ (void)trackVideoMuted:(NSString*)pid adType:(NSInteger)adtype isMute:(BOOL)isMute dict:(NSDictionary*)baseDictionary;
+ (void)trackNativeAdClose:(NSString *)reason andPid:(NSString *)pid dict:(NSDictionary*)baseDictionary;
@end

NS_ASSUME_NONNULL_END
