//
//  NSArray+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "NSArray+CommonKit.h"

@implementation NSArray (CommonKit)

- (id)ps_objectAtIndex:(NSUInteger)index {
	
	NSUInteger count = [self count];
	
	if (count > 0 && index < count) {
		return [self objectAtIndex:index];
	}
	
	return nil;
}

- (BOOL)ps_isContainsString:(NSString *)string {
	
	for (NSString *element in self) {
		if ([element isKindOfClass:[NSString class]] &&
			[element isEqualToString:string]) {
			return true;
		}
	}
	
	return false;
}

- (NSArray *)ps_reverseArray {
	
	NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
	NSEnumerator *enumerator = [self reverseObjectEnumerator];
	
	for (id element in enumerator) {
		[arrayTemp addObject:element];
	}
	
	return arrayTemp;
}

@end
