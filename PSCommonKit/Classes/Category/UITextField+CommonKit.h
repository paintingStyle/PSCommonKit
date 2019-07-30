//
//  UITextField+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CommonKit)

/**
 *  设置UITextField左边距
 *
 *  @param leftWidth 边距
 */
- (void)ps_setTextFieldLeftPadding:(CGFloat)leftWidth;

/**
 设置UITextField 右侧清除按钮图片
 
 @param normalImgName      常规图片名
 @param highlightedImgName 高亮图片名
 */
- (void)ps_setTextFieldClearButtonNormal:(NSString *)normalImgName highlightedImgName:(NSString *)highlightedImgName;

/**
 设置UITextField 右侧密码安全性按钮图片
 
 @param normalImgName      常规图片名
 @param selectedImgName    选中图片名
 */
- (void)ps_settingSecureTextEntryButtonNormal:(NSString *)normalImgName selectedImgName:(NSString *)selectedImgName;

/**
 *  设置UITextField Placeholder颜色
 *
 *  @param color 颜色值
 */
- (void)ps_setTextFieldPlaceholderColor:(UIColor *)color;

/**
 *  设置UITextField Placeholder颜色
 *
 *  @param color 颜色值
 *  @param font  字体大小
 */
- (void)ps_setTextFieldPlaceholderColor:(UIColor *)color font:(UIFont *)font;

/**
 *  设置全局共用UITextField对象的指定格式
 *
 *  注意：此是对setTextFieldClearButtonNormal:Highlighted:方法的再封装，需要到.m文件中去自己设置图片
 *
 */
+ (void)ps_setTextFieldSpecifiedformat;

@end

NS_ASSUME_NONNULL_END
