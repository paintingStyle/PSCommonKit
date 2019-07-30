//
//  UITextView+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CommonKit)

/** 设置光标距离左侧间距 */
@property (nonatomic, assign) CGFloat ps_lineFragmentPadding;

/** 占位符文字(应在设置占位符文字设置UITextView显示的内容) */
@property (nonatomic, strong) NSString *ps_placeholder;

/** 字数限制 */
@property (nonatomic, assign) NSInteger ps_limitLength;

/** 输入完成回调 */
@property (nonatomic, copy) void(^ps_textViewDidChangeBlcok)(UITextView *textView);

@end

NS_ASSUME_NONNULL_END
