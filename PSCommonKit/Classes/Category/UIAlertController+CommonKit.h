//
//  UIAlertController+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^__nullable PSAlertControllerCompletionHandle)(UIAlertAction *action);

@interface UIAlertController (CommonKit)

/**
 只带确定按钮的AlertController
 
 @param taget 目标控制器
 @param message 信息
 @param confirmBlock 确定按钮点击回调
 */
+ (void)ps_alertWithTaget:(id)taget
				  message:(NSString *)message
			 confirmBlock:(PSAlertControllerCompletionHandle)confirmBlock;

/**
 只带确定按钮的AlertController
 
 @param taget 目标控制器
 @param message 信息
 @param confirmTitle 确定按钮标题
 @param confirmBlock 确定按钮点击回调
 */
+ (void)ps_alertWithTaget:(id)taget
				  message:(NSString *)message
			 confirmTitle:(NSString *)confirmTitle
			 confirmBlock:(PSAlertControllerCompletionHandle)confirmBlock;

/**
 带确定，取消按钮的AlertController
 
 @param taget 目标控制器
 @param title 标题
 @param message 信息
 @param confirmTitle 确定按钮标题
 @param cancelTitle  取消按钮标题
 @param confirmBlock 确定按钮点击回调
 @param cancelBlock  取消按钮点击回调
 */
+ (void)ps_alertWithTaget:(id)taget
					title:(nullable NSString *)title
				  message:(nullable NSString *)message
			 confirmTitle:(NSString *)confirmTitle
			  cancelTitle:(NSString *)cancelTitle
			 confirmBlock:(PSAlertControllerCompletionHandle)confirmBlock
			  cancelBlock:(PSAlertControllerCompletionHandle)cancelBlock;

/**
 带确定，取消按钮的AlertController (UIAlertControllerStyleActionSheet)
 
 @param taget 目标控制器
 @param title 标题
 @param message 信息
 @param confirmTitle 确定按钮标题
 @param cancelTitle  取消按钮标题
 @param confirmBlock 确定按钮点击回调
 @param cancelBlock  取消按钮点击回调
 */
+ (void)ps_actionSheetWithTaget:(id)taget
						  title:(nullable NSString *)title
						message:(nullable NSString *)message
				   confirmTitle:(NSString *)confirmTitle
					cancelTitle:(NSString *)cancelTitle
				   confirmBlock:(PSAlertControllerCompletionHandle)confirmBlock
					cancelBlock:(PSAlertControllerCompletionHandle)cancelBlock;


/**
 带确定，取消按钮的AlertController，可修改确定，取消按钮的颜色
 
 @param taget 目标控制器
 @param title 标题
 @param message 信息
 @param confirmTitle 确定按钮标题
 @param cancelTitle  取消按钮标题
 @param confirmTitleColor 确定按钮标题颜色
 @param cancelTitleColor  取消按钮标题颜色
 @param confirmBlock 确定按钮点击回调
 @param cancelBlock  取消按钮点击回调
 */
+ (void)ps_alertWithTaget:(id)taget
					title:(nullable NSString *)title
				  message:(nullable NSString *)message
			 confirmTitle:(NSString *)confirmTitle
			  cancelTitle:(NSString *)cancelTitle
		confirmTitleColor:(UIColor *)confirmTitleColor
		 cancelTitleColor:(UIColor *)cancelTitleColor
			 confirmBlock:(PSAlertControllerCompletionHandle)confirmBlock
			  cancelBlock:(PSAlertControllerCompletionHandle)cancelBlock;

/**
 带确定⚠️，取消按钮的AlertController
 
 @param taget 目标控制器
 @param title 标题
 @param message 信息
 @param destructiveTitle ⚠️按钮标题
 @param cancelTitle  取消按钮标题
 @param destructiveBlock ⚠️按钮点击回调
 @param cancelBlock  取消按钮点击回调
 */
+ (void)ps_alertWithTaget:(id)taget
					title:(nullable NSString *)title
				  message:(nullable NSString *)message
		 destructiveTitle:(NSString *)destructiveTitle
			  cancelTitle:(NSString *)cancelTitle
		 destructiveBlock:(PSAlertControllerCompletionHandle)destructiveBlock
			  cancelBlock:(PSAlertControllerCompletionHandle)cancelBlock;

/**
 带确定⚠️，取消按钮的AlertController (UIAlertControllerStyleActionSheet)
 
 @param taget 目标控制器
 @param title 标题
 @param message 信息
 @param destructiveTitle ⚠️按钮标题
 @param cancelTitle  取消按钮标题
 @param destructiveBlock ⚠️按钮点击回调
 @param cancelBlock  取消按钮点击回调
 */
+ (void)ps_actionSheetWithTaget:(id)taget
						  title:(nullable NSString *)title
						message:(nullable NSString *)message
			   destructiveTitle:(NSString *)destructiveTitle
					cancelTitle:(NSString *)cancelTitle
			   destructiveBlock:(PSAlertControllerCompletionHandle)destructiveBlock
					cancelBlock:(PSAlertControllerCompletionHandle)cancelBlock;


/**
 多个Item，带确定，取消按钮的AlertController (UIAlertControllerStyleActionSheet)
 
 @param taget 目标控制器
 @param title 标题
 @param message 信息
 @param multipleTitles 多个Item标题数组
 @param cancelTitle 取消按钮标题
 @param confirmBlock 多个Item点击回调
 @param cancelBlock 取消按钮点击回调
 */
+ (void)ps_alertWithTaget:(id)taget
					title:(nullable NSString *)title
				  message:(nullable NSString *)message
		   multipleTitles:(NSArray<NSString *> *)multipleTitles
			  cancelTitle:(NSString *)cancelTitle
			 confirmBlock:(PSAlertControllerCompletionHandle)confirmBlock
			  cancelBlock:(PSAlertControllerCompletionHandle)cancelBlock;

@end

NS_ASSUME_NONNULL_END
