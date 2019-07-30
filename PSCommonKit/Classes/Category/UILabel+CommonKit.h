//
//  UILabel+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CommonKit)

/**
 两端对齐，平分间距
 
 @param maxW 显示宽度最大值
 */
- (void)ps_fullJustifiedWithMaxW:(CGFloat)maxW;

@end

NS_ASSUME_NONNULL_END
