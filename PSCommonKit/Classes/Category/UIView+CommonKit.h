//
//  UIView+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 动画过渡方向 */
typedef NS_ENUM(NSInteger,TransitionDirection) {
	
	TransitionDirectionNone = -1,
	TransitionDirectionTop,
	TransitionDirectionBottom,
	TransitionDirectionLeft,
	TransitionDirectionRight,
};

@interface UIView (CommonKit)

#pragma mark - AdjustFrame

@property (assign, nonatomic) CGFloat ps_x;
@property (assign, nonatomic) CGFloat ps_y;
@property (assign, nonatomic) CGFloat ps_width;
@property (assign, nonatomic) CGFloat ps_height;
@property (assign, nonatomic) CGSize  ps_size;
@property (assign, nonatomic) CGPoint ps_origin;
@property (assign, nonatomic) CGPoint ps_center;
@property (assign, nonatomic) CGFloat ps_top;
@property (assign, nonatomic) CGFloat ps_left;
@property (assign, nonatomic) CGFloat ps_bottom;
@property (assign, nonatomic) CGFloat ps_right;

@property (assign, nonatomic, readonly) CGFloat ps_MidX;
@property (assign, nonatomic, readonly) CGFloat ps_MidY;
@property (assign, nonatomic, readonly) CGFloat ps_MaxX;
@property (assign, nonatomic, readonly) CGFloat ps_MaxY;


+ (instancetype)ps_viewFromXib;

/**
 添加阴影,masksToBounds需为NO
 
 @param color 阴影颜色
 @param shadowOffset 阴影偏移量
 @param shadowOpacity 阴影颜色透明度
 @param shadowRadius 阴影半径
 @param cornerRadius 视图半径
 */
- (void)ps_addShadowColor:(UIColor *)color
			 shadowOffset:(CGSize)shadowOffset
			shadowOpacity:(CGFloat)shadowOpacity
			 shadowRadius:(CGFloat)shadowRadius
			 cornerRadius:(CGFloat)cornerRadius;

/** 截屏 */
- (UIImage *)ps_convertViewToImage;

/** 转场动画 类型索引 0 ~11 */
- (void)ps_transitionAnimationDuration:(CGFloat)duration
					  andAnimationMode:(NSInteger)mode
				   transitionDirection:(TransitionDirection)direction;

/** 缩放效果动画 fast 是否快速动画 */
- (void)ps_scalingAnimationDuration:(CGFloat)duration fast:(BOOL)fast;

/** 透明度闪烁效果 */
- (void)ps_opacityAnimationDuration:(CGFloat)duration repeatCount:(CGFloat)count;

@end

NS_ASSUME_NONNULL_END
