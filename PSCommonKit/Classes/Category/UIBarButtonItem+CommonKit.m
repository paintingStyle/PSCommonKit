//
//  UIBarButtonItem+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIBarButtonItem+CommonKit.h"
#import "UIButton+CommonKit.h"
#import <objc/runtime.h>

static const void *ps_available_key = &ps_available_key;

@implementation UIBarButtonItem (CommonKit)

- (BOOL)ps_available {
	
	NSNumber *result = objc_getAssociatedObject(self, ps_available_key);
	
	return [result boolValue];
}

- (void)setPs_available:(BOOL)ps_available {
	
	objc_setAssociatedObject(self, ps_available_key, @(ps_available), OBJC_ASSOCIATION_ASSIGN);
	
	if ([self.customView isKindOfClass:[UIButton class]]) {
		((UIButton *)self.customView).enabled = ps_available;
	}
}

+ (UIBarButtonItem *)ps_leftBarButtonItemWithTitle:(NSString *)title
										titleColor:(UIColor *)color
											target:(id)target
											action:(SEL)action {
	
	UIButton *btn = [UIButton ps_buttonWithTitle:title font:[UIFont systemFontOfSize:14] normalColor:color disabledColor:nil alignment:UIControlContentHorizontalAlignmentLeft target:target action:action];
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)ps_leftBarButtonItemWithTitle:(NSString *)title
										titleColor:(UIColor *)color
											  font:(UIFont *)font
											target:(id)target
											action:(SEL)action {
	
	UIButton *btn = [UIButton ps_buttonWithTitle:title font:font normalColor:color disabledColor:nil alignment:UIControlContentHorizontalAlignmentLeft target:target action:action];
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



+ (UIBarButtonItem *)ps_rightBarButtonItemWithTitle:(NSString *)title
										normalColor:(UIColor *)normalColor
									  disabledColor:(nullable UIColor *)disabledColor
											 target:(id)target
											 action:(SEL)action {
	
	UIButton *btn = [UIButton ps_buttonWithTitle:title font:[UIFont systemFontOfSize:14] normalColor:normalColor disabledColor:disabledColor  alignment:UIControlContentHorizontalAlignmentRight target:target action:action];
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)ps_rightBarButtonItemWithTitle:(NSString *)title
										normalColor:(UIColor *)normalColor
									  disabledColor:(nullable UIColor *)disabledColor
											   font:(UIFont *)font
											 target:(id)target
											 action:(SEL)action {
	
	UIButton *btn = [UIButton ps_buttonWithTitle:title font:font normalColor:normalColor disabledColor:disabledColor  alignment:UIControlContentHorizontalAlignmentRight target:target action:action];
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
