//
//  PSLimitTextField.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PSLimitTextFieldType){
	
	PSLimitTextFieldTypeAny = 0,       // 没有限制
	PSLimitTextFieldTypePhone,         // Phone键盘
	PSLimitTextFieldTypeURL,           // URL键盘
	PSLimitTextFieldTypeEmail,         // Email键盘
	PSLimitTextFieldTypeCaseLetter,    // 大小写字母
	PSLimitTextFieldTypeChinese,       // 中文
	PSLimitTextFieldTypeOnlyInt,       // 只允许整型输入
	PSLimitTextFieldTypeOnlyUnsignInt, // 只允许非负整型
	PSLimitTextFieldTypeForbidEmoj,    // 禁止Emoj表情输入
};

typedef NS_ENUM(NSUInteger, PSLimitTextFieldEvent){
	
	PSLimitTextFieldEventBegin,         //准备输入文字
	PSLimitTextFieldEventInputChar,     //准备输入字符
	PSLimitTextFieldEventFinish         //输入完成
};

@interface PSLimitTextField : UITextField

/**
 *  如果按了return需要让键盘收起，default:YES
 */
@property(nonatomic,assign) BOOL isResignKeyboardWhenTapReturn;

/**
 是否忽略候选字符，default:YES
 */
@property (nonatomic, assign) BOOL ignoreCandidateCharacter;


/**
 *  输入类型
 */
@property(nonatomic,assign) PSLimitTextFieldType inputType;

/**
 *  最大字符数
 */
@property(nonatomic,assign) NSInteger maxLength;

/**
 *  最大字节数
 */
@property(nonatomic,assign) NSInteger maxBytesLength;

#pragma mark - 需设置代理

/**
 *  中文联想，字符改变的整个字符串回调
 */
@property (nonatomic,copy) void (^textFieldChange)(PSLimitTextField *textField, NSString *string);
/**
 *  成功输入一个字符的回调
 */
@property (nonatomic,copy) void (^inputCharacter)(PSLimitTextField *textField, NSString *string);

/**
 *  控件状态变化的事件回调
 */
@property (nonatomic,copy) void (^notifyEvent)(PSLimitTextField *textField, PSLimitTextFieldEvent event);

/**
 *  点击return
 */
@property (nonatomic, copy) void(^shouldReturn)(PSLimitTextField *textField);

@end

NS_ASSUME_NONNULL_END
