//
//  UIBarButtonItem+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (CommonKit)

/// 自定义按钮是否可用
@property (nonatomic, assign) BOOL ps_available;

+ (UIBarButtonItem *)ps_leftBarButtonItemWithTitle:(NSString *)title
										titleColor:(UIColor *)color
											target:(id)target
											action:(SEL)action;

+ (UIBarButtonItem *)ps_leftBarButtonItemWithTitle:(NSString *)title
										titleColor:(UIColor *)color
											  font:(UIFont *)font
											target:(id)target
											action:(SEL)action;



+ (UIBarButtonItem *)ps_rightBarButtonItemWithTitle:(NSString *)title
										normalColor:(UIColor *)normalColor
									  disabledColor:(nullable UIColor *)disabledColor
											 target:(id)target
											 action:(SEL)action;

+ (UIBarButtonItem *)ps_rightBarButtonItemWithTitle:(NSString *)title
										normalColor:(UIColor *)normalColor
									  disabledColor:(nullable UIColor *)disabledColor
											   font:(UIFont *)font
											 target:(id)target
											 action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
