//
//  LECountDownTimer.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/8/30.
//

#import "LECountDownTimer.h"

static dispatch_source_t _timer;

@implementation LECountDownTimer

+ (void)startAsyncTimerWithSeconds:(long long)seconds
				  withSecondsBlock:(void(^)(long long seconds))secondsBlock
					  withEndBlock:(nullable void(^)(void))endBlock {
	
	__block long long timeout = seconds;
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0); // 高优先级执行，否则倒计时将不准确
	_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
	
	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
	
	dispatch_source_set_event_handler(_timer, ^{
		if (timeout<=0) { //倒计时结束，关闭
			dispatch_source_cancel(_timer);
			if (endBlock) { endBlock(); } // 内部切换主线程，可能造成计时不准确，需要外部自己处理
		}else {
			if (secondsBlock) { secondsBlock(timeout); }
			timeout--;
		}
	});
	dispatch_resume(_timer);
}

+ (void)endTimer {
	
	if (_timer) {
		dispatch_source_cancel(_timer);
		_timer = nil;
	}
}

@end
