//
//  UIImageView+PSIBInspectable.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (PSIBInspectable)

/**
 是否自动调整image以适应显示
 */
@property(nonatomic,assign) IBInspectable BOOL ps_autoFit;

@end

NS_ASSUME_NONNULL_END
