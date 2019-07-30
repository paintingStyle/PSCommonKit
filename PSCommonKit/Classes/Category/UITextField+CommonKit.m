//
//  UITextField+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UITextField+CommonKit.h"

@implementation UITextField (CommonKit)

- (void)ps_setTextFieldLeftPadding:(CGFloat)leftWidth {
	
	CGRect frame = self.frame;
	frame.size.width = leftWidth;
	UIView *leftview = [[UIView alloc] initWithFrame:frame];
	self.leftViewMode = UITextFieldViewModeAlways;
	self.leftView = leftview;
}

- (void)ps_setTextFieldClearButtonNormal:(NSString *)normalImgName highlightedImgName:(NSString *)highlightedImgName {
	
	UIButton *clearButton = [self valueForKey:@"_clearButton"];
	[clearButton setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
	[clearButton setImage:[UIImage imageNamed:highlightedImgName] forState:UIControlStateHighlighted];
	self.clearButtonMode = UITextFieldViewModeAlways;
}

- (void)ps_settingSecureTextEntryButtonNormal:(NSString *)normalImgName selectedImgName:(NSString *)selectedImgName {
	
	UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[rightBtn setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
	[rightBtn setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
	[rightBtn sizeToFit];
	[rightBtn addTarget:self action:@selector(pwdTextFieldRightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	self.rightView = rightBtn;
	self.rightViewMode = UITextFieldViewModeAlways;
	self.secureTextEntry = YES;
}

#pragma mark - 点击密码文本框右侧按钮

- (void)pwdTextFieldRightBtnClicked:(UIButton *)btn {
	
	btn.selected = !btn.selected;
	self.secureTextEntry = !btn.selected;
}

- (void)ps_setTextFieldPlaceholderColor:(UIColor *)color {
	
	[self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)ps_setTextFieldPlaceholderColor:(UIColor *)color font:(UIFont *)font {
	
	[self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
	[self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

/**
 *  设置全局共用UITextField对象的指定格式
 */
+ (void)ps_setTextFieldSpecifiedformat {
	
	//设置全局共用UITextField对象的指定格式（在实际开发中自定义）
	[[self alloc] ps_setTextFieldLeftPadding:10];
	
	// TODO:需要设置具体的图片
	[[self alloc] ps_setTextFieldClearButtonNormal:@"" highlightedImgName:@""];
	
	[[self alloc] ps_setTextFieldPlaceholderColor:[UIColor grayColor]];
}

@end
