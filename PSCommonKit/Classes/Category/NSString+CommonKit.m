//
//  NSString+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "NSString+CommonKit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CommonKit)

- (BOOL)ps_isOnlyChinese {
	
	return [self predicateMatchWithRegularExpression:@"(^[\u4e00-\u9fa5]+$)"];
}

- (BOOL)ps_isOnlyNumber {
	
	return [self predicateMatchWithRegularExpression:@"[0-9]*"];
}

- (BOOL)ps_isOnlyChineseCaseLetter {
	
	return [self predicateMatchWithRegularExpression:@"[a-zA-Z]*"];
}

- (BOOL)ps_isValidEmail {
	
	return [self predicateMatchWithRegularExpression:
			@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

- (BOOL)ps_isValidURL {
	
	NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
	NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
	NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
	return results.count > 0;
}

- (BOOL)predicateMatchWithRegularExpression:(NSString *)exporession {
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",exporession];
	return [predicate evaluateWithObject:self];
}

- (BOOL)ps_isValidMobileNumber {
	
	// https://blog.csdn.net/u010085362/article/details/80347225
	NSString *pattern = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
	NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
	if ([mobilePredicate evaluateWithObject:self]) {
		return YES;
	}
	return NO;
}

- (BOOL)ps_isContainsEmoji {
	
	__block BOOL returnValue = NO;
	
	[self enumerateSubstringsInRange:NSMakeRange(0, [self length])
							   options:NSStringEnumerationByComposedCharacterSequences
							usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
								const unichar hs = [substring characterAtIndex:0];
								if (0xd800 <= hs && hs <= 0xdbff) {
									if (substring.length > 1) {
										const unichar ls = [substring characterAtIndex:1];
										const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
										if (0x1d000 <= uc && uc <= 0x1f77f) {
											returnValue = YES;
										}
									}
								} else if (substring.length > 1) {
									const unichar ls = [substring characterAtIndex:1];
									if (ls == 0x20e3) {
										returnValue = YES;
									}
								} else {
									if (0x2100 <= hs && hs <= 0x27ff) {
										returnValue = YES;
									} else if (0x2B05 <= hs && hs <= 0x2b07) {
										returnValue = YES;
									} else if (0x2934 <= hs && hs <= 0x2935) {
										returnValue = YES;
									} else if (0x3297 <= hs && hs <= 0x3299) {
										returnValue = YES;
									} else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
										returnValue = YES;
									}
								}
							}];
	
	return returnValue;
}

- (BOOL)ps_isContactWhiteSpace {
	NSRange range = [self rangeOfString:@" "];
	if (range.location != NSNotFound) {
		return YES;
	}else {
		return NO;
	}
}




- (NSString *)ps_trimWhitespace {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)ps_trimWhitespaceAndNewLine {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)ps_toMD5 {
	if (self == nil || [self length] == 0) {
		return nil;
	}
	
	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[ms appendFormat:@"%02x", (int)(digest[i])];
	}
	
	return [ms copy];
}

- (NSString *)ps_to16MD5 {
	if (self == nil || [self length] == 0) {
		return nil;
	}
	
	return [[self ps_toMD5] substringWithRange:NSMakeRange(8, 16)];
}

- (NSString *)ps_sha1 {
	if (self == nil || [self length] == 0) {
		return nil;
	}
	
	unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
	CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	
	for ( i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
		[ms appendFormat:@"%02x", (int)(digest[i])];
	}
	
	return [ms copy];
}

- (NSString *)ps_sha256 {
	if (self == nil || [self length] == 0) {
		return nil;
	}
	
	unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
	CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	
	for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	
	return [ms copy];
}

- (NSString *)ps_sha512 {
	if (self == nil || [self length] == 0) {
		return nil;
	}
	
	unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
	CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	
	for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	
	return [ms copy];
}





- (BOOL)ps_isBlank {
	return [NSString isBlankString:self];
}

+ (BOOL)isBlankString:(NSString * _Nullable)string {
	// 判断字符串是否为空
	if (string == nil || string == NULL)
	{
		return YES;
	}
	
	if (![string isKindOfClass:[NSString class]]) {
		return YES;
	}
	
	if ([string isKindOfClass:[NSNull class]])
	{
		return YES;
	}
	
	if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
	{
		// 去掉前后空格，判断length是否为0
		return YES;
	}
	
	if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"<null>"])
	{
		return YES;
	}
	
	return NO;
}

- (BOOL)ps_isSpecialCharacters {
	NSString *content = self;
	NSString *str = @"^[-_A-Za-z0-9\\s\\u4e00-\u9fa5]+$";
	NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
	
	if (![emailTest evaluateWithObject:content]) {
		return YES;
	}
	
	return NO;
}

- (BOOL)ps_isValidAlphaNumberPassword {
	NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
	NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)ps_isValidIdentifyEighteen {
	NSString * identifyTest=@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
	NSPredicate*identifyPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",identifyTest];
	return [identifyPredicate evaluateWithObject:self];
}

- (BOOL)ps_isEnglishFirst {
	
	if (!self || !self.length) {
		return NO;
	}
	
	NSString *firstString = [self substringToIndex:1];
	NSString *regular = @"^[A-Za-z]+$";
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
	
	return [predicate evaluateWithObject:firstString];
}

- (BOOL)ps_isChineseFirst {
	
	if (!self || !self.length) {
		return NO;
	}
	
	int utfCode = 0;
	void *buffer = &utfCode;
	NSRange range = NSMakeRange(0, 1);
	BOOL b = [self getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
	if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)){
		return YES;
	}else{
		return NO;
	}
}

- (BOOL)ps_isIntFirst {
	
	if (!self || !self.length) {
		return NO;
	}
	NSString *firstString = [self substringToIndex:1];
	
	NSScanner* scan = [NSScanner scannerWithString:firstString];
	int val;
	return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)ps_transform2Pinyin {
	
	if (!self || !self.length) {
		return nil;
	}
	
	if (!self.ps_isChineseFirst && !self.ps_isEnglishFirst) {
		return self;
	}
	
	NSMutableString *english = [self mutableCopy];
	// 先转换为带声调的拼音
	CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformMandarinLatin, NO);
	// 去掉重音和变音符号
	CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformStripCombiningMarks, NO);
	//去除两端空格和回车 中间空格不用去，用以区分不同汉字
	[english stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	//统一使用大写
	return [english uppercaseString];
}

- (BOOL)ps_isPureNumber {
	NSString *resultNumberStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
	return !(resultNumberStr.length > 0);
}

- (BOOL)ps_isContainString:(NSString *)substring {
	return [self rangeOfString:substring].location != NSNotFound;
}

- (NSDictionary *)ps_toDictionary {
	
	if (!self.length) {
		return nil;
	}
	
	NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSError *err;
	return [NSJSONSerialization JSONObjectWithData:jsonData
										   options:NSJSONReadingMutableContainers
											 error:&err];
}

- (CGSize)ps_sizeWithFont:(UIFont *)font
				  maxSize:(CGSize)maxSize {
	
	CGSize size = CGSizeZero;
	if (self.length > 0) {
		CGRect frame = [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName: font } context:nil];
		size = CGSizeMake(frame.size.width, frame.size.height + 1);
	}
	return size;
}

- (NSString *)ps_thumbnailMobileNumber {
	
	if (![self ps_isValidMobileNumber]) { return nil; }
	
	NSString *prefix = [self substringWithRange:NSMakeRange(0, 3)];
	
	NSMutableString *result = [[NSMutableString alloc] init];
	[result appendString:prefix];
	for (int i=0; i<(self.length -prefix.length); i++) {
		[result appendString:@"*"];
	}
	
	return result;
}

- (NSString *)ps_thumbnailEmail {
	
	if (![self ps_isValidEmail]) { return nil; }
	
	NSRange range = [self rangeOfString:@"@"];
	if (range.location == NSNotFound) { return nil; }
	
	NSString *suffix = [self substringWithRange:NSMakeRange(range.location, self.length - range.location)];
	
	NSMutableString *result = [[NSMutableString alloc] init];
	for (int i=0; i<range.location; i++) {
		[result appendString:@"*"];
	}
	[result appendString:suffix];
	
	return result;
}

- (NSUInteger)ps_charactersLength {
	
	NSUInteger asciiLength = 0;
	for (NSUInteger i = 0; i < self.length; i++) {
		unichar uc = [self characterAtIndex: i];
		asciiLength += isascii(uc) ? 1 : 2;
	}
	
	return asciiLength;
}


- (NSString * _Nonnull)ps_encodeUTF8 {
	return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}

- (NSString * _Nonnull)ps_encodeToBase64 {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	return [data base64EncodedStringWithOptions:0];
}

- (NSString * _Nonnull)ps_decodeBase64 {
	
	NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return string;
}


+ (NSString *)ps_stringWithLongLongValue:(long long)l {
	
	NSNumber *n = [NSNumber numberWithLongLong:l];
	return [n stringValue];
}

+ (NSString *)ps_stringWithhDict:(NSDictionary *)dict {
	
	NSError *parseError = nil;
	
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
	
	return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString * _Nonnull)ps_compareCurrentTime:(NSTimeInterval)compareDate {
	
	NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
	
	NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
	timeInterval = -timeInterval;
	long temp = 0;
	NSString *result;
	
	NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
	NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents *referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
	NSInteger referenceHour  =referenceComponents.hour;
	
	if (timeInterval < 60) {
		result = [NSString stringWithFormat:@"刚刚"];
	}
	else if((temp= timeInterval/60) < 60){
		result = [NSString stringWithFormat:@"%ld分钟前",temp];
	}
	
	else if((temp = timeInterval/3600) <24){
		result = [NSString stringWithFormat:@"%ld小时前",temp];
	}
	else if ((temp = timeInterval/3600/24)==1)
	{
		result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
	}
	else if ((temp = timeInterval/3600/24)==2)
	{
		result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
	}
	
	else if((temp = timeInterval/3600/24) <31){
		result = [NSString stringWithFormat:@"%ld天前",temp];
	}
	
	else if((temp = timeInterval/3600/24/30) <12){
		result = [NSString stringWithFormat:@"%ld个月前",temp];
	}
	else{
		temp = temp/12;
		result = [NSString stringWithFormat:@"%ld年前",temp];
	}
	return  result;
}

+ (NSString * _Nonnull)ps_dateStringYMDWithTimestamp:(NSTimeInterval)timestamp {
	
	return [self ps_dateStringWithTimestamp:timestamp formatter:@"yyyy-MM-dd"];
}

+ (NSString * _Nonnull)ps_dateStringYMDHMWithTimestamp:(NSTimeInterval)timestamp {
	
	return [self ps_dateStringWithTimestamp:timestamp formatter:@"yyyy-MM-dd HH:mm"];
}

+ (NSString * _Nonnull)ps_dateStringWithTimestamp:(NSTimeInterval)timestamp
									 formatter:(NSString *_Nonnull)formatter {
	
	if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
		timestamp /= 1000.0f;
	}
	NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:formatter];
	NSString *strDate = [dateFormatter stringFromDate:timestampDate];
	
	return strDate;
}

+ (NSString *)ps_MSStringWithMS:(NSTimeInterval)MS {
	
    long long time = MS;
    long ms = time%1000/10;
    long second = time/1000%60;
    long m = time/1000/60;
    NSString *timeString =[NSString stringWithFormat:@"%02ld分%02ld秒%02ld",m,second,ms];
    return timeString;
}

+ (NSString *)ps_minutesStringWithMS:(NSTimeInterval)MS {
	
    long long time = MS;
    long m = time/1000/60;
    NSString *timeString =[NSString stringWithFormat:@"%02ld分",m];
    return timeString;
}

#pragma mark - Get Number

+ (NSString * _Nonnull)ps_generateUUID {
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return (__bridge_transfer NSString *)string;
}


- (NSString *)ps_roundDownForValue:(CGFloat)value
				interceptingLength:(NSInteger)length {
	
	// NSRoundDown代表的就是只舍不入。
	// scale的参数position代表保留小数点后几位。
	
	NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:length raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
	
	NSDecimalNumber *ouncesDecimal;
	NSDecimalNumber *roundedOunces;
	
	ouncesDecimal = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%@",@(value)]];
	roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
	
	return [NSString stringWithFormat:@"%@",roundedOunces];
}

- (NSString *)ps_formatMaxNums {
	
	NSInteger maxth = 10000;
	NSInteger exactValue = 1000;
	NSString *string = self;
	NSString  *result = string ? :@"0";
	
	if ([result isKindOfClass:[NSString class]]) {
		
		if ([string integerValue] >=maxth) {
			
			NSInteger remainder = [string integerValue] %maxth;
			if (remainder == 0) {
				result = [NSString stringWithFormat:@"%ld万",[string integerValue] /maxth];
			}else if (remainder >0 && remainder <exactValue) {
				result = [NSString stringWithFormat:@"%ld万",[string integerValue] /maxth];
				result = [result stringByAppendingString:@"+"];
			}else if (remainder >0 && remainder >=exactValue) {
				
				// 注意，这里采用只舍不入
				CGFloat floatValue = [string floatValue] /maxth;
				NSString *roundDownString = [string ps_roundDownForValue:floatValue
													  	interceptingLength:1];
				result = [NSString stringWithFormat:@"%@万",roundDownString];
				result = [result stringByAppendingString:@"+"];
			}
		}
	}
	return result;
}

#pragma mark - Get document/tmp/Cache path

+ (NSString *)ps_documentPath {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)ps_tmpPath {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

+ (NSString *)ps_cachePath {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
}

@end
