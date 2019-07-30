//
//  UIImage+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIImage+CommonKit.h"

@implementation UIImage (CommonKit)

- (UIImage *)ps_imageByRoundCornerRadius:(CGFloat)radius
						  borderWidth:(CGFloat)borderWidth
						  borderColor:(UIColor *)borderColor {
	
	return [self ps_imageByRoundCornerRadius:radius
								  corners:UIRectCornerAllCorners
							  borderWidth:borderWidth
							  borderColor:borderColor
						   borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)ps_imageByRoundCornerRadius:(CGFloat)radius
							  corners:(UIRectCorner)corners
						  borderWidth:(CGFloat)borderWidth
						  borderColor:(UIColor *)borderColor
					   borderLineJoin:(CGLineJoin)borderLineJoin {
	
	UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
	CGContextScaleCTM(context, 1, -1);
	CGContextTranslateCTM(context, 0, -rect.size.height);
	
	CGFloat minSize = MIN(self.size.width, self.size.height);
	if (borderWidth < minSize / 2) {
		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
		[path closePath];
		
		CGContextSaveGState(context);
		[path addClip];
		CGContextDrawImage(context, rect, self.CGImage);
		CGContextRestoreGState(context);
	}
	
	if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
		CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
		CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
		CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
		[path closePath];
		
		path.lineWidth = borderWidth;
		path.lineJoinStyle = borderLineJoin;
		[borderColor setStroke];
		[path stroke];
	}
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}


- (UIImage * _Nonnull)ps_imageAtRect:(CGRect)rect {
	
	//把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
	CGFloat scale = [UIScreen mainScreen].scale;
	CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
	CGRect dianRect = CGRectMake(x, y, w, h);
	
	//截取部分图片并生成新图片
	CGImageRef newImageRef = CGImageCreateWithImageInRect([self CGImage], dianRect);
	UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:self.imageOrientation];
	CGImageRelease(newImageRef);
	return newImage;
}

+ (UIImage * _Nonnull)ps_imageWithColor:(UIColor * _Nonnull)color {
	
	return [self ps_imageWithColor:color toSize:CGSizeMake(1, 1)];
}

+ (UIImage * _Nonnull)ps_imageWithColor:(UIColor * _Nonnull)color toSize:(CGSize)size {
	
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

- (UIImage * _Nullable)ps_imageByScalingToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGFloat targetWidth = ceilf(targetSize.width);
	CGFloat targetHeight = ceilf(targetSize.height);
	
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, [[UIScreen mainScreen] scale]);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if (newImage == nil) {
		NSLog(@"Could not scale image");
	}
	
	return newImage;
}

- (UIImage *)ps_imageByScalingWidth:(CGFloat)targetWidth {
	
	UIImage *newImage = nil;
	
	CGSize imageSize = self.size;
	
	CGFloat width = imageSize.width;
	
	CGFloat height = imageSize.height;
	
	CGFloat targetHeight = height / (width / targetWidth);
	
	CGSize size = CGSizeMake(targetWidth, targetHeight);
	
	CGFloat scaleFactor = 0.0;
	
	CGFloat scaledWidth = targetWidth;
	
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
	
	if(CGSizeEqualToSize(imageSize, size) == NO){
		
		CGFloat widthFactor = targetWidth / width;
		
		CGFloat heightFactor = targetHeight / height;
		
		if(widthFactor > heightFactor){
			
			scaleFactor = widthFactor;
			
		}
		
		else{
			
			scaleFactor = heightFactor;
			
		}
		
		scaledWidth = width * scaleFactor;
		
		scaledHeight = height * scaleFactor;
		
		if(widthFactor > heightFactor){
			
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
			
		}else if(widthFactor < heightFactor){
			
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
			
		}
		
	}
	
	UIGraphicsBeginImageContext(size);
	
	CGRect thumbnailRect = CGRectZero;
	
	thumbnailRect.origin = thumbnailPoint;
	
	thumbnailRect.size.width = scaledWidth;
	
	thumbnailRect.size.height = scaledHeight;
	
	[self drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	if(newImage == nil){
		
		NSLog(@"scale image fail");
	}
	
	UIGraphicsEndImageContext();
	
	return newImage;
	
}

- (UIImage * _Nullable)ps_imageByScalingAndCroppingToTargetSize:(CGSize)targetSize{
	
	if (CGSizeEqualToSize(targetSize, CGSizeZero) ) {
		return self;
	}
	
	UIImage *newImage = nil;
	CGFloat width = ceilf(self.size.width) *self.scale;
	CGFloat height = ceilf(self.size.height) *self.scale;
	CGSize imageSize = CGSizeMake(width, height);
	//  如果存在小数点.12123，图片锐化会可能造成失真
	CGFloat targetWidth = ceilf(targetSize.width);
	CGFloat targetHeight = ceilf(targetSize.height);
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	if (CGSizeEqualToSize(imageSize, targetSize) == NO)
	{
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor > heightFactor)
			scaleFactor = widthFactor; // scale to fit height
		else
			scaleFactor = heightFactor; // scale to fit width
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		if (widthFactor > heightFactor)
		{
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		}
		else
			if (widthFactor < heightFactor)
			{
				thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
			}
	}
	
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, [[UIScreen mainScreen] scale]);
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	// 绘制改变大小的图片
	[self drawInRect:thumbnailRect];
	// 从当前context中创建一个改变大小后的图片
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	if(newImage == nil) NSLog(@"could not scale image");
	
	/// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	
	// 返回新的改变大小后的图片
	return newImage;
}

- (UIImage * _Nonnull)ps_edgeInsetsImage:(UIEdgeInsets)insets {
	
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f) {
		return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
	}
	
	return [self stretchableImageWithLeftCapWidth:insets.left topCapHeight:insets.top];
	
}

- (UIImage * _Nullable)ps_imageByResizeToScale:(CGFloat)scale{
	
	CGSize size = CGSizeMake(self.size.width *scale, self.size.height * scale);
	if (size.width <= 0 || size.height <= 0) return nil;
	UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
	[self drawInRect:CGRectMake(0, 0, size.width, size.height)];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

- (UIImage * _Nullable)ps_fixPictureWhitePixelWithFixValue:(NSInteger)fix {
	
	UIImage *image = self;
	
	// 分配内存
	const int imageWidth = image.size.width;
	const int imageHeight = image.size.height;
	size_t bytesPerRow = imageWidth * 4;
	uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
	
	
	// 创建context
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
												 
												 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
	
	CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
	
	
	// 遍历像素
	
	int pixelNum = imageWidth * imageHeight;
	uint32_t* pCurPtr = rgbImageBuf;
	
	for (int i = 0; i < pixelNum; i++, pCurPtr++) {
		
		//        //去除白色...将0xFFFFFF00换成其它颜色也可以替换其他颜色。
		
		//        if ((*pCurPtr & 0xFFFFFF00) >= 0xffffff00) {
		
		//
		
		//            uint8_t* ptr = (uint8_t*)pCurPtr;
		
		//            ptr[0] = 0;
		
		//        }
		
		//接近白色
		
		//将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
		
		//分别取出RGB值后。进行判断需不需要设成透明。
		
		uint8_t* ptr = (uint8_t*)pCurPtr;
		
		if (ptr[1] > 240 && ptr[2] > 240 && ptr[3] > 240) {
			
			//当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
			ptr[0] -= fix;
			ptr[1] -= fix;
			ptr[2] -= fix;
		}
		
	}
	
	// 将内存转成image
	
	CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
	
	CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
										
										kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,
										
										NULL, true,kCGRenderingIntentDefault);
	CGDataProviderRelease(dataProvider);
	UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
	
	// 释放
	CGImageRelease(imageRef);
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	return resultUIImage;
}

@end
