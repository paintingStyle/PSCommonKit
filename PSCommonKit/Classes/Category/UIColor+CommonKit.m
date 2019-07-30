//
//  UIColor+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIColor+CommonKit.h"

@implementation UIColor (CommonKit)

+ (UIColor * _Nonnull)ps_hex:(NSString *)hexString {
	
	NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
	
	CGFloat alpha, red, blue, green;
	
	switch ([colorString length]) {
		case 3: // #RGB
			alpha = 1.0f;
			red = [self colorComponentFrom:colorString start:0 length:1];
			green = [self colorComponentFrom:colorString start:1 length:1];
			blue = [self colorComponentFrom:colorString start:2 length:1];
			break;
		case 4: // #ARGB
			alpha = [self colorComponentFrom:colorString start:0 length:1];
			red = [self colorComponentFrom:colorString start:1 length:1];
			green = [self colorComponentFrom:colorString start:2 length:1];
			blue = [self colorComponentFrom:colorString start:3 length:1];
			break;
		case 6: // #RRGGBB
			alpha = 1.0f;
			red = [self colorComponentFrom:colorString start:0 length:2];
			green = [self colorComponentFrom:colorString start:2 length:2];
			blue = [self colorComponentFrom:colorString start:4 length:2];
			break;
		case 8: // #AARRGGBB
			alpha = [self colorComponentFrom:colorString start:0 length:2];
			red = [self colorComponentFrom:colorString start:2 length:2];
			green = [self colorComponentFrom:colorString start:4 length:2];
			blue = [self colorComponentFrom:colorString start:6 length:2];
			break;
		default:
			return nil;
			break;
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString * _Nonnull)string start:(NSUInteger)start length:(NSUInteger)length {
	
	NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
	NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
	unsigned hexComponent;
	[[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
	
	return hexComponent / 255.0;
}

- (void)ps_rgbComponents:(CGFloat [3])components {
	
	CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
	
	unsigned char resultingPixel[4];
	
	CGContextRef context = CGBitmapContextCreate(&resultingPixel,
												 
												 1,
												 
												 1,
												 
												 8,
												 
												 4,
												 
												 rgbColorSpace,
												 
												 (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
	
	CGContextSetFillColorWithColor(context, [self CGColor]);
	
	CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
	
	CGContextRelease(context);
	
	CGColorSpaceRelease(rgbColorSpace);
	
	
	
	for (int component = 0; component < 3; component++) {
		
		components[component] = resultingPixel[component] / 255.0f;
		
	}
}

+ (UIColor * _Nonnull)ps_randomColor {
	
	int r = arc4random() % 255;
	int g = arc4random() % 255;
	int b = arc4random() % 255;
	
	return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
