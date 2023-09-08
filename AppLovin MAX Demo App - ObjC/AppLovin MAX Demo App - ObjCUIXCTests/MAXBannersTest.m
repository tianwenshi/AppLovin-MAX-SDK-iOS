//
//  MAXBannersTest.m
//  AppLovin MAX Demo App - ObjCUIXCTests
//
//  Created by Mirinda on 2023/9/7.
//  Copyright © 2023 AppLovin Corporation. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MAXBannersTest : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation MAXBannersTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [self.app terminate];
    self.app = nil;
}

- (void)testBannersShow {
    XCUIElement *cell = self.app.staticTexts[@"MAX Banners"];
    !cell.exists ?: [cell tap];
    sleep(2);
    XCUIElement *title = self.app.staticTexts[@"Banners"];
    XCTAssertTrue(title.exists, @"Not entering the banner page.");
    sleep(2);
    XCUIElement *autoCell = self.app.staticTexts[@"Auto Layout Banners"];
    !autoCell.exists ?: [autoCell tap];
    sleep(5);
    XCUIElement *titleText = self.app.staticTexts[@"-[ALMAXAutoLayoutBannerAdViewController didPayRevenueForAd:]"];
    XCTAssertTrue(titleText.exists, @"Banner ad not show.");
    sleep(3);
    
    XCUIElement *btn = self.app.buttons[@"Banners"];
    !btn.exists ?: [btn tap];
    sleep(2);
    
    XCUIElement *Frame = self.app.staticTexts[@"Frame Layout Banners"];
    !Frame.exists ?: [Frame tap];
    sleep(5);
    XCUIElement *titleText1 = self.app.staticTexts[@"-[ALMAXFrameLayoutBannerAdViewController didPayRevenueForAd:]"];
    XCTAssertTrue(titleText1.exists, @"Banner ad not show.");
    sleep(3);

    XCUIElement *backBtn = self.app.buttons[@"Banners"];
    !backBtn.exists ?: [backBtn tap];
    sleep(2);
}

//- (void)testExample {
//    // UI tests must launch the application that they test.
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    [app launch];
//
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}
//
//- (void)testLaunchPerformance {
//    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)) {
//        // This measures how long it takes to launch your application.
//        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
//            [[[XCUIApplication alloc] init] launch];
//        }];
//    }
//}

@end
