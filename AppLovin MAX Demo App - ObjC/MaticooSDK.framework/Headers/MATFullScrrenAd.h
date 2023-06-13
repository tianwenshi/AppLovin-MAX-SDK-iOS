//
//  MATFullScrrenAd.h
//  MaticooSDK
//
//  Created by root on 2023/5/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MATModalViewController.h"
#import "MATWebview.h"
#import "MATAdModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MATFullScrrenAd : NSObject
@property (nonatomic, strong) MATAdModel* ad;
@property (nonatomic, strong) MATModalViewController* modalViewController;
@property (nonatomic, assign) BOOL isReady;
@property (nonatomic, strong) MATWebview *__nullable matWebview;
@property (nonatomic, assign) BOOL isVideo;
@property (nonatomic, strong) NSMutableDictionary* baseDictionary;
@property (nonatomic, strong) NSString* placementID;
@property (nonatomic, assign) BOOL isLoading;
- (void)closeControlEvent;
- (void)prepareCloseButton;
- (void)presentModalView:(UIView*)view UIController:(UIViewController*) viewController;
- (void)cacheMediaFiles:(NSArray*)mediaFiles resources:(NSArray*)resources;
- (NSInteger)getAdType;
@end

NS_ASSUME_NONNULL_END
