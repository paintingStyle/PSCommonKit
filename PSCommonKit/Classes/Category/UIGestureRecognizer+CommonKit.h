//
//  UIGestureRecognizer+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

/**
 添加:
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
 [self dismissAlertView];
 }];
 [self addGestureRecognizer:tap];
 
 移除
 [self.tapGestureRecognizer removeAllActionBlocks];
 self.tapGestureRecognizer = nil;
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (CommonKit)

/**
 Initializes an allocated gesture-recognizer object with a action block.
 
 @param block  An action block that to handle the gesture recognized by the
 receiver. nil is invalid. It is retained by the gesture.
 
 @return An initialized instance of a concrete UIGestureRecognizer subclass or
 nil if an error occurred in the attempt to initialize the object.
 */
- (instancetype)initWithActionBlock:(void (^)(id sender))block;

/**
 Adds an action block to a gesture-recognizer object. It is retained by the
 gesture.
 
 @param block A block invoked by the action message. nil is not a valid value.
 */
- (void)addActionBlock:(void (^)(id sender))block;

/**
 Remove all action blocks.
 */
- (void)removeAllActionBlocks;

@end

NS_ASSUME_NONNULL_END
