//
//  NSTimer+ALSExtraMethod.h
//  ApplinsSDK
//
//  Created by Mirinda on 2018/4/10.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ALSADExtraMethod)
/**
 创建NSTimer
 
 @param seconds 回调间隔
 @param repeats 是否重复调用
 @param block  timer的回调
 */
+ (NSTimer *)ALSScheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

//暂停Timer
- (void)ALSPauseTimer;

//重启Timer
- (void)ALSResumeTimer;

//关闭Timer
- (void)ALSStopTimer;

//指定时间重启Timer
- (void)ALSResumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
