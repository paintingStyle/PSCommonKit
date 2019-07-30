//
//  UIView+PSIBInspectable.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIView+PSIBInspectable.h"

@implementation UIView (PSIBInspectable)

- (void)setPs_cornerRadius:(CGFloat)ps_cornerRadius {
	
	self.layer.cornerRadius = ps_cornerRadius;
	self.layer.masksToBounds = YES;
	// 栅格化 - 提高性能
	// 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
	self.layer.rasterizationScale = [UIScreen mainScreen].scale;
	self.layer.shouldRasterize = YES;
}

- (void)setPs_borderColor:(UIColor *)ps_borderColor {
	
	self.layer.borderColor = ps_borderColor.CGColor;
}

- (void)setPs_borderWidth:(CGFloat)ps_borderWidth {
	
	UIColor *borderColor = self.ps_borderColor ? :[UIColor lightGrayColor];
	
	self.layer.borderColor = borderColor.CGColor;
	self.layer.borderWidth = ps_borderWidth;
}

- (CGFloat)ps_cornerRadius {
	
	return self.layer.cornerRadius;
}

- (CGFloat)ps_borderWidth {
	
	return self.layer.borderWidth;
}
- (UIColor *)ps_borderColor{
	
	return [UIColor colorWithCGColor:self.layer.borderColor];
}

@end
