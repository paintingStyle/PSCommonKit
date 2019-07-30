//
//  PSTaskTimer.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 TODO: 此API为系统级定时器，在后台仍然会执行，若不需要可参考下面代码：
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNoti) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNoti) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
 
 - (void)dealloc{
 [[NSNotificationCenter defaultCenter] removeObserver:self];
 }
 
 
 // 在后台暂停任务，回到前台继续请求
 - (void)enterForegroundNoti {
 [SPTimer resumeTaskWithIdentifier:self.timerIdentifier];
 }
 
 - (void)enterBackgroundNoti {
 [SPTimer suspendTaskWithIdentifier:self.timerIdentifier];
 }
 
 */

NS_ASSUME_NONNULL_BEGIN

@interface PSTaskTimer : NSObject

/**
 执行定时任务（同步）
 
 @param block 执行任务block
 @param interval 间隔时间
 @return 定时任务标识
 */
+ (NSString *)executeSyncTaskWithBlock:(void(^)(long long seconds))block
							  interval:(NSTimeInterval)interval;


/**
 执行定时任务（异步）
 
 @param block 执行任务block
 @param interval 间隔时间
 @return 定时任务标识
 */
+ (NSString *)executeAsyncTaskWithBlock:(void(^)(long long seconds))block
							   interval:(NSTimeInterval)interval;

/**
 执行定时任务
 
 @param block 执行任务block
 @param start 开启时间
 @param interval 间隔时间
 @param leeway 计时器的误差精度，根据需求传递，希望准确传0即可
 leeway:告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器没五秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每十分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。这样可以降低资源消耗。如果系统可以让cpu休息足够长的时间，并在每次醒来的时候执行一个任务集合，而不是不断的醒来睡去以执行任务，那么系统会更高效。
 
 @param repeats 是否重复执行
 @param async 是否异步执行
 @return 定时任务标识
 */
+ (NSString *)executeTaskWithBlock:(void(^)(long long seconds))block
							 start:(NSTimeInterval)start
						  interval:(NSTimeInterval)interval
							leeway:(NSTimeInterval)leeway
						   repeats:(BOOL)repeats
							 async:(BOOL)async;

/**
 取消定时任务
 
 @param identifier 定时任务标识
 */
+ (void)cancelTaskWithIdentifier:(NSString *)identifier;

/**
 暂定定时任务
 
 @param identifier 定时任务标识
 */
+ (void)suspendTaskWithIdentifier:(NSString *)identifier;

/**
 恢复定时任务
 
 @param identifier 定时任务标识
 */
+ (void)resumeTaskWithIdentifier:(NSString *)identifier;

/**
 取消全部定时任务
 */
+ (void)cancelAllTask;

@end

NS_ASSUME_NONNULL_END
