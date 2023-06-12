//
//  MATTrackManager.h
//  MaticooSDK
//
//  Created by root on 2023/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MATTrackManager : NSObject
+ (void)trackSDKInitStart:(NSString*)key;
+ (void)trackSDKInitSuccess;
+ (void)trackSDKInitFailed:(NSInteger) eventCode msg:(NSString*)msg; //"1、初始化前置检查异常（AppKey、权限）2、初始化期间发生的crash3、配置文件请求成功之后，响应码错误。4、配置文件请求结果为空。5、配置文件请求的配置项为空。6、配置信息，网络请求失败"
+ (void)trackAdRequestInProcess; //正在加载广告
+ (void)trackAdRequest:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL) isAuto;
+ (void)trackAdRequestInTraffic:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL) isAuto; //广告走网络请求
+ (void)trackAdHitCache; //广告走网络请求
+ (void)trackAdRequestSuccess:(NSString*)pid adType:(NSInteger)adtype duration:(NSTimeInterval) duration;
+ (void)trackAdRequestNetworkFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg;
+ (void)trackAdRequestFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg;
+ (void)trackAdShowFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg;
+ (void)trackVideoPlayed:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackVideoCompleted:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackVideoClick:(NSString*)pid adType:(NSInteger)adtype position:(NSString*)position;
+ (void)trackVideoClose:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackVideoMuted:(NSString*)pid adType:(NSInteger)adtype isMute:(BOOL)isMute;
+ (void)trackMediationInitSuccess;
+ (void)trackMediationInitFailed;
+ (void)trackMediationAdRequest;
+ (void)trackMediationAdRequestFilled;
+ (void)trackMediationAdRequestFailed;
+ (void)trackMediationAdImp;
+ (void)trackMediationAdImpFailed;
+ (void)trackMediationAdClick;
+ (void)trackMediationException;
+ (void)trackInteractiveIconShow;
+ (void)trackInteractiveIconClick;
+ (void)trackInteractiveWebEvent;
+ (void)trackNativeAdClose:(NSString *)reason andPid:(NSString *)pid;
@end

NS_ASSUME_NONNULL_END
