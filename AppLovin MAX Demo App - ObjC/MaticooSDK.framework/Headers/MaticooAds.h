//
//  MaticooAds.h
//  MaticooSDK
//
//  Created by root on 2023/4/10.
//

#import <Foundation/Foundation.h>
#import "MaticooError.h"

NS_ASSUME_NONNULL_BEGIN

@interface MaticooAds : NSObject
/**
 You should pass the singleton method to create the object, then calls the requests of the different types of ads.

 @return returns a global instance of Applins
 */
+ (instancetype)shareSDK;

/**
 Get Applins AD Config in Appdelegate(didFinishLaunchingWithOptions:)

 @param appKey Appkey
 */
- (void)initSDK:(NSString *)appKey onSuccess:(void(^)(void))success onError:(void(^)(NSError* error))errorcb;


-(BOOL)verifyPlacementID:(NSString*)placementID;

-(id)getPlacement:(NSString*) placementId;

-(BOOL)isInitSuccess;
@end

NS_ASSUME_NONNULL_END
