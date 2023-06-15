//
//  NetworkManager.h
//  ApplinsSDK
//
//  Created by Mirinda on 16/5/30.
//  Copyright © 2016年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MATNetWorkManager : NSObject <NSURLSessionDelegate>
/**
 类方法进行初始化

 @return self
 */
+ (instancetype)manager;

/**
 Get请求

 @param path HOST URL
 @param params 参数字典
 @param isJson 是否需要Json解析
 @param complete 回调Block
 @return id
 */
+ (id)GET:(NSString *)path parameters:(NSDictionary *)params isRetJson:(BOOL)isJson completeHandler:(void(^)(id responseObj, NSError* error))complete;

/**
 Post请求

 @param path HOST URL
 @param params 参数字典
 @param complete 回调Block
 @return id
 */
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params postCiphertext:(BOOL)isCiphertext completeHandle:(void (^)(id responseObj, NSError* error))complete;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completeHandle:(void (^)(id responseObj, NSError* error))complete;
/**
 获取图片素材

 @param fileURL 图片URL
 @param image Image
 */
+(void)getImageFromURL:(NSString *)fileURL img:(void(^)(UIImage *ig))image;

/**
 获取当前设备的网络状态
 
 @return 0 = 没有网络，3 = 移动网络， 5 = wifi网络
 */
+ (int)getCurrentNetWorkState;

@end
