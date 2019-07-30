//
//  UIImageView+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CommonKit)

/**
 *  创建一个有阴影效果
 *
 *  @param color   阴影的color(颜色)
 *  @param radius  阴影的radius(半径)
 *  @param offset  阴影的offset(偏移量)
 *  @param opacity S阴影的opacity(不透明度)
 */
- (void)ps_setImageShadowColor:(UIColor *)color
						radius:(CGFloat)radius
						offset:(CGSize)offset
					   opacity:(CGFloat)opacity;

@end

NS_ASSUME_NONNULL_END
