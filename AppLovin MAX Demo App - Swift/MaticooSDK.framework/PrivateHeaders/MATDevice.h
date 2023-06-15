//
//  MATDevice.h
//  MaticooSDK
//
//  Created by root on 2023/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MATDevice : NSObject
+(NSNumber*) getFirstInstallTime;
+(NSNumber*) getFirstLaunchTime;
+(NSNumber*) getTimeZone;
+(NSString*) getTimeZoneLocale;
+(NSString*) getIDFA;
+(NSNumber*) getDeviceType;
+(NSString*) getLanguageCode;
+(NSNumber*) isJailed;
+(NSString*) getMake;
+(NSString*) getBrand;
+(NSString*) getModel;
+(NSString*) getSystemVersion;
+(NSString*) getSystemBuild;
+(NSString*) getBundleVersion;
+(NSString*) getShortBundleVersion;
+(NSNumber*) getScreenWidth;
+(NSNumber*) getScreenHeight;
+(NSNumber*) getConnectionType;
+(NSString*) getNetworkOperatorNameWithMCCMNC;
+(NSNumber*) getFreeDiskSpace;
+(NSNumber*) getBatteryLevel;
+(NSNumber*) getChargingStatus;
+(NSNumber*) getLowPowerModeStatus;
+(NSNumber*) getBootTime;
+(NSNumber*) getTotalMemorySize;
+(NSString*) getCountry;
+(NSString*) getUserAgent:(void(^)())complete;
+ (int)getPhoneOrientation;
@end

NS_ASSUME_NONNULL_END
