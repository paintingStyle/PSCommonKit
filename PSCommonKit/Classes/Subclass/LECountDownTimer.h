//
//  LECountDownTimer.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/8/30.
//  倒计时

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LECountDownTimer : NSObject

+ (void)startAsyncTimerWithSeconds:(long long)seconds
				  withSecondsBlock:(void(^)(long long seconds))secondsBlock
					  withEndBlock:(nullable void(^)(void))endBlock;

+ (void)endTimer;

@end

NS_ASSUME_NONNULL_END
