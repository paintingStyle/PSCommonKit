//
//  NSDate+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CommonKit)

//--------------------------------------------//
// Get day, month, year, hour, minute, second
//--------------------------------------------//
- (NSUInteger)ps_day;
- (NSUInteger)ps_month;
- (NSUInteger)ps_year;
- (NSUInteger)ps_hour;
- (NSUInteger)ps_minute;
- (NSUInteger)ps_second;
+ (NSUInteger)ps_day:(NSDate *)ps_date;
+ (NSUInteger)ps_month:(NSDate *)ps_date;
+ (NSUInteger)ps_year:(NSDate *)ps_date;
+ (NSUInteger)ps_hour:(NSDate *)ps_date;
+ (NSUInteger)ps_minute:(NSDate *)ps_date;
+ (NSUInteger)ps_second:(NSDate *)ps_date;

/**
 *	Get how many days in the year.
 *
 *	@return The days of the year.
 */
- (NSUInteger)ps_daysInYear;

/**
 *	Get how many days in the specified year.
 *
 *	@param ps_date	The specified date
 *
 *	@return The days of the year.
 */
+ (NSUInteger)ps_daysInYear:(NSDate *)ps_date;

/**
 *	Judge whether this year is leap year or not.
 *
 *	@return YES means leap year, otherwise NO.
 */
- (BOOL)ps_isLeapYear;

/**
 *	Judge whether the specified date of year is leap year or not.
 *
 *	@param ps_date	The specified date.
 *
 *	@return YES means leap year, otherwise NO.
 */
+ (BOOL)ps_isLeapYear:(NSDate *)ps_date;

/**
 *	Judge whether this year is leap year or not.
 *
 *	@param year	The specified year
 *
 *	@return YES means leap year, otherwise NO.
 */
+ (BOOL)ps_isLeapYearWithYear:(int)year;

/**
 *	Get which week in the year.
 *
 *	@return Current week of year.
 */
- (NSUInteger)ps_weekOfYear;

/**
 *	Get which week in the specified date.
 *
 *	@param ps_date	The specified date to get which week.
 *
 *	@return Current week of the specified year.
 */
+ (NSUInteger)ps_weekOfYear:(NSDate *)ps_date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
/**
 *	Convert the date to a time string with yyyy-MM-dd format.
 *
 *	@return The time string with yyyy-MM-dd
 */
- (NSString *)ps_toStringWithFormatYMD;

/**
 *  Convert the date to a time string with yyyy-MM-dd format.
 *
 *	@param ps_date	The specified date to be converted to time string.
 *
 *	@return The time string with yyyy-MM-dd
 */
+ (NSString *)ps_toStringWithFormatYMD:(NSDate *)ps_date;

/**
 *	Get how many weeks in the month. It might have 4, 5, or 6 weeks.
 *
 *	@return The weeks in the month.
 */
- (NSUInteger)ps_howManyWeeksOfMonth;

/**
 *	Get how many weeks in the month. It might have 4, 5, or 6 weeks.
 *
 *	@param ps_date The specified date
 *
 *	@return The weeks in the month of the specified date.
 */
+ (NSUInteger)ps_howManyWeeksOfMonth:(NSDate *)ps_date;

/**
 *	Get the first date of this month.
 *
 *	@return The first date of this month.
 */
- (NSDate *)ps_beginDayOfMonth;

/**
 *	Get the first date of this month.
 *
 *	@param ps_date	The specified date.
 *
 *	@return The first date of this month.
 */
+ (NSDate *)ps_beginDayOfMonth:(NSDate *)ps_date;

/**
 *	Get the last date of this month.
 *
 *	@return The last date of this month.
 */
- (NSDate *)ps_lastDayOfMonth;

/**
 *	Get the last date of the specified month.
 *
 *	@param ps_date	The specified date.
 *
 *	@return The last date of this month.
 */
+ (NSDate *)ps_lastDayOfMonth:(NSDate *)ps_date;

/**
 *	Add days
 *
 *	@param days	The added days.
 *
 *	@return The new date after add days.
 */
- (NSDate *)ps_dateAfterDay:(NSUInteger)days;

/**
 *	Add days to the specified date.
 *
 *	@param ps_date	The spcified date.
 *	@param days			The added days.
 *
 *	@return The new date after adding days.
 */
+ (NSDate *)ps_dateAfterDate:(NSDate *)ps_date day:(NSInteger)days;

/**
 *	Add months to the date.
 *
 *	@param months	The added months.
 *
 *	@return The new date after adding months.
 */
- (NSDate *)ps_dateAfterMonth:(NSUInteger)months;

/**
 *	Add months to the date.
 *
 *	@param ps_date The specified date.
 *	@param months	The added months.
 *
 *	@return The new date after adding months.
 */
+ (NSDate *)ps_dateAfterDate:(NSDate *)ps_date month:(NSInteger)months;

/**
 * 返回numYears年后的日期
 */
/**
 *	Get new date offset numYears.
 *
 *	@param numYears	The
 *
 */
- (NSDate *)ps_offsetYears:(int)numYears;
+ (NSDate *)ps_offsetYears:(int)ps_numYears fromDate:(NSDate *)ps_fromDate;
- (NSDate *)ps_offsetMonths:(int)ps_numMonths;
+ (NSDate *)ps_offsetMonths:(int)ps_numMonths fromDate:(NSDate *)ps_fromDate;
- (NSDate *)ps_offsetDays:(int)ps_numDays;
+ (NSDate *)ps_offsetDays:(int)ps_numDays fromDate:(NSDate *)ps_fromDate;
- (NSDate *)ps_offsetHours:(int)ps_hours;
+ (NSDate *)ps_offsetHours:(int)ps_numHours fromDate:(NSDate *)ps_fromDate;
- (NSUInteger)ps_daysAgo;
+ (NSUInteger)ps_daysAgo:(NSDate *)ps_date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)ps_weekday;
+ (NSInteger)ps_weekday:(NSDate *)ps_date;

/**
 *  获取星期几(名称)ps_
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)ps_dayFromWeekday;
+ (NSString *)ps_dayFromWeekday:(NSDate *)ps_date;

/**
 *  Is the same date?
 *
 *  @param ps_anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)ps_isSameDate:(NSDate *)ps_anotherDate;

/**
 *  Is today?
 *
 *  @return Return if self is today
 */
- (BOOL)ps_isToday;

/**
 *  Add days to self
 *
 *  @param ps_days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)ps_dateByAddingDays:(NSUInteger)ps_days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param ps_month The month to be converted in string
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
+ (NSString *)ps_monthWithMonthNumber:(NSInteger)ps_month;

/**
 *  Convert date to string with format.
 */
+ (NSString *)ps_stringWithDate:(NSDate *)ps_date format:(NSString *)ps_format;
- (NSString *)ps_stringWithFormat:(NSString *)ps_format;

/**
 * Convert date string to NSDate instance.
 */
+ (NSDate *)ps_dateWithString:(NSString *)ps_string format:(NSString *)ps_format;

/**
 * Get how many days in the month.
 */
- (NSUInteger)ps_daysInMonth:(NSUInteger)ps_month;
+ (NSUInteger)ps_daysInMonth:(NSDate *)ps_date month:(NSUInteger)ps_month;
+ (NSUInteger)ps_dayInYear:(NSUInteger)year month:(NSUInteger)month;

/**
 * Get how many days in the month.
 */
- (NSUInteger)ps_daysInMonth;
+ (NSUInteger)ps_daysInMonth:(NSDate *)ps_date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)ps_timeInfo;
+ (NSString *)ps_timeInfoWithDate:(NSDate *)ps_date;
+ (NSString *)ps_timeInfoWithDateString:(NSString *)ps_dateString;

/**
 * yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss
 */
- (NSString *)ps_ymdFormat;
- (NSString *)ps_hmsFormat;
- (NSString *)ps_ymdHmsFormat;
+ (NSString *)ps_ymdFormat;
+ (NSString *)ps_hmsFormat;
+ (NSString *)ps_ymdHmsFormat;

+ (NSDateComponents *)ps_dateComponentsWithDate:(NSDate *)date;

/**
 * Convert date to time stamp.
 */
- (NSString *)ps_toTimeStamp;

/**
 * Convert time stamp to date.
 */
+ (NSDate *)ps_toDateWithTimeStamp:(NSString *)timeStamp;

@end

NS_ASSUME_NONNULL_END
