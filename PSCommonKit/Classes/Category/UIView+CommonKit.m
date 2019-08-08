//
//  UIView+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIView+CommonKit.h"

@implementation UIView (CommonKit)

#pragma mark - ps_top

- (void)setPs_top:(CGFloat)ps_top {
	CGRect frame = self.frame;
	frame.origin.y = ps_top;
	self.frame = frame;
}

- (CGFloat)ps_top {
	
	return CGRectGetMinX(self.frame);
}

#pragma mark - ps_left

- (void)setPs_left:(CGFloat)ps_left {
	
	CGRect frame = self.frame;
	frame.origin.x = ps_left;
	self.frame = frame;
}

- (CGFloat)ps_left {
	return CGRectGetMinY(self.frame);
}

#pragma mark - ps_bottom

- (void)setPs_bottom:(CGFloat)ps_bottom {
	CGRect frame = self.frame;
	frame.origin.y = ps_bottom-frame.size.height;
	self.frame = frame;
}

- (CGFloat)ps_bottom {
	
	return CGRectGetMaxY(self.frame);
}

#pragma mark - ps_right

- (void)setPs_right:(CGFloat)ps_right {
	CGRect frame = self.frame;
	frame.origin.x = ps_right-frame.size.width;
	self.frame = frame;
}

- (CGFloat)ps_right {
	
	return CGRectGetMaxX(self.frame);
}

#pragma mark - ps_x

-(void)setPs_x:(CGFloat)ps_x {
	
	CGRect frame = self.frame;
	frame.origin.x = ps_x;
	self.frame = frame;
}

-(CGFloat)ps_x{
	
	return self.frame.origin.x;
}

#pragma mark - ps_y

-(void)setPs_y:(CGFloat)ps_y {
	
	CGRect frame = self.frame;
	frame.origin.y = ps_y;
	self.frame = frame;
}

- (CGFloat)ps_y {
	
	return self.frame.origin.y;
}

#pragma mark - ps_width

-(void)setPs_width:(CGFloat)ps_width {
	
	CGRect frame = self.frame;
	frame.size.width = ps_width;
	self.frame = frame;
}
- (CGFloat)ps_width
{
	return self.frame.size.width;
}

#pragma mark - ps_height

-(void)setPs_height:(CGFloat)ps_height {
	
	CGRect frame = self.frame;
	frame.size.height = ps_height;
	self.frame = frame;
}

- (CGFloat)ps_height {
	
	return self.frame.size.height;
}

#pragma mark - ps_size

-(void)setPs_size:(CGSize)ps_size{
	
	CGRect frame = self.frame;
	frame.size = ps_size;
	self.frame = frame;
}

- (CGSize)ps_size {
	
	return self.frame.size;
}

#pragma mark - ps_origin

-(void)setPs_origin:(CGPoint)ps_origin {
	
	CGRect frame = self.frame;
	frame.origin = ps_origin;
	self.frame = frame;
}

- (CGPoint)ps_origin {
	
	return self.frame.origin;
}

#pragma mark - ps_center

- (void)setPs_center:(CGPoint)ps_center {
	
	self.center = ps_center;
}

- (CGPoint)ps_center {
	
	return self.center;
}

#pragma mark - ps_MidX

- (CGFloat)ps_MidX {
	
	return CGRectGetMidX(self.frame);
}

#pragma mark - ps_MidY

- (CGFloat)ps_MidY {
	
	return CGRectGetMidY(self.frame);
}

#pragma mark - ps_MaxX

- (CGFloat)ps_MaxX {
	
	return CGRectGetMaxX(self.frame);
}

#pragma mark - ps_MaxY

- (CGFloat)ps_MaxY {
	
	return CGRectGetMaxY(self.frame);
}


+ (instancetype)ps_viewFromXib {
	return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)ps_addShadowColor:(UIColor *)color
			 shadowOffset:(CGSize)shadowOffset
			shadowOpacity:(CGFloat)shadowOpacity
			 shadowRadius:(CGFloat)shadowRadius
			 cornerRadius:(CGFloat)cornerRadius {
	
	self.layer.shadowColor = color.CGColor;//阴影颜色
	self.layer.shadowOffset = shadowOffset;//偏移距离
	self.layer.shadowOpacity = shadowOpacity;//不透明度
	self.layer.shadowRadius = shadowRadius;//半径
	self.layer.cornerRadius = cornerRadius;
	self.layer.masksToBounds = NO;
}

- (void)ps_addShadowWithOffest:(CGSize)ofeest {
	
	self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
	self.layer.shadowOffset = ofeest;
	self.layer.shadowOpacity = 0.8;
	self.layer.shadowRadius = 5;
}
- (void)ps_addShadowWithOffest:(CGSize)ofeest
						 color:(UIColor *)color {
	
	self.layer.shadowColor = color.CGColor;
	self.layer.shadowOffset = ofeest;
	self.layer.shadowOpacity = 0.8;
	self.layer.shadowRadius = 5;
}

- (void)ps_hideShadow {
	
	self.layer.shadowOpacity = 0;
}

- (UIImage *)ps_convertViewToImage {
	
	UIGraphicsBeginImageContext(self.bounds.size);
	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
	UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return screenshot;
}

/*
 调用CATransition需要在frameworks中添加QuartzCore.framework，在.h文件中加入  #import <QuartzCore/QuartzCore.h>
 
 setType:有四种类型：
 kCATransitionFade   //交叉淡化过渡
 kCATransitionMoveIn //移动覆盖原图
 kCATransitionPush   //新视图将旧视图推出去
 kCATransitionReveal //底部显出来
 
 setSubtype:有四种类型：
 kCATransitionFromRight；
 kCATransitionFromLeft(默认值)
 kCATransitionFromTop；
 kCATransitionFromBottom
 
 type：动画过渡类型
 subtype：动画过渡方向
 startProgress：动画起点(在整体动画的百分比)
 endProgress：动画终点(在整体动画的百分比)
 
 fade                 交叉淡化效果 默认          0
 push                 新视图把旧视图推出去         1
 moveIn               新视图移动到旧视图上面         2
 reveal               将旧视图移开 显示下面的新视图     3
 cube                 立方体翻转效果                   4
 oglFlip              上下左右翻转                      5
 suckEffect           收缩效果(不可更改方向)               6
 rippleEffect         水滴效果(不可更改方向)                7
 pageCurl             向上翻页效果                          8
 pageUnCurl           向下翻页效果                             9
 cameraIrisHollowOpen 相机打开效果(不可更改方向)                10
 cameraIrisHollowClose相机关闭效果(不可更改方向)                  11
 */
-(void)ps_transitionAnimationDuration:(CGFloat)duration andAnimationMode:(NSInteger)mode transitionDirection:(TransitionDirection)
direction {
	
	//动画模式
	NSArray *animationModeArr=@[@"fade",
								@"push",
								@"moveIn",
								@"reveal",
								@"cube",
								@"oglFlip",
								@"suckEffect",
								@"rippleEffect",
								@"pageCurl",
								@"pageUnCurl",
								@"cameraIrisHollowOpen",
								@"cameraIrisHollowClose"];
	//创建转场动画对象
	CATransition *transition=[[CATransition alloc]init];
	//设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
	transition.type=animationModeArr[mode];
	//设置子类型（动画的方向）
	switch (direction) {
		case TransitionDirectionNone:
			break;
		case TransitionDirectionTop:
			transition.subtype = kCATransitionFromTop;
			break;
		case TransitionDirectionBottom:
			transition.subtype = kCATransitionFromBottom;
			break;
		case TransitionDirectionLeft:
			transition.subtype = kCATransitionFromLeft;
			break;
		case TransitionDirectionRight:
			transition.subtype = kCATransitionFromRight;
			break;
	};
	//设置动画时间
	transition.duration = duration;
	//加载动画
	[self.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

- (void)ps_scalingAnimationDuration:(CGFloat)duration fast:(BOOL)fast{
	
	if (fast) {
		//缩放效果  快速
		CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
		pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		pulse.duration = duration;
		pulse.repeatCount = 0;
		pulse.autoreverses = YES;
		pulse.fromValue = [NSNumber numberWithFloat:0.95];
		pulse.toValue = [NSNumber numberWithFloat:1.0];
		[self.layer addAnimation:pulse forKey:nil];
	}else {
		// 缩放效果 平速
		CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
		animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
		animation.duration = duration;
		animation.calculationMode = kCAAnimationCubic;
		[self.layer addAnimation:animation forKey:nil];
	}
}

- (void)ps_opacityAnimationDuration:(CGFloat)duration repeatCount:(CGFloat)count {
	
	//CALayer中opacity是一个浮点值，取值范围0~1.0,表示从完全透明到完全不透明
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath : @"opacity" ];
	animation.fromValue = [NSNumber numberWithFloat : 1.0f ];
	animation.toValue = [NSNumber numberWithFloat : 0.0f ];
	animation.autoreverses = YES ;
	animation.duration = duration;
	animation.repeatCount = count;
	animation.removedOnCompletion = NO ;
	animation.fillMode = kCAFillModeForwards ;
	//没有的话是均匀的动画。
	animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn ];
	[self.layer addAnimation:animation forKey:nil];
}

@end
