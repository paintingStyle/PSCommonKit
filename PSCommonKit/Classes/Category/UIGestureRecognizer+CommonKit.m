//
//  UIGestureRecognizer+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIGestureRecognizer+CommonKit.h"
#import <objc/runtime.h>

static const int block_key;

@interface _YYUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _YYUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
	self = [super init];
	if (self) {
		_block = [block copy];
	}
	return self;
}

- (void)invoke:(id)sender {
	
	if (_block) _block(sender);
}

@end

@implementation UIGestureRecognizer (CommonKit)

- (instancetype)initWithActionBlock:(void (^)(id sender))block {
	self = [self init];
	[self addActionBlock:block];
	return self;
}

- (void)addActionBlock:(void (^)(id sender))block {
	_YYUIGestureRecognizerBlockTarget *target = [[_YYUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
	[self addTarget:target action:@selector(invoke:)];
	NSMutableArray *targets = [self _yy_allUIGestureRecognizerBlockTargets];
	[targets addObject:target];
}

- (void)removeAllActionBlocks{
	NSMutableArray *targets = [self _yy_allUIGestureRecognizerBlockTargets];
	[targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
		[self removeTarget:target action:@selector(invoke:)];
	}];
	[targets removeAllObjects];
}

- (NSMutableArray *)_yy_allUIGestureRecognizerBlockTargets {
	NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
	if (!targets) {
		targets = [NSMutableArray array];
		objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return targets;
}

@end
