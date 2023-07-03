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
 @param appKey Appkey
 */

- (void)initSDK:(NSString *)appKey onSuccess:(void(^)(void))success onError:(void(^)(NSError* error))errorcb;
/**
 * If set to TRUE, the server will not display personalized ads based on the user's personal information.
 * When receiving the user's request, and will not synchronize the user's information to other third-party partners.
 * Default is FALSE.
 * @param status 
 */

-(void)setDoNotTrackStatus:(BOOL) status;

-(void)setConsentStatus:(BOOL) status;

-(void)setIsAgeRestrictedUser:(BOOL) status;

-(BOOL)verifyPlacementID:(NSString*)placementID;

-(id)getPlacement:(NSString*) placementId;

-(BOOL)isInitSuccess;

-(id)getPlsInstance:(NSString*) placementId;

-(void)addPlsInstance:(NSString*) placementId object:(NSObject*)obj;
@end

NS_ASSUME_NONNULL_END
