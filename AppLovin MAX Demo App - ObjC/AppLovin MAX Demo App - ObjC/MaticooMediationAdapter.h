//
//  MaticooMediationAdapter.h
//  AppLovin MAX Demo App - ObjC
//
//  Created by root on 2023/5/18.
//  Copyright © 2023 AppLovin Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppLovinSDK/AppLovinSDK.h>
#import <MaticooSDK/MaticooAds.h>
#import <MaticooSDK/MATInterstitialAd.h>
#import <MaticooSDK/MATRewardedVideoAd.h>
#import <MaticooSDK/MATNativeAd.h>
#import <MaticooSDK/MATBannerAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaticooMediationAdapter : ALMediationAdapter <MATBannerAdDelegate, MATNativeAdDelegate, MATInterstitialAdDelegate, MATRewardedVideoAdDelegate>

@end

NS_ASSUME_NONNULL_END
