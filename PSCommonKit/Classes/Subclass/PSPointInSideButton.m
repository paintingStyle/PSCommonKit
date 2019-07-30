//
//  PSPointInSideButton.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "PSPointInSideButton.h"

@implementation PSPointInSideButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	
	//获取当前button的实际大小
	CGRect bounds = self.bounds;
	
	//若原热区小于44x44，则放大热区，否则保持原大小不变
	CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
	CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
	
	//扩大bounds 左右方向和上下方向扩大或缩小的长度。正值为缩小，负值为扩大
	bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
	
	//如果点击的点 在 新的bounds里，就返回YES
	return CGRectContainsPoint(bounds, point);
}

@end
