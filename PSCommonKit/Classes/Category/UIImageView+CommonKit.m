//
//  UIImageView+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIImageView+CommonKit.h"

@implementation UIImageView (CommonKit)

- (void)ps_setImageShadowColor:(UIColor * _Nonnull)color
						radius:(CGFloat)radius
						offset:(CGSize)offset
					   opacity:(CGFloat)opacity {
	
	self.layer.shadowColor = color.CGColor;
	self.layer.shadowRadius = radius;
	self.layer.shadowOffset = offset;
	self.layer.shadowOpacity = opacity;
	self.clipsToBounds = NO;
}

@end
