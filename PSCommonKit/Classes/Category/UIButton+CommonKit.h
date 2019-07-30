//
//  UIButton+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CommonKit)

+ (UIButton *)ps_buttonWithTitle:(NSString *)title
					 normalColor:(UIColor *)normalColor
				   disabledColor:(nullable UIColor *)disabledColor
					   alignment:(UIControlContentHorizontalAlignment)alignment
						  target:(id)target
						  action:(SEL)action;

+ (UIButton *)ps_buttonWithTitle:(NSString *)title
							font:(UIFont *)font
					 normalColor:(UIColor *)normalColor
				   disabledColor:(nullable UIColor *)disabledColor
					   alignment:(UIControlContentHorizontalAlignment)alignment
						  target:(id)target
						  action:(SEL)action;


@end

NS_ASSUME_NONNULL_END
