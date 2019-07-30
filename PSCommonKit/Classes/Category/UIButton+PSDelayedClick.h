//
//  UIButton+PSDelayedClick.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (PSDelayedClick)

/**
 时间间隔, 控制重复点击的间隔时间
 */
@property (nonatomic, assign) NSTimeInterval ps_timeInterval;

@end

NS_ASSUME_NONNULL_END
