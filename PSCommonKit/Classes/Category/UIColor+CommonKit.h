//
//  UIColor+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CommonKit)

/**
 *  根据指定的HEX字符串创建一种颜色
 *  HEX支持下面的格式:
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 *  @param hexString HEX字符串
 *
 *  @return 返回创建的UIColor实例
 */
+ (UIColor * _Nonnull)ps_hex:(NSString * _Nonnull)hexString;

/** 获取UIColor中的RGB值
 *  CGFloat components[3];
 *  [self.view.backgroundColor rgbComponents:components];
 *  NSLog(@"%f %f %f", components[0], components[1], components[2])
 */
- (void)ps_rgbComponents:(CGFloat[_Nullable 3])components;

/**
 *  随机创建一种颜色
 *
 *  @return 返回创建的随机色
 */
+ (UIColor * _Nonnull)ps_randomColor;

@end

NS_ASSUME_NONNULL_END
