//
//  NSLayoutConstraint+PSIBInspectable.h
//  tyfocg
//
//  Created by paintingStyle on 2017/11/27.
//  Copyright © 2017年 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (PSIBInspectable)

@property(nonatomic,assign) IBInspectable BOOL ps_adaptNavBar;
@property(nonatomic,assign) IBInspectable BOOL ps_adaptW;
@property(nonatomic,assign) IBInspectable BOOL ps_adaptH;

@end
