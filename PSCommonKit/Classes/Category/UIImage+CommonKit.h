//
//  UIImage+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CommonKit)

/**
 *  给图片增加圆角及边框
 *
 *  @param radius 圆角弧度
 *
 *  @param borderWidth 边框宽
 *
 *  @param borderColor 边框颜色
 *
 *  @return 处理后的Image
 */
- (UIImage * _Nonnull)ps_imageByRoundCornerRadius:(CGFloat)radius
									  borderWidth:(CGFloat)borderWidth
									  borderColor:(UIColor * _Nullable)borderColor;

/**
 *  根据image本身创建指定rect的image
 *
 *  @param rect 指定的rect
 *
 *  @return 返回指定rect所创建的image
 */
- (UIImage * _Nonnull)ps_imageAtRect:(CGRect)rect;

/**
 *  创建指定color的image
 *
 *  @param color 指定color
 *
 *  @return 返回创建的image
 */
+ (UIImage * _Nonnull)ps_imageWithColor:(UIColor * _Nonnull)color;

/**
 *  根据传入大小创建指定color的image
 *
 *  @param color 指定color
 *
 *  @return 返回创建的image
 */
+ (UIImage * _Nonnull)ps_imageWithColor:(UIColor * _Nonnull)color toSize:(CGSize)size;

/**
 *  将图片剪裁至目标尺寸(将图片直接重绘入目标尺寸画布，原长/宽比例为目标尺寸长/宽比例)
 *
 *  @param targetSize 目标size
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)ps_imageByScalingToSize:(CGSize)targetSize;

/**
 *  指定宽度按比例缩放
 *
 *  @param targetWidth 目标宽度
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)ps_imageByScalingWidth:(CGFloat)targetWidth;

/**
 *  将图片剪裁至目标尺寸(将图片按比例压缩后重绘入目标尺寸画布，并裁剪掉多余部分，原长/宽比例不变)
 *
 *  @param targetSize 目标size
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)ps_imageByScalingAndCroppingToTargetSize:(CGSize)targetSize;

/**
 * 内切处理图片
 *
 *  @param insets 内切值
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nonnull)ps_edgeInsetsImage:(UIEdgeInsets)insets;

/**
 * 按比例拉伸/缩放图片
 *
 *  @param scale 拉伸/缩放 比例
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)ps_imageByResizeToScale:(CGFloat)scale;

/**
 修正去除图片的白色像素
 
 @param fix 修正像素
 @return 返回去除图片的白色像素的image
 */
- (UIImage * _Nullable)ps_fixPictureWhitePixelWithFixValue:(NSInteger)fix;

@end

NS_ASSUME_NONNULL_END
