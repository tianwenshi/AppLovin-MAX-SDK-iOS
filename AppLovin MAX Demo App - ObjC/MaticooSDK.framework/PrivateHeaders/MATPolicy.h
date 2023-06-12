//
//  MATPolicy.h
//  MaticooSDK
//
//  Created by root on 2023/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define about_child_description  @"aboutChildDescription"

@interface MATPolicy : NSObject

+ (void)changeGDPRPrivacyPolicyState:(NSString *)gdprstate;
+ (NSString *)GDPRPrivacyPolicyState;
+ (void)setChildDescription:(NSString *)description; //设置儿童描述
+ (NSString *)getChildDescription; //获取儿童描述

@end

NS_ASSUME_NONNULL_END
