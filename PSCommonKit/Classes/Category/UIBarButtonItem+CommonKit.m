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

static const void *sp_available_key = &sp_available_key;

@implementation UIBarButtonItem (CommonKit)

- (BOOL)available {
	
	NSNumber *result = objc_getAssociatedObject(self, sp_available_key);
	
	return [result boolValue];
}

- (void)setAvailable:(BOOL)available {
	
	objc_setAssociatedObject(self, sp_available_key, @(available), OBJC_ASSOCIATION_ASSIGN);
	
	if ([self.customView isKindOfClass:[UIButton class]]) {
		((UIButton *)self.customView).enabled = available;
	}
}

+ (UIBarButtonItem *)sp_leftBarButtonItemWithTitle:(NSString *)title
										titleColor:(UIColor *)color
											target:(id)target
											action:(SEL)action {
	
	UIButton *btn = [UIButton ps_buttonWithTitle:title font:[UIFont systemFontOfSize:16] normalColor:color disabledColor:nil alignment:UIControlContentHorizontalAlignmentLeft target:target action:action];
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)sp_rightBarButtonItemWithTitle:(NSString *)title
										normalColor:(UIColor *)normalColor
									  disabledColor:(UIColor *)disabledColor
											 target:(id)target
											 action:(SEL)action {
	
	UIButton *btn = [UIButton ps_buttonWithTitle:title font:[UIFont systemFontOfSize:16] normalColor:normalColor disabledColor:disabledColor  alignment:UIControlContentHorizontalAlignmentRight target:target action:action];
	return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
