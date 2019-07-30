//
//  UITextView+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UITextView+CommonKit.h"
#import <objc/runtime.h>

static const void *kLineFragmentPaddingKey   = @"lineFragmentPaddingKey";
static const void *kPlaceholderLabelKey      = @"placeholderLabelKey";
static const void *kPlaceholderKey           = @"placeholderKey";
static const void *kWordcountKey             = @"wordcountKey";
static const void *kLimitLengthKey           = @"limitLengthKey";
static const void *kTextViewDidChangeKey     = @"textViewDidChangeKey";

#define kColorFromRGBA(hexValue, alphaValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(hexValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define kTextPlaceholderTextFont [UIFont systemFontOfSize:16]
#define kWordCountextFont        [UIFont systemFontOfSize:13]
#define kTextPlaceholderColor    kColorFromRGBA(0x7e7e7e, 1.0)

@interface UITextView ()<UITextViewDelegate>

/** 占位符labe */
@property (nonatomic,strong) UILabel *placeholderLabel;

/** 计算字数labe */
@property (nonatomic,strong) UILabel *wordCountLabel;

@end

@implementation UITextView (CommonKit)

#pragma mark - setter/getter方法

// 显示占位符label的setter/getter方法
-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {
	
	objc_setAssociatedObject(self, kPlaceholderLabelKey, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
	
	return objc_getAssociatedObject(self, kPlaceholderLabelKey);
}

// 显示字数label的setter/getter方法
- (void)setWordCountLabel:(UILabel *)wordCountLabel {
	
	objc_setAssociatedObject(self, kWordcountKey, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)wordCountLabel {
	return objc_getAssociatedObject(self, kWordcountKey);
}




- (void)setPs_lineFragmentPadding:(CGFloat)ps_lineFragmentPadding {
	
	objc_setAssociatedObject(self, kLineFragmentPaddingKey, @(ps_lineFragmentPadding), OBJC_ASSOCIATION_RETAIN);
	
	// 设置光标距离左侧间距
	self.textContainer.lineFragmentPadding = ps_lineFragmentPadding;
}

- (CGFloat)ps_lineFragmentPadding {
	
	return [objc_getAssociatedObject(self, kLineFragmentPaddingKey) floatValue];
}

//供外接访问的占位字符串，以便设置占位文字的setter/getter方法
- (void)setPs_placeholder:(NSString *)ps_placeholder {
	
	objc_setAssociatedObject(self, kPlaceholderKey, ps_placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self setPlaceHolderLabel:ps_placeholder];
}

- (NSString *)ps_placeholder {
	
	return objc_getAssociatedObject(self, kPlaceholderKey);
}

//供外接访问的最大输入字数，设置最大文字个数的setter/getter方法

- (void)setPs_limitLength:(NSInteger)ps_limitLength {
	
	/**
	 系统在32bit设备上对NSNumber类型的对象做的优化不够彻底，NSNumber在32bit设备之上0-12都是存在内存共享区，类似于[NSArray array]无论调用多少次指针指向的都是相同的一块内存区域，永远不会被销毁。而只要大于12就是正常的创建在堆上的对象，
	 32位设备会造成崩溃 [CFNumber retain]: message sent to deallocated instance 0x1443aed0
	 
	 解决方案:
	 将OBJC_ASSOCIATION_ASSIGN改为OBJC_ASSOCIATION_RETAIN，这样在本对象有一个强引用，这个被关联的对象也就不会释放，生命周期也和本对象相同了
	 关联对象传入的都是对象，那么其实绝大多时候用的都应该是是OBJC_ASSOCIATION_RETAIN
	 除了一些需要破解循环引用的场景，关联对象的内存操作修饰符建议都用OBJC_ASSOCIATION_RETAIN
	 
	 参考链接：http://www.jianshu.com/p/d417e3038a04
	 */
	
	objc_setAssociatedObject(self, kLimitLengthKey, @(ps_limitLength), OBJC_ASSOCIATION_RETAIN);
	[self setWordcountLable:ps_limitLength];
	self.textContainerInset = UIEdgeInsetsMake(self.ps_lineFragmentPadding, self.ps_lineFragmentPadding, 35, self.ps_lineFragmentPadding);;
	self.delegate = self;
}

- (NSInteger)ps_limitLength {
	
	return [objc_getAssociatedObject(self, kLimitLengthKey) integerValue];
}

- (void)setPs_textViewDidChangeBlcok:(void (^)(UITextView * _Nonnull))ps_textViewDidChangeBlcok {
	
	objc_setAssociatedObject(self, kTextViewDidChangeKey, ps_textViewDidChangeBlcok, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextView *))ps_textViewDidChangeBlcok {
	
	return objc_getAssociatedObject(self, kTextViewDidChangeKey);
}

#pragma mark - 配置占位符标签

- (void)setPlaceHolderLabel:(NSString *)placeholder {
	
	// 占位字符
	self.placeholderLabel = [[UILabel alloc] init];
	self.placeholderLabel.font = kTextPlaceholderTextFont;
	self.placeholderLabel.text = placeholder;
	self.placeholderLabel.numberOfLines = 0;
	self.placeholderLabel.textColor = kTextPlaceholderColor;
	
	[self addSubview:self.placeholderLabel];
	self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
	self.delegate = self;
	self.textAlignment = NSTextAlignmentLeft;
}

#pragma mark - 设置字数限制标签

- (void)setWordcountLable:(NSInteger)limitLength {
	
	//字数限制
	self.wordCountLabel = [[UILabel alloc] init];
	self.wordCountLabel.textAlignment = NSTextAlignmentRight;
	self.wordCountLabel.textColor = kTextPlaceholderColor;
	self.wordCountLabel.font = kWordCountextFont;
	
	if (self.text.length > limitLength) {
		self.text = [NSString stringWithFormat:@"%@...",[self.text substringToIndex:self.ps_limitLength]];;
	}
	
	self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,(long)limitLength];
	[self addSubview:self.wordCountLabel];
	
	[self updateWordCountLabelState];
}

#pragma mark - 更新占位文字状态

- (void)updatePlaceholderLabelState {
	
	if (self.ps_placeholder) {
		
		self.placeholderLabel.hidden = YES;
		
		if (self.text.length == 0) {
			
			self.placeholderLabel.hidden = NO;
		}
	}
}

#pragma mark - 更新限制文字字数状态

- (void)updateWordCountLabelState {
	
	if (self.ps_limitLength) {
		
		NSInteger wordCount = self.text.length;
		
		BOOL exceedingWordLimit = wordCount >= self.ps_limitLength;
		
		if (exceedingWordLimit) {
			
			// 用户输入已经超出最大字数
			wordCount = self.ps_limitLength;
		}
		
		self.wordCountLabel.textColor = exceedingWordLimit ? [UIColor redColor] : kTextPlaceholderColor;
		
		NSString *wordCountStr = exceedingWordLimit ? [NSString stringWithFormat:@"!%ld",(long)wordCount] : [NSString stringWithFormat:@"%ld",(long)(long)wordCount];
		self.wordCountLabel.text = [NSString stringWithFormat:@"%@/%ld",wordCountStr,(long)self.ps_limitLength];
	}
}

#pragma mark - 限制输入的位数

- (void)limitNumberInput {
	
	if (!self.wordCountLabel) { return; }
}

#pragma mark - UITextViewDelegate

#pragma mark - 字符输入完成

- (void)textViewDidChange:(UITextView *)textView {
	
	[self updatePlaceholderLabelState];
	[self updateWordCountLabelState];
	[self limitNumberInput];
	
	if (self.ps_textViewDidChangeBlcok) {
		self.ps_textViewDidChangeBlcok(textView);
	}
}

#pragma mark -是否允许替换新的文字

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	
	NSInteger textCount = 0;
	
	if (range.length == 0) { // 新增文字
		textCount = self.text.length + text.length;
	}else { // 删除文字
		textCount = abs((int)(self.text.length - range.length));
	}
	
	return (textCount > self.ps_limitLength) ? NO : YES;
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	CGFloat placeholderW = CGRectGetWidth(self.frame)-self.ps_lineFragmentPadding;
	CGFloat wordCountLabelY = 0;
	
	CGRect rect = [self.ps_placeholder boundingRectWithSize:CGSizeMake(placeholderW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kTextPlaceholderTextFont} context:nil];
	
	if (self.contentSize.height <= CGRectGetHeight(self.frame)) {
		wordCountLabelY = CGRectGetHeight(self.frame) - 30;
	}else {
		wordCountLabelY = self.contentSize.height - 30;
	}
	
	CGFloat adjustConstant = 0;
	CGFloat placeholderLabelX = 0;
	if (self.ps_lineFragmentPadding >0) {
		adjustConstant = 3;
		placeholderLabelX = self.ps_lineFragmentPadding +adjustConstant;
	}else {
		adjustConstant = 0;
		placeholderLabelX = 0;
	}
	
	if (self.ps_lineFragmentPadding >0) {
		self.placeholderLabel.frame = CGRectMake(placeholderLabelX, self.ps_lineFragmentPadding, placeholderW -adjustConstant, rect.size.height);
	}else {
		self.textContainer.lineFragmentPadding = 0;
		self.placeholderLabel.frame = CGRectMake(placeholderLabelX, self.ps_lineFragmentPadding, placeholderW -adjustConstant, rect.size.height);
	}
	self.wordCountLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 70, wordCountLabelY, 60, 20);
}

@end
