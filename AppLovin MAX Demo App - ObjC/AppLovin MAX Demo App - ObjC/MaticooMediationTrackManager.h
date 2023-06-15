//
//  MATTrackManager.h
//  MaticooSDK
//
//  Created by root on 2023/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaticooMediationTrackManager : NSObject
+ (void)trackMediationInitSuccess;
+ (void)trackMediationInitFailed:(NSError*)error;
+ (void)trackMediationAdRequest:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL)isAuto;
+ (void)trackMediationAdRequestFilled:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdRequestFailed:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdImp:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdImpFailed:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdClick:(NSString*)pid adType:(NSInteger)adtype;
+ (void)trackMediationAdShow:(NSString*)pid adType:(NSInteger)adtype;
@end

NS_ASSUME_NONNULL_END
