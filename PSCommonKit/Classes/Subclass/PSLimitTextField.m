//
//  PSLimitTextField.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "PSLimitTextField.h"

#define isIPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define isIPad   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

@implementation NSString (SPTextField)

-(BOOL) isTextFieldMatchWithRegularExpression:(NSString *)exporession {
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",exporession];
	return [predicate evaluateWithObject:self];
}

-(BOOL)isTextFieldIntValue {
	
	return [self isTextFieldMatchWithRegularExpression:@"[-]{0,1}[0-9]*"];
}

-(BOOL)isTextFieldUnsignedIntValue {
	
	return [self isTextFieldMatchWithRegularExpression:@"[0-9]+"];
}

-(BOOL)isTextFieldEmoji {
	
	//因为emoji一直在更新，这个不行
	return NO;
}

//- (BOOL)isTextFieldOnlyChinese {
//
//    return [self isTextFieldMatchWithRegularExpression:@"(^[\u4e00-\u9fa5]+$)"];
//}
//
//- (BOOL)isTextFieldOnlyCaseLetter {
//
//    return [self isTextFieldMatchWithRegularExpression:@"[a-zA-Z]*"];
//}

//- (NSString *)interceptionChinese {
//
//    NSMutableString *result = [NSMutableString string];
//    for (int i = 0; i < self.length; i++) {
//        NSString *string = [self substringWithRange:NSMakeRange(i, 1)];
//        if ([self isTextFieldOnlyChinese]) {
//            if (string) { [result appendString:string]; }
//        }
//    }
//    return result;
//}
//
//- (NSString *)interceptionCaseLetter  {
//
//    NSMutableString *result = [NSMutableString string];
//    for (int i = 0; i < self.length; i++) {
//        NSString *string = [self substringWithRange:NSMakeRange(i, 1)];
//        if ([self isTextFieldOnlyCaseLetter]) {
//            if (string) { [result appendString:string]; }
//        }
//    }
//    return result;
//}

- (NSString *)interceptionUnsignedInt {
	
	NSMutableString *result = [NSMutableString string];
	for (int i = 0; i < self.length; i++) {
		NSString *string = [self substringWithRange:NSMakeRange(i, 1)];
		if ([string isTextFieldUnsignedIntValue]) {
			if (string) { [result appendString:string]; }
		}
	}
	return result;
}

- (NSString *)interceptionInt {
	
	NSMutableString *result = [NSMutableString string];
	for (int i = 0; i < self.length; i++) {
		NSString *string = [self substringWithRange:NSMakeRange(i, 1)];
		if ([string isTextFieldIntValue]) {
			if (string) { [result appendString:string]; }
		}
	}
	return result;
}

@end



@interface PSLimitTextField()<UITextFieldDelegate>

@end

@implementation PSLimitTextField

-(instancetype)init {
	
	if (self = [super init]) {
		
		[self initDefault];
	}
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
	
	if(self = [super initWithFrame:frame]){
		
		[self initDefault];
	}
	return self;
}

- (void)awakeFromNib{
	
	[super awakeFromNib];
	[self initDefault];
}

-(void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initDefault{
	
	[self initData];
	self.isResignKeyboardWhenTapReturn = YES;
	self.ignoreCandidateCharacter = YES;
	self.delegate = self;
	[self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)initData{
	
	_maxLength = INT_MAX;
	_maxBytesLength = INT_MAX;
}

#pragma mark- UITextField

- (void)textFieldDidChange:(UITextField *)textField {
	
	NSString *text = nil;
	UITextRange *selectedRange = [textField markedTextRange];
	UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
	
	// 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
	if (!position){
		
		text = textField.text;
		
		// 字符处理
		if (text.length > _maxLength){
			//中文和emoj表情存在问题，需要对此进行处理
			NSRange range;
			NSUInteger inputLength = 0;
			for(int i=0; i < text.length && inputLength <= _maxLength; i += range.length) {
				range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
				inputLength += [text substringWithRange:range].length;
				if (inputLength > _maxLength) {
					NSString* newText = [text substringWithRange:NSMakeRange(0, range.location)];
					textField.text = newText;
				}
			}
		}
		
		// 字节处理
		NSUInteger textBytesLength = [textField.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
		if (textBytesLength > _maxBytesLength) {
			NSRange range;
			NSUInteger byteLength = 0;
			for(int i=0; i < text.length && byteLength <= _maxBytesLength; i += range.length) {
				range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
				byteLength += strlen([[text substringWithRange:range] UTF8String]);
				if (byteLength > _maxBytesLength) {
					NSString* newText = [text substringWithRange:NSMakeRange(0, range.location)];
					textField.text = newText;
				}
			}
		}
	}
	
	if (!self.ignoreCandidateCharacter) {
		if (self.textFieldChange) {
			self.textFieldChange(self,textField.text);
		}
	}else if (!position) {
		if (self.textFieldChange) {
			self.textFieldChange(self,textField.text);
		}
	}
}

#pragma mark - 验证字符串是否符合

- (BOOL)validateInputString:(NSString *)string textField:(UITextField *)textField {
	
	switch (self.inputType) {
		case PSLimitTextFieldTypeOnlyUnsignInt:{
			return [string isTextFieldIntValue];
		}
			break;
		case PSLimitTextFieldTypeOnlyInt:{
			return [string isTextFieldUnsignedIntValue];
		}
			break;
		case PSLimitTextFieldTypeForbidEmoj:{
			if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]){
				return NO;
			}
		}
		default:
			break;
	}
	return YES;
}

- (void)setInputType:(PSLimitTextFieldType)inputType {
	_inputType = inputType;
	switch (self.inputType) {
		case PSLimitTextFieldTypeCaseLetter:
			[self setKeyboardType:UIKeyboardTypeASCIICapable];
			break;
		case PSLimitTextFieldTypeURL:
			[self setKeyboardType:UIKeyboardTypeURL];
			break;
		case PSLimitTextFieldTypePhone:
			[self setKeyboardType:UIKeyboardTypeNumberPad];
			break;
		case PSLimitTextFieldTypeEmail:
			[self setKeyboardType:UIKeyboardTypeEmailAddress];
			break;
		case PSLimitTextFieldTypeOnlyUnsignInt:
		case PSLimitTextFieldTypeOnlyInt:
		{
			[self setKeyboardType:UIKeyboardTypeNumberPad];
		}
			break;
		default:{
			[self setKeyboardType:UIKeyboardTypeDefault];
		}
			break;
	}
}

#pragma mark- UITextField Delegate

// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	return YES;
}

// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
	if(_notifyEvent){
		_notifyEvent(self,PSLimitTextFieldEventBegin);
	}
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	
	return YES;
}

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField{
	
	if(_notifyEvent){
		_notifyEvent(self,PSLimitTextFieldEventFinish);
	}
}

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	
	BOOL ret = [self validateInputString:string textField:textField];
	if (ret || [string isEqualToString:@""]) { // 删除的字符串为@""
		if (ret && _inputCharacter) {
			_inputCharacter(self, string);
		}
		return YES;
	}
	else {
		return NO;
	}
}

// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldClear:(UITextField *)textField{
	
	return YES;
}

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	
	if(_isResignKeyboardWhenTapReturn){
		[textField resignFirstResponder];
	}
	
	if (self.shouldReturn) {
		self.shouldReturn(self);
	}
	return YES;
}

@end
