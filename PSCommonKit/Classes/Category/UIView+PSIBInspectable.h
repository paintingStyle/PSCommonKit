//
//  UIView+PSIBInspectable.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 IB_DESIGNABLE: 放在\@interface或者@implement都可以，申明这个类在XCode直接看到渲染的效果。
 IBInspectable: 修饰属性，使属性能在XCode中直接设置 (只对UIView子类生效,注意OC项目使用会频繁报错)
 
 // 通过 TARGET_INTERFACE_BUILDER 宏定义，可以在控制IB中渲染的视图与app中运行的视图。
 
 #if !TARGET_INTERFACE_BUILDER
 //此处编译的代码，在app运行调用
 #else
 //此处编译的代码，在IB中绘画中调用
 #endif
 
 报错情况:http://www.jianshu.com/p/a5351d270ac1
 The agent raised a "NSInternalInconsistencyException" exception
 IB Designables: Failed to render and update auto layout statu
 */

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PSIBInspectable)

@property(nonatomic,assign) IBInspectable CGFloat ps_cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat ps_borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *ps_borderColor;

@end

NS_ASSUME_NONNULL_END
