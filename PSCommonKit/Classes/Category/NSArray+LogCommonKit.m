//
//  NSArray+LogCommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "NSArray+LogCommonKit.h"

@implementation NSArray (LogCommonKit)

- (NSString *)descriptionString {
	
	return [self descriptionWithLocale:nil];
}

- (NSString *)descriptionWithLocale:(id)locale {
	
	NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
	
	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[strM appendFormat:@"\t%@,\n", obj];
	}];
	
	[strM appendString:@")"];
	
	return strM.copy;
}

@end

@implementation NSDictionary (LogCommonKit)

- (NSString *)descriptionString {
	
	return [self descriptionWithLocale:nil];
};

- (NSString *)descriptionWithLocale:(id)locale {
	
	NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
	
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[strM appendFormat:@"\t%@ = %@;\n", key, obj];
	}];
	
	[strM appendString:@"}\n"];
	
	return strM.copy;
}

@end
