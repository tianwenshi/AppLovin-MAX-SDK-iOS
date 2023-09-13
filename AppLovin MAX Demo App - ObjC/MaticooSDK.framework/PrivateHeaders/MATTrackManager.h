//
//  MATTrackManager.h
//  MaticooSDK
//
//  Created by root on 2023/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MATTrackManager : NSObject
+ (void)trackSDKInitStart;
+ (void)trackSDKInitSuccess;
+ (void)trackSDKInitFailed:(NSInteger) eventCode msg:(NSString*)msg appKey:(NSString*)appKey; //"1、初始化前置检查异常（AppKey、权限）2、初始化期间发生的crash3、配置文件请求成功之后，响应码错误。4、配置文件请求结果为空。5、配置文件请求的配置项为空。6、配置信息，网络请求失败"
+ (void)trackAdRequest:(NSString*)pid adType:(NSInteger)adtype rid:(NSString*)rid isAutoRefresh:(NSInteger) isAuto;
+ (void)trackAdRequestInTraffic:(NSString*)pid adType:(NSInteger)adtype; //广告走网络请求
+ (void)trackAdHitCache:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(NSInteger)isAuto rid:(NSString*)rid; //广告走网络请求
+ (void)trackAdLoadSuccess:(NSString*)pid adType:(NSInteger)adtype duration:(NSTimeInterval) duration rid:(NSString*)rid;
+ (void)trackAdRequestSuccess:(NSString*)pid adType:(NSInteger)adtype duration:(NSTimeInterval) duration rid:(NSString*)rid;
+ (void)trackAdRequestNetworkFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg;
+ (void)trackAdRequestFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg;
+ (void)trackAdShowFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*) msg rid:(NSString*)rid;
+ (void)trackVideoPlayed:(NSString*)pid adType:(NSInteger)adtype rid:(NSString*)rid;
+ (void)trackVideoCompleted:(NSString*)pid adType:(NSInteger)adtype rid:(NSString*)rid;
+ (void)trackClick:(NSString*)pid adType:(NSInteger)adtype position:(NSString*)position rid:(NSString*)rid;
+ (void)trackShow:(NSString*)pid adType:(NSInteger)adtype rid:(NSString*)rid;
+ (void)trackClose:(NSString*)pid adType:(NSInteger)adtype button:(NSString*)btnName rid:(NSString*)rid;
+ (void)trackVideoMuted:(NSString*)pid adType:(NSInteger)adtype isMute:(BOOL)isMute rid:(NSString*)rid;
+ (void)trackLoadWhileShowing:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackInteractiveIconShow:(NSString *)pid dict:(NSDictionary*)baseDictionary rid:(NSString*)rid;
+ (void)trackInteractiveIconClick:(NSString *)pid dict:(NSDictionary*)baseDictionary rid:(NSString*)rid;
+ (void)trackInteractiveIconShowBi:(NSString *)pid rid:(NSString*)rid;
+ (void)trackInteractiveIconClickBi:(NSString *)pid rid:(NSString*)rid;
+ (void)trackAdImp:(NSString *)pid adType:(NSInteger)adtype rid:(NSString*)rid;
+ (void)trackPrivacyClick:(NSString *)pid adType:(NSInteger)adtype msgType:(NSInteger)msgType rid:(NSString*)rid;
+ (void)trackInteractiveWebEvent:(NSString*)pid biDict:(NSDictionary*)biDictionary baseDict:(NSDictionary*)baseDictionary h5Dict:(NSDictionary*) h5Dict rid:(NSString*)rid;
+ (void)trackCacheTime:(NSString *)pid adType:(NSInteger)adtype duration:(NSInteger)duration success:(BOOL)success rid:(NSString*)rid;
+ (void)trackNetwork:(NSString*)systemError msg:(NSString*)msg;
+ (void)trackMediationInitSuccess;
+ (void)trackMediationInitFailed:(NSString*)msg;
+ (void)trackMediationAdRequest:(NSString*)pid adType:(NSInteger)adtype rid:(NSString*)rid isAutoRefresh:(NSInteger)isAuto;
+ (void)trackMediationAdRequestFilled:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdRequestFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*)msg;
+ (void)trackMediationAdShow:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdImp:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdImpFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*)msg;
+ (void)trackMediationAdClick:(NSString*)pid adType:(NSInteger)adtype;
@end

NS_ASSUME_NONNULL_END
