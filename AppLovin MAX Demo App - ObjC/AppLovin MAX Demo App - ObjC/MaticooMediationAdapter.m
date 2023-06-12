//
//  MaticooMediationAdapter.m
//  AppLovin MAX Demo App - ObjC
//
//  Created by root on 2023/5/18.
//  Copyright © 2023 AppLovin Corporation. All rights reserved.
//

#import "MaticooMediationAdapter.h"

#define ADAPTER_VERSION @"1.0.0"
#define SDK_VERSION @"1.0.0"

@interface ALMaticooMediationAdapterInterstitialAdDelegate : NSObject <MATInterstitialAdDelegate>
@property (nonatomic,   weak) MaticooMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MAInterstitialAdapterDelegate> delegate;
- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MAInterstitialAdapterDelegate>)delegate;
@end

@interface ALMaticooMediationAdapterRewardedVideoAdDelegate : NSObject <MATRewardedVideoAdDelegate>
@property (nonatomic,   weak) MaticooMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MARewardedAdapterDelegate> delegate;
- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MARewardedAdapterDelegate>)delegate;
@end

@interface ALMaticooMediationAdapterAdViewDelegate : NSObject <MATBannerAdDelegate>
@property (nonatomic,   weak) MaticooMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MAAdViewAdapterDelegate> delegate;
- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MAAdViewAdapterDelegate>)delegate;
@end

@interface ALMaticooMediationAdapterNativeAdViewAdDelegate : NSObject <MATNativeAdDelegate>
@property (nonatomic,   weak) MaticooMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MAAdViewAdapterDelegate> delegate;
- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MAAdViewAdapterDelegate>)delegate;
@end

@interface ALMaticooMediationAdapterNativeAdDelegate : NSObject <MATNativeAdDelegate>
@property (nonatomic,   weak) MaticooMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MANativeAdAdapterDelegate> delegate;
- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MANativeAdAdapterDelegate>)delegate;
@end

@interface MAMaticooNativeAd : MANativeAd
@property (nonatomic, weak) MaticooMediationAdapter *parentAdapter;
- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter builderBlock:(NS_NOESCAPE MANativeAdBuilderBlock)builderBlock;
- (instancetype):(MAAdFormat *)format builderBlock:(NS_NOESCAPE MANativeAdBuilderBlock)builderBlock NS_UNAVAILABLE;
@end

@interface MaticooMediationAdapter ()
@property (nonatomic, strong) MATBannerAd *bannerAdView;
@property (nonatomic, strong) MATInterstitialAd *interstitial;
@property (nonatomic, strong) MATNativeAd *nativeAd;
@property (nonatomic, strong) MATRewardedVideoAd *rewardedVideoAd;

@property (nonatomic, strong) ALMaticooMediationAdapterInterstitialAdDelegate *interstitialAdapterDelegate;
@property (nonatomic, strong) ALMaticooMediationAdapterRewardedVideoAdDelegate *rewardedAdapterDelegate;
@property (nonatomic, strong) ALMaticooMediationAdapterAdViewDelegate *adViewAdapterDelegate;
@property (nonatomic, strong) ALMaticooMediationAdapterNativeAdViewAdDelegate *nativeAdViewAdAdapterDelegate;
@property (nonatomic, strong) ALMaticooMediationAdapterNativeAdDelegate *nativeAdAdapterDelegate;


@end


@implementation MaticooMediationAdapter 

#pragma mark - MAAdapter Methods

- (void)initializeWithParameters:(id<MAAdapterInitializationParameters>)parameters completionHandler:(void (^)(MAAdapterInitializationStatus, NSString *_Nullable))completionHandler
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *appKey = [parameters.serverParameters al_stringForKey: @"app_id"];
        NSLog(@"Initializing Maticoo SDK with app key: %@...", appKey);
        // Override point for customization after application launch.
        completionHandler(MAAdapterInitializationStatusDoesNotApply, nil);
        [[MaticooAds shareSDK] initSDK:appKey onSuccess:^() {
            completionHandler(MAAdapterInitializationStatusInitializedSuccess, nil);
        } onError:^(NSError* error) {
            completionHandler(MAAdapterInitializationStatusInitializedFailure, error.description);
        }];
    });
}

- (NSString *)SDKVersion
{
    return SDK_VERSION;
}

- (NSString *)adapterVersion
{
    return ADAPTER_VERSION;
}

#pragma mark - MAInterstitialAdapter Methods

- (void)loadInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate
{
    NSString *placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    NSLog(@"Loading interstitial ad: %@...", placementIdentifier);
        
    self.interstitial = [[MATInterstitialAd alloc] initWithPlacementID:placementIdentifier];
    self.interstitialAdapterDelegate = [[ALMaticooMediationAdapterInterstitialAdDelegate alloc] initWithParentAdapter: self andNotify: delegate];
    self.interstitial.delegate = self.interstitialAdapterDelegate;
    [self.interstitial loadAd];    
}

- (void)showInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate
{
    [self log: @"Showing interstitial: %@...", parameters.thirdPartyAdPlacementIdentifier];

    // Check if ad is already expired or invalidated, and do not show ad if that is the case. You will not get paid to show an invalidated ad.
    if (self.interstitial.isReady){
        [self.interstitial showAdFromRootViewController];
    }
    else
    {
        [self log: @"Unable to show interstitial ad: ad is not valid - marking as expired"];
        [delegate didFailToDisplayInterstitialAdWithError: MAAdapterError.adExpiredError];
    }
}

#pragma mark - MARewardedAdapter Methods

- (void)loadRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate
{
    NSString *placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    [self log: @"Loading rewarded ad: %@...", placementIdentifier];
    
    
    self.rewardedVideoAd = [[MATRewardedVideoAd alloc] initWithPlacementID: placementIdentifier];
    self.rewardedAdapterDelegate = [[ALMaticooMediationAdapterRewardedVideoAdDelegate alloc] initWithParentAdapter: self andNotify: delegate];
    self.rewardedVideoAd.delegate = self.rewardedAdapterDelegate;
    
    if ( [self.rewardedVideoAd isReady] )
    {
        [self log: @"A rewarded ad has been loaded already"];
        [delegate didLoadRewardedAd];
    }
    else
    {
        [self log: @"Loading bidding rewarded ad..."];
        [self.rewardedVideoAd loadAd];
    }
}

- (void)showRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate
{
    [self log: @"Showing rewarded ad: %@...", parameters.thirdPartyAdPlacementIdentifier];
    
    // Check if ad is already expired or invalidated, and do not show ad if that is the case. You will not get paid to show an invalidated ad.
    if ( [self.rewardedVideoAd isReady] )
    {
        UIViewController *presentingViewController;
        if ( ALSdk.versionCode >= 11020199 )
        {
            presentingViewController = parameters.presentingViewController ?: [ALUtils topViewControllerFromKeyWindow];
        }
        else
        {
            presentingViewController = [ALUtils topViewControllerFromKeyWindow];
        }
        
        [self.rewardedVideoAd showAdFromViewController:presentingViewController];
    }
    else
    {
        [self log: @"Unable to show rewarded ad: ad is not valid - marking as expired"];
        [delegate didFailToDisplayRewardedAdWithError: MAAdapterError.adExpiredError];
    }
}

- (void)loadAdViewAdForParameters:(id<MAAdapterResponseParameters>)parameters
                         adFormat:(MAAdFormat *)adFormat
                        andNotify:(id<MAAdViewAdapterDelegate>)delegate
{
    NSString *placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    BOOL isNative = [parameters.customParameters al_boolForKey: @"is_native"];
    
    [self log: @"Loading%@%@ ad: %@...", isNative ? @" native " : @" ", adFormat.label, placementIdentifier];
    
    if ( isNative )
    {
        self.nativeAd = [[MATNativeAd alloc] initWithPlacementID: placementIdentifier];
        self.nativeAdViewAdAdapterDelegate = [[ALMaticooMediationAdapterNativeAdViewAdDelegate alloc] initWithParentAdapter: self andNotify: delegate];
        self.nativeAd.delegate = self.nativeAdViewAdAdapterDelegate;
        [self log: @"Loading bidding native %@ ad...", adFormat.label];
        [self.nativeAd loadAd];
    }
    else
    {
        CGSize adSize = [self adSizeFromAdFormat: adFormat];
        self.bannerAdView = [[MATBannerAd alloc] initWithPlacementID:placementIdentifier];
        self.bannerAdView.frame = CGRectMake(0, 0, adSize.width, adSize.height);
        self.adViewAdapterDelegate = [[ALMaticooMediationAdapterAdViewDelegate alloc] initWithParentAdapter: self andNotify: delegate];
        self.bannerAdView.delegate = self.adViewAdapterDelegate;
        [self.bannerAdView loadAd];
        self.bannerAdView.frame = CGRectMake(0, 0, adSize.width, adSize.height);
    }
}

#pragma mark - MANativeAdAdapter Methods

- (void)loadNativeAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MANativeAdAdapterDelegate>)delegate
{
    NSDictionary<NSString *, id> *serverParameters = parameters.serverParameters;
    BOOL isNativeBanner = [serverParameters al_boolForKey: @"is_native_banner"];
    NSString *placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    [self log: @"Loading native %@ad: %@...", isNativeBanner ? @"banner " : @"" , placementIdentifier];
    dispatchOnMainQueue(^{
        self.nativeAd = [[MATNativeAd alloc] initWithPlacementID: placementIdentifier];
        self.nativeAdAdapterDelegate = [[ALMaticooMediationAdapterNativeAdDelegate alloc] initWithParentAdapter: self andNotify: delegate];
        self.nativeAd.delegate = self.nativeAdAdapterDelegate;
        [self.nativeAd loadAd];
    });
}

- (void)renderTrueNativeAd:(MATNativeAd *)nativeAd
                 andNotify:(id<MANativeAdAdapterDelegate>)delegate
{
    // `nativeAd` may be nil if the adapter is destroyed before the ad loaded (timed out).
    if ( !nativeAd )
    {
        [self log: @"Native ad failed to load: no fill"];
        [delegate didFailToLoadNativeAdWithError: MAAdapterError.noFill];
        
        return;
    }
    
//    if ( ![nativeAd isAdValid] )
//    {
//        [self log: @"Native ad failed to load: ad is no longer valid"];
//        [delegate didFailToLoadNativeAdWithError: MAAdapterError.adExpiredError];
//
//        return;
//    }
    
//    NSString *templateName = [serverParameters al_stringForKey: @"template" defaultValue: @""];
//    BOOL isTemplateAd = [templateName al_isValidString];
//    if ( isTemplateAd)
//    {
//        [self e: @"Native ad (%@) does not have required assets.", nativeAd];
//        [delegate didFailToLoadNativeAdWithError: [MAAdapterError errorWithCode: -5400 errorString: @"Missing Native Ad Assets"]];
//
//        return;
//    }
//
    // Ensure UI rendering is done on main queue
    dispatchOnMainQueue(^{
        
        MANativeAd *maxNativeAd = [[MAMaticooNativeAd alloc] initWithParentAdapter: self builderBlock:^(MANativeAdBuilder *builder) {
            builder.title = nativeAd.nativeElements.title;
            builder.body = nativeAd.nativeElements.describe;
            builder.callToAction = nativeAd.nativeElements.ctatext;
            builder.icon = [[MANativeAdImage alloc] initWithURL: [NSURL URLWithString:nativeAd.nativeElements.iconUrl]];
            builder.mediaView = nativeAd.nativeElements.mediaView;
            CGFloat mediaContentAspectRatio = 1.64;//nativeAd.nativeElements.aspectRatio;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            // Introduced in 11.4.0
            if ( [builder respondsToSelector: @selector(setMediaContentAspectRatio:)] )
            {
                [builder performSelector: @selector(setMediaContentAspectRatio:) withObject: @(mediaContentAspectRatio)];
            }
#pragma clang diagnostic pop
        }];
        
        [delegate didLoadAdForNativeAd: maxNativeAd withExtraInfo: nil];
    });
}

-(CGSize) adSizeFromAdFormat:(MAAdFormat*) adFormat{
    if ( adFormat == MAAdFormat.banner )
        {
            return CGSizeMake(320, 50);
        }
        else if ( adFormat == MAAdFormat.mrec )
        {
            return CGSizeMake(300, 250); 
        }
        else
        {
            [NSException raise: NSInvalidArgumentException format: @"Unsupported ad format: %@", adFormat];
            return CGSizeMake(0, 0);
        }
}

@end

@implementation ALMaticooMediationAdapterInterstitialAdDelegate

- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MAInterstitialAdapterDelegate>)delegate
{
    self = [super init];
    if ( self )
    {
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

- (void)interstitialAdDidLoad:(MATInterstitialAd *)interstitialAd{
    NSLog(@"interstitialAd interstitialAdDidLoad");
    [self.delegate didLoadInterstitialAd];
    return;
}

- (void)interstitialAd:(MATInterstitialAd *)interstitialAd didFailWithError:(NSError *)error{
    NSLog(@"interstitialAd didFailWithError, %@, %@", interstitialAd.placementID, error.description);
    MAAdapterError *adapterError = nil;
    [self.delegate didFailToLoadInterstitialAdWithError: adapterError];
}

- (void)interstitialAd:(MATInterstitialAd *)interstitialAd displayFailWithError:(NSError *)error{
    NSLog(@"interstitialAd displayFailWithError, %@", error.description);
}

- (void)interstitialAdWillLogImpression:(MATInterstitialAd *)interstitialAd{
    NSLog(@"interstitialAdWillLogImpression");
    [self.delegate didDisplayInterstitialAd];
}

- (void)interstitialAdDidClick:(MATInterstitialAd *)interstitialAd{
    NSLog(@"interstitialAdDidClick");
    [self.delegate didClickInterstitialAd];
}

- (void)interstitialAdWillClose:(MATInterstitialAd *)interstitialAd{
    NSLog(@"interstitialAdWillClose");
}

- (void)interstitialAdDidClose:(MATInterstitialAd *)interstitialAd{
    NSLog(@"interstitialAdDidClose");
    [self.delegate didHideInterstitialAd];
}

@end


@implementation ALMaticooMediationAdapterRewardedVideoAdDelegate

- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MARewardedAdapterDelegate>)delegate
{
    self = [super init];
    if ( self )
    {
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

//rewarded video delegate
- (void)rewardedVideoAdDidLoad:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.parentAdapter log: @"Rewarded ad loaded: %@", rewardedVideoAd.placementID];
    [self.delegate didLoadRewardedAd];
}

- (void)rewardedVideoAd:(MATRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error{
    MAAdapterError *adapterError = nil;
    [self.parentAdapter log: @"Rewarded ad (%@) failed to load with error: %@", rewardedVideoAd.placementID, adapterError];
    [self.delegate didFailToLoadRewardedAdWithError: adapterError];
}

- (void)rewardedVideoAd:(MATRewardedVideoAd *)rewardedVideoAd displayFailWithError:(NSError *)error{
    [self.parentAdapter log: @"Rewarded video displayFailWithError: %@", rewardedVideoAd.placementID];
    [self.delegate didFailToDisplayRewardedAdWithError: MAAdapterError.adDisplayFailedError];
}

- (void)rewardedVideoAdStarted:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.parentAdapter log: @"Rewarded video started: %@", rewardedVideoAd.placementID];
    [self.delegate didStartRewardedAdVideo];
}

- (void)rewardedVideoAdCompleted:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.parentAdapter log: @"Rewarded video completed: %@", rewardedVideoAd.placementID];
    [self.delegate didCompleteRewardedAdVideo];
}

- (void)rewardedVideoAdWillLogImpression:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.parentAdapter log: @"Rewarded video impression: %@", rewardedVideoAd.placementID];
    [self.delegate didDisplayRewardedAd];
    
}

- (void)rewardedVideoAdDidClick:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.parentAdapter log: @"Rewarded ad clicked: %@", rewardedVideoAd.placementID];
    [self.delegate didClickRewardedAd];
}

- (void)rewardedVideoAdDidClose:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.parentAdapter log: @"Rewarded ad hidden: %@", rewardedVideoAd.placementID];
    [self.delegate didHideRewardedAd];
}

- (void)rewardedVideoAdReward:(MATRewardedVideoAd *)rewardedVideoAd{
    MAReward *reward = [self.parentAdapter reward];
    [self.parentAdapter log: @"Rewarded user with reward: %@", reward];
    [self.delegate didRewardUserWithReward: reward];
}

- (void)rewardedVideoAdWillClose:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    
}

@end

@implementation ALMaticooMediationAdapterAdViewDelegate

- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MAAdViewAdapterDelegate>)delegate
{
    self = [super init];
    if ( self )
    {
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

- (void)bannerAdDidLoad:(nonnull MATBannerAd *)bannerAd {
    [self.parentAdapter log: @"Banner loaded: %@", bannerAd.placementID];
    [self.delegate didLoadAdForAdView: bannerAd];
}

- (void)bannerAd:(nonnull MATBannerAd *)bannerAd didFailWithError:(nonnull NSError *)error {
    MAAdapterError *adapterError = nil;
    [self.parentAdapter log: @"Banner (%@) failed to load with error: %@", bannerAd.placementID, adapterError];
    [self.delegate didFailToLoadAdViewAdWithError: adapterError];
}

- (void)bannerAdDidClick:(nonnull MATBannerAd *)bannerAd {
    [self.parentAdapter log: @"Banner clicked: %@", bannerAd.placementID];
    [self.delegate didClickAdViewAd];
    [self.delegate didExpandAdViewAd];
}

- (void)bannerAdDidImpression:(nonnull MATBannerAd *)bannerAd {
    [self.parentAdapter log: @"Banner shown: %@", bannerAd.placementID];
    [self.delegate didDisplayAdViewAd];
}
@end

@implementation ALMaticooMediationAdapterNativeAdViewAdDelegate

- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MAAdViewAdapterDelegate>)delegate{
    self = [super init];
    if ( self )
    {
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

- (void)nativeAdClicked:(nonnull MATNativeAd *)nativeAd {
    [self.parentAdapter log: @"Native clicked: %@", nativeAd.placementID];
    [self.delegate didClickAdViewAd];
    [self.delegate didExpandAdViewAd];
}

- (void)nativeAdClosed:(nonnull MATNativeAd *)nativeAd {
    
}

- (void)nativeAdDisplayFailed:(nonnull MATNativeAd *)nativeAd {
    
}

- (void)nativeAdDisplayed:(nonnull MATNativeAd *)nativeAd {
    [self.parentAdapter log: @"Native shown: %@", nativeAd.placementID];
    [self.delegate didDisplayAdViewAd];
}

- (void)nativeAdFailed:(nonnull MATNativeAd *)nativeAd withError:(nonnull NSError *)error {
    [self.parentAdapter log: @"Native (%@) failed to load with error: %@", nativeAd.placementID, error];
    [self.delegate didFailToLoadAdViewAdWithError: error];
}

- (void)nativeAdLoadSuccess:(nonnull MATNativeAd *)nativeAd {
    [self.parentAdapter log: @"Native ad loaded: %@", nativeAd.placementID];
    [self.parentAdapter renderTrueNativeAd: nativeAd
                                 andNotify: self.delegate];
}

@end

@implementation ALMaticooMediationAdapterNativeAdDelegate

- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter andNotify:(id<MANativeAdAdapterDelegate>)delegate{
    self = [super init];
    if ( self )
    {
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}
- (void)nativeAdClicked:(nonnull MATNativeAd *)nativeAd {
    [self.parentAdapter log: @"Native ad clicked: %@", nativeAd.placementID];
    [self.delegate didClickNativeAd];
}

- (void)nativeAdClosed:(nonnull MATNativeAd *)nativeAd {
    
}

- (void)nativeAdDisplayFailed:(nonnull MATNativeAd *)nativeAd {
    
}

- (void)nativeAdDisplayed:(nonnull MATNativeAd *)nativeAd {
    [self.parentAdapter log: @"Native ad shown: %@", nativeAd.placementID];
    [self.delegate didDisplayNativeAdWithExtraInfo: nil];
}

- (void)nativeAdFailed:(nonnull MATNativeAd *)nativeAd withError:(nonnull NSError *)error {
    MAAdapterError *adapterError = nil;
     [self.parentAdapter log: @"Native (%@) failed to load with error: %@",  nativeAd.placementID, adapterError];
     [self.delegate didFailToLoadNativeAdWithError: adapterError];
}

- (void)nativeAdLoadSuccess:(nonnull MATNativeAd *)nativeAd {
    [self.parentAdapter log: @"Native ad loaded: %@", nativeAd.placementID];
    [self.parentAdapter renderTrueNativeAd: nativeAd
                                 andNotify: self.delegate];
}

@end

@implementation MAMaticooNativeAd

- (instancetype)initWithParentAdapter:(MaticooMediationAdapter *)parentAdapter builderBlock:(NS_NOESCAPE MANativeAdBuilderBlock)builderBlock
{
    self = [super initWithFormat: MAAdFormat.native builderBlock: builderBlock];
    if ( self )
    {
        self.parentAdapter = parentAdapter;
    }
    return self;
}

- (void)prepareViewForInteraction:(MANativeAdView *)maxNativeAdView
{
    MATNativeAd *nativeAd = self.parentAdapter.nativeAd;
    [nativeAd registerViewForInteraction:maxNativeAdView iConView:maxNativeAdView.iconImageView CTAView:maxNativeAdView.callToActionButton];
    
}

@end
