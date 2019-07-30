//
//  NSDate+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "NSDate+CommonKit.h"

@implementation NSDate (CommonKit)

- (NSUInteger)ps_day {
	return [NSDate ps_day:self];
}

- (NSUInteger)ps_month {
	return [NSDate ps_month:self];
}

- (NSUInteger)ps_year {
	return [NSDate ps_year:self];
}

- (NSUInteger)ps_hour {
	return [NSDate ps_hour:self];
}

- (NSUInteger)ps_minute {
	return [NSDate ps_minute:self];
}

- (NSUInteger)ps_second {
	return [NSDate ps_second:self];
}

+ (NSUInteger)ps_day:(NSDate *)ps_date {
	return [[self ps_dateComponentsWithDate:ps_date] day];
}

+ (NSUInteger)ps_month:(NSDate *)ps_date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth)fromDate:ps_date];
#else
	NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit)fromDate:ps_date];
#endif
	
	return [dayComponents month];
}

+ (NSUInteger)ps_year:(NSDate *)ps_date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear)fromDate:ps_date];
#else
	NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit)fromDate:ps_date];
#endif
	
	return [dayComponents year];
}

+ (NSUInteger)ps_hour:(NSDate *)ps_date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour)fromDate:ps_date];
#else
	NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit)fromDate:ps_date];
#endif
	
	return [dayComponents hour];
}

+ (NSUInteger)ps_minute:(NSDate *)ps_date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute)fromDate:ps_date];
#else
	NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit)fromDate:ps_date];
#endif
	
	return [dayComponents minute];
}

+ (NSUInteger)ps_second:(NSDate *)ps_date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond)fromDate:ps_date];
#else
	NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit)fromDate:ps_date];
#endif
	
	return [dayComponents second];
}

- (NSUInteger)ps_daysInYear {
	return [NSDate ps_daysInYear:self];
}

+ (NSUInteger)ps_daysInYear:(NSDate *)ps_date {
	return [self ps_isLeapYear:ps_date] ? 366 : 365;
}

- (BOOL)ps_isLeapYear {
	return [NSDate ps_isLeapYear:self];
}

+ (BOOL)ps_isLeapYear:(NSDate *)ps_date {
	int year = (int)[ps_date ps_year];
	return [self ps_isLeapYearWithYear:year];
}

+ (BOOL)ps_isLeapYearWithYear:(int)year {
	if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
		return YES;
	}
	
	return NO;
}

- (NSString *)ps_toStringWithFormatYMD {
	return [NSDate ps_toStringWithFormatYMD:self];
}

+ (NSString *)ps_toStringWithFormatYMD:(NSDate *)ps_date {
	return [NSString stringWithFormat:@"%ld-%02ld-%02ld",
			(long)[ps_date ps_year],
			(long)[ps_date ps_month],
			(long)[ps_date ps_day]];
}

- (NSUInteger)ps_howManyWeeksOfMonth {
	return [NSDate ps_howManyWeeksOfMonth:self];
}

+ (NSUInteger)ps_howManyWeeksOfMonth:(NSDate *)ps_date {
	return [[ps_date ps_lastDayOfMonth] ps_weekOfYear] - [[ps_date ps_beginDayOfMonth] ps_weekOfYear] + 1;
}

- (NSUInteger)ps_weekOfYear {
	return [NSDate ps_weekOfYear:self];
}

+ (NSUInteger)ps_weekOfYear:(NSDate *)ps_date {
	NSUInteger i;
	NSUInteger year = [ps_date ps_year];
	
	NSDate *lastdate = [ps_date ps_lastDayOfMonth];
	
	for (i = 1;[[lastdate ps_dateAfterDay:-7 * i] ps_year] == year; i++) {
		
	}
	
	return i;
}

- (NSDate *)ps_dateAfterDay:(NSUInteger)ps_day {
	return [NSDate ps_dateAfterDate:self day:ps_day];
}

+ (NSDate *)ps_dateAfterDate:(NSDate *)ps_date day:(NSInteger)ps_day {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
	[componentsToAdd setDay:ps_day];
	
	NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:ps_date options:0];
	
	return dateAfterDay;
}

- (NSDate *)ps_dateAfterMonth:(NSUInteger)ps_month {
	return [NSDate ps_dateAfterDate:self month:ps_month];
}

+ (NSDate *)ps_dateAfterDate:(NSDate *)ps_date month:(NSInteger)ps_month {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
	[componentsToAdd setMonth:ps_month];
	NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:ps_date options:0];
	
	return dateAfterMonth;
}

- (NSDate *)ps_beginDayOfMonth {
	return [NSDate ps_beginDayOfMonth:self];
}

+ (NSDate *)ps_beginDayOfMonth:(NSDate *)ps_date {
	return [self ps_dateAfterDate:ps_date day:-[ps_date ps_day] + 1];
}

- (NSDate *)ps_lastDayOfMonth {
	return [NSDate ps_lastDayOfMonth:self];
}

+ (NSDate *)ps_lastDayOfMonth:(NSDate *)ps_date {
	NSDate *lastDate = [self ps_beginDayOfMonth:ps_date];
	return [[lastDate ps_dateAfterMonth:1] ps_dateAfterDay:-1];
}

- (NSUInteger)ps_daysAgo {
	return [NSDate ps_daysAgo:self];
}

+ (NSUInteger)ps_daysAgo:(NSDate *)ps_date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
											   fromDate:ps_date
												 toDate:[NSDate date]
												options:0];
#else
	NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
											   fromDate:ps_date
												 toDate:[NSDate date]
												options:0];
#endif
	
	return [components day];
}

- (NSInteger)ps_weekday {
	return [NSDate ps_weekday:self];
}

+ (NSInteger)ps_weekday:(NSDate *)ps_date {
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:ps_date];
	NSInteger weekday = [comps weekday];
	
	return weekday;
}

- (NSString *)ps_dayFromWeekday {
	return [NSDate ps_dayFromWeekday:self];
}

+ (NSString *)ps_dayFromWeekday:(NSDate *)ps_date {
	switch([ps_date ps_weekday]) {
		case 1:
			return @"星期天";
			break;
		case 2:
			return @"星期一";
			break;
		case 3:
			return @"星期二";
			break;
		case 4:
			return @"星期三";
			break;
		case 5:
			return @"星期四";
			break;
		case 6:
			return @"星期五";
			break;
		case 7:
			return @"星期六";
			break;
		default:
			break;
	}
	return @"";
}

- (BOOL)ps_isSameDate:(NSDate *)ps_anotherDate {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
														  | NSCalendarUnitMonth
														  | NSCalendarUnitDay)
												fromDate:self];
	NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
														  | NSCalendarUnitMonth
														  | NSCalendarUnitDay)
												fromDate:ps_anotherDate];
	return ([components1 year] == [components2 year]
			&& [components1 month] == [components2 month]
			&& [components1 day] == [components2 day]);
}

- (BOOL)ps_isToday {
	return [self ps_isSameDate:[NSDate date]];
}

- (NSDate *)ps_dateByAddingDays:(NSUInteger)ps_days {
	NSDateComponents *c = [[NSDateComponents alloc] init];
	c.day = ps_days;
	return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)ps_monthWithMonthNumber:(NSInteger)ps_month {
	switch(ps_month) {
		case 1:
			return @"January";
			break;
		case 2:
			return @"February";
			break;
		case 3:
			return @"March";
			break;
		case 4:
			return @"April";
			break;
		case 5:
			return @"May";
			break;
		case 6:
			return @"June";
			break;
		case 7:
			return @"July";
			break;
		case 8:
			return @"August";
			break;
		case 9:
			return @"September";
			break;
		case 10:
			return @"October";
			break;
		case 11:
			return @"November";
			break;
		case 12:
			return @"December";
			break;
		default:
			break;
	}
	return @"";
}

+ (NSString *)ps_stringWithDate:(NSDate *)ps_date format:(NSString *)ps_format {
	return [ps_date ps_stringWithFormat:ps_format];
}

- (NSString *)ps_stringWithFormat:(NSString *)ps_format {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:ps_format];
	[outputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
	NSString *retStr = [outputFormatter stringFromDate:self];
	
	return retStr;
}

+ (NSDate *)ps_dateWithString:(NSString *)ps_string format:(NSString *)ps_format {
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:ps_format];
	[inputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
	NSDate *date = [inputFormatter dateFromString:ps_string];
	
	return date;
}

- (NSUInteger)ps_daysInMonth:(NSUInteger)ps_month {
	return [NSDate ps_daysInMonth:self month:ps_month];
}

+ (NSUInteger)ps_dayInYear:(NSUInteger)year month:(NSUInteger)month {
	switch (month) {
		case 1: case 3: case 5: case 7: case 8: case 10: case 12:
			return 31;
		case 2:
			return [self ps_isLeapYearWithYear:(int)year] ? 29 : 28;
	}
	
	return 30;
}

+ (NSUInteger)ps_daysInMonth:(NSDate *)ps_date month:(NSUInteger)ps_month {
	switch (ps_month) {
		case 1: case 3: case 5: case 7: case 8: case 10: case 12:
			return 31;
		case 2:
			return [ps_date ps_isLeapYear] ? 29 : 28;
	}
	return 30;
}

- (NSUInteger)ps_daysInMonth {
	return [NSDate ps_daysInMonth:self];
}

+ (NSUInteger)ps_daysInMonth:(NSDate *)ps_date {
	return [self ps_daysInMonth:ps_date month:[ps_date ps_month]];
}

- (NSString *)ps_timeInfo {
	return [NSDate ps_timeInfoWithDate:self];
}

+ (NSString *)ps_timeInfoWithDate:(NSDate *)ps_date {
	return [self ps_timeInfoWithDateString:[self ps_stringWithDate:ps_date format:[self ps_ymdHmsFormat]]];
}

+ (NSString *)ps_timeInfoWithDateString:(NSString *)ps_dateString {
	NSDate *date = [self ps_dateWithString:ps_dateString format:[self ps_ymdHmsFormat]];
	
	NSDate *curDate = [NSDate date];
	NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
	
	int month = (int)([curDate ps_month] - [date ps_month]);
	int year = (int)([curDate ps_year] - [date ps_year]);
	int day = (int)([curDate ps_day] - [date ps_day]);
	
	NSTimeInterval retTime = 1.0;
	if (time < 3600) { // 小于一小时
		retTime = time / 60;
		retTime = retTime <= 0.0 ? 1.0 : retTime;
		return [NSString stringWithFormat:@"%.0f分钟前", retTime];
	} else if (time < 3600 * 24) { // 小于一天，也就是今天
		retTime = time / 3600;
		retTime = retTime <= 0.0 ? 1.0 : retTime;
		return [NSString stringWithFormat:@"%.0f小时前", retTime];
	} else if (time < 3600 * 24 * 2) {
		return @"昨天";
	}
	// 第一个条件是同年，且相隔时间在一个月内
	// 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
	else if ((abs(year) == 0 && abs(month) <= 1)
			 || (abs(year) == 1 && [curDate ps_month] == 1 && [date ps_month] == 12)) {
		int retDay = 0;
		if (year == 0) { // 同年
			if (month == 0) { // 同月
				retDay = day;
			}
		}
		
		if (retDay <= 0) {
			// 获取发布日期中，该月有多少天
			int totalDays = (int)[self ps_daysInMonth:date month:[date ps_month]];
			
			// 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
			retDay = (int)[curDate ps_day] + (totalDays - (int)[date ps_day]);
		}
		
		return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
	} else  {
		if (abs(year) <= 1) {
			if (year == 0) { // 同年
				return [NSString stringWithFormat:@"%d个月前", abs(month)];
			}
			
			// 隔年
			int month = (int)[curDate ps_month];
			int preMonth = (int)[date ps_month];
			if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
				return @"1年前";
			}
			return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
		}
		
		return [NSString stringWithFormat:@"%d年前", abs(year)];
	}
	
	return @"1小时前";
}

- (NSString *)ps_ymdFormat {
	return [NSDate ps_ymdFormat];
}

- (NSString *)ps_hmsFormat {
	return [NSDate ps_hmsFormat];
}

- (NSString *)ps_ymdHmsFormat {
	return [NSDate ps_ymdHmsFormat];
}

+ (NSString *)ps_ymdFormat {
	return @"yyyy-MM-dd";
}

+ (NSString *)ps_hmsFormat {
	return @"HH:mm:ss";
}

+ (NSString *)ps_ymdHmsFormat {
	return [NSString stringWithFormat:@"%@ %@", [self ps_ymdFormat], [self ps_hmsFormat]];
}

- (NSDate *)ps_offsetYears:(int)ps_numYears {
	return [NSDate ps_offsetYears:ps_numYears fromDate:self];
}

+ (NSDate *)ps_offsetYears:(int)ps_numYears fromDate:(NSDate *)ps_fromDate {
	if (ps_fromDate == nil) {
		return nil;
	}
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
#endif
	
	
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setYear:ps_numYears];
	
	return [gregorian dateByAddingComponents:offsetComponents
									  toDate:ps_fromDate
									 options:0];
}

- (NSDate *)ps_offsetMonths:(int)ps_numMonths {
	return [NSDate ps_offsetMonths:ps_numMonths fromDate:self];
}

+ (NSDate *)ps_offsetMonths:(int)ps_numMonths fromDate:(NSDate *)ps_fromDate {
	if (ps_fromDate == nil) {
		return nil;
	}
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
#endif
	
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setMonth:ps_numMonths];
	
	return [gregorian dateByAddingComponents:offsetComponents
									  toDate:ps_fromDate
									 options:0];
}

- (NSDate *)ps_offsetDays:(int)ps_numDays {
	return [NSDate ps_offsetDays:ps_numDays fromDate:self];
}

+ (NSDate *)ps_offsetDays:(int)ps_numDays fromDate:(NSDate *)ps_fromDate {
	if (ps_fromDate == nil) {
		return nil;
	}
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
#endif
	
	
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:ps_numDays];
	
	return [gregorian dateByAddingComponents:offsetComponents
									  toDate:ps_fromDate
									 options:0];
}

- (NSDate *)ps_offsetHours:(int)ps_hours {
	return [NSDate ps_offsetHours:ps_hours fromDate:self];
}

+ (NSDate *)ps_offsetHours:(int)ps_numHours fromDate:(NSDate *)ps_fromDate {
	if (ps_fromDate == nil) {
		return nil;
	}
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	// NSDayCalendarUnit
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
#endif
	
	
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setHour:ps_numHours];
	
	return [gregorian dateByAddingComponents:offsetComponents
									  toDate:ps_fromDate
									 options:0];
}

+ (NSDateComponents *)ps_dateComponentsWithDate:(NSDate *)date {
	NSCalendar *calendar = nil;
	NSUInteger flags = 0;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
	calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
	flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour
	| NSCalendarUnitMinute | NSCalendarUnitSecond;
#else
	calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit
	| NSMinuteCalendarUnit | NSSecondCalendarUnit;
#endif
	[calendar setTimeZone:[NSTimeZone systemTimeZone]];
	
	return [calendar components:flags fromDate:date];
}

- (NSString *)ps_toTimeStamp {
	return [NSString stringWithFormat:@"%lf", [self timeIntervalSince1970]];
}

+ (NSDate *)ps_toDateWithTimeStamp:(NSString *)timeStamp {
	NSString *arg = timeStamp;
	
	if (![timeStamp isKindOfClass:[NSString class]]) {
		arg = [NSString stringWithFormat:@"%@", timeStamp];
	}
	
	if (arg.length > 10) {
		arg = [arg substringToIndex:10];
	}
	
	NSTimeInterval time = [arg doubleValue];
	return [NSDate dateWithTimeIntervalSince1970:time];
}

@end
