//
//  PSTaskTimer.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "PSTaskTimer.h"

@implementation PSTaskTimer

static NSMutableDictionary *_timers;
static dispatch_semaphore_t _semaphore;

+ (void)initialize {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_timers = [NSMutableDictionary dictionary];
		_semaphore = dispatch_semaphore_create(1);
	});
}

+ (NSString *)executeSyncTaskWithBlock:(void(^)(long long seconds))block
							  interval:(NSTimeInterval)interval {
	
	return [self executeTaskWithBlock:block
								start:0
							 interval:interval
							   leeway:0
							  repeats:YES
								async:NO];
}

+ (NSString *)executeAsyncTaskWithBlock:(void(^)(long long seconds))block
							   interval:(NSTimeInterval)interval {
	
	return [self executeTaskWithBlock:block
								start:0
							 interval:interval
							   leeway:0
							  repeats:YES
								async:YES];
}

+ (NSString *)executeTaskWithBlock:(void(^)(long long seconds))block
							 start:(NSTimeInterval)start
						  interval:(NSTimeInterval)interval
							leeway:(NSTimeInterval)leeway
						   repeats:(BOOL)repeats
							 async:(BOOL)async {
	
	// 没有任务、重复执行且间隔小于0， 视为无效操作
	if (!block || (interval <= 0 && repeats))  return nil;
	start = start >0 ? start:DISPATCH_TIME_NOW;
	leeway = leeway >0 ? leeway:0;
	
	// 队列
	dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
	
	// https://www.jianshu.com/p/6670cdbb1ebb
	// 创建一个新的调度源来监视低级别的系统对象和自动提交处理程序块来响应事件调度队列
	dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	
	// 开始时间
	dispatch_time_t start_time = dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC);
	// 间隔时间
	uint64_t interval_time = interval * NSEC_PER_SEC;
	
	// 为一个定时源设置一个开始时间、事件间隔、误差值
	/**
	 start:是我们设定的计时开始时间，可以dispatch_time 和  dispatch_walltime 函数来创建它们
	 leeway:告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器没五秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每十分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。这样可以降低资源消耗。如果系统可以让cpu休息足够长的时间，并在每次醒来的时候执行一个任务集合，而不是不断的醒来睡去以执行任务，那么系统会更高效。
	 */
	dispatch_source_set_timer(timer, start_time, interval_time, leeway);
	
	// 保证_timers数据安全
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	
	// timer identifier
	NSString *timerIdentifier = [NSString stringWithFormat:@"%zd", _timers.count];
	[_timers setObject:timer forKey:timerIdentifier];
	
	dispatch_semaphore_signal(_semaphore);
	
	// 为timer设置task
	__block long long executeSeconds = 0;
	dispatch_source_set_event_handler(timer, ^{
		executeSeconds = executeSeconds +interval;
		dispatch_async(dispatch_get_main_queue(), ^{
			block(executeSeconds);
		});
		if (!repeats) {
			[PSTaskTimer cancelTaskWithIdentifier:timerIdentifier];
		}
	});
	
	// 开始执行timer
	dispatch_resume(timer);
	
	return timerIdentifier;
}

+ (void)cancelTaskWithIdentifier:(NSString *)identifier {
	
	if (!identifier.length) return;
	
	// 保证_timers数据安全
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	dispatch_source_t timer = [_timers objectForKey:identifier];
	if (timer) {
		dispatch_cancel(timer);
		[_timers removeObjectForKey:identifier];
	}
	dispatch_semaphore_signal(_semaphore);
}

+ (void)suspendTaskWithIdentifier:(NSString *)identifier {
	
	if (!identifier.length) return;
	
	// 保证_timers数据安全
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	dispatch_source_t timer = [_timers objectForKey:identifier];
	if (timer) {
		dispatch_suspend(timer);
	}
	dispatch_semaphore_signal(_semaphore);
}

+ (void)resumeTaskWithIdentifier:(NSString *)identifier {
	
	if (!identifier.length) return;
	
	// 保证_timers数据安全
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	dispatch_source_t timer = [_timers objectForKey:identifier];
	if (timer) {
		dispatch_resume(timer);
	}
	dispatch_semaphore_signal(_semaphore);
}

+ (void)cancelAllTask {
	
	dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
	for (dispatch_source_t timer in _timers.allValues) {
		if (timer) { dispatch_cancel(timer); }
	}
	[_timers removeAllObjects];
	dispatch_semaphore_signal(_semaphore);
}

@end
