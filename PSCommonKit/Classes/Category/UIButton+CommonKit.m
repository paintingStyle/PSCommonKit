//
//  UIButton+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIButton+CommonKit.h"

@implementation UIButton (CommonKit)

+ (UIButton *)ps_buttonWithTitle:(NSString *)title
					 normalColor:(UIColor *)normalColor
				   disabledColor:(UIColor *)disabledColor
					   alignment:(UIControlContentHorizontalAlignment)alignment
						  target:(id)target
						  action:(SEL)action {
	
	CGFloat w = MIN(title.length *18, 100);
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = CGRectMake(0, 0, MAX(w, 44), 44);
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setTitleColor:normalColor forState:UIControlStateNormal];
	[btn setTitleColor:disabledColor forState:UIControlStateDisabled];
	btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
	[btn setContentHorizontalAlignment:alignment];
	[btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	return btn;
}

+ (UIButton *)ps_buttonWithTitle:(NSString *)title
							font:(UIFont *)font
					 normalColor:(UIColor *)normalColor
				   disabledColor:(UIColor *)disabledColor
					   alignment:(UIControlContentHorizontalAlignment)alignment
						  target:(id)target
						  action:(SEL)action {
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.titleLabel.font = font;
	btn.frame = CGRectMake(0, 0, 44, 44);
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setTitleColor:normalColor forState:UIControlStateNormal];
	[btn setTitleColor:disabledColor forState:UIControlStateDisabled];
	btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
	[btn setContentHorizontalAlignment:alignment];
	[btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	return btn;
}


@end
