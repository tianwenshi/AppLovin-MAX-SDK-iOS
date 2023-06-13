//
//  MATSpalshAd.h
//  MaticooSDK
//
//  Created by root on 2023/6/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MATFullScrrenAd.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MATSpalshAdDelegate;

@interface MATSpalshAd : MATFullScrrenAd
@property (nonatomic, weak) id<MATSpalshAdDelegate> delegate;
- (MATSpalshAd*)initWithPlacementID:(NSString*)placementID;
- (void)loadAd;
- (void)showAdFromViewController:(UIViewController*) vc;
- (void)showAdFromRootViewController;
@end

@protocol MATSpalshAdDelegate <NSObject>
- (void)splashAdDidLoad:(MATSpalshAd *)splashAd;
- (void)splashAd:(MATSpalshAd *)splashAd didFailWithError:(NSError *)error;
- (void)splashAd:(MATSpalshAd *)splashAd displayFailWithError:(NSError *)error;
- (void)splashAdWillLogImpression:(MATSpalshAd *)splashAd;
- (void)splashAdDidClick:(MATSpalshAd *)splashAd;
- (void)splashAdWillClose:(MATSpalshAd *)splashAd;
- (void)splashAdDidClose:(MATSpalshAd *)splashAd;
@end

NS_ASSUME_NONNULL_END
