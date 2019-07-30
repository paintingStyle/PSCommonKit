//
//  NSArray+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (CommonKit)

- (id)ps_objectAtIndex:(NSUInteger)index;
- (BOOL)ps_isContainsString:(NSString *)string;
- (NSArray *)ps_reverseArray;

@end

NS_ASSUME_NONNULL_END
