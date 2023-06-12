//
//  MATErrorHandler.h
//  MaticooSDK
//
//  Created by root on 2023/4/11.
//

#import <Foundation/Foundation.h>
#import "MaticooError.h"

NS_ASSUME_NONNULL_BEGIN

@interface MATErrorHandler : NSObject
+ (NSError*)getErrorWithALSError:(MaticooError)MATError withAdType:(NSString*)adType additionalInfo:(NSString*)info andOfferId:(NSString*)offerid;
@end

NS_ASSUME_NONNULL_END
