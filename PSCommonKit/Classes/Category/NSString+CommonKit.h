//
//  NSString+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CommonKit)

- (BOOL)ps_isOnlyChinese;
- (BOOL)ps_isOnlyNumber;
- (BOOL)ps_isOnlyChineseCaseLetter;
- (BOOL)ps_isValidEmail;
- (BOOL)ps_isValidURL;
- (BOOL)ps_isValidMobileNumber;
- (BOOL)ps_isContainsEmoji;
- (BOOL)ps_isContactWhiteSpace;

- (NSString *)ps_trimWhitespace;
- (NSString *)ps_trimWhitespaceAndNewLine;
- (NSString *)ps_toMD5;
- (NSString *)ps_to16MD5;
- (NSString *)ps_sha1;
- (NSString *)ps_sha256;
- (NSString *)ps_sha512;

/**
 判断字符串是否为空
 
 @return YES空，NO非空
 */
- (BOOL)ps_isBlank;

/**
 是否含有特殊字符
 */
- (BOOL)ps_isSpecialCharacters;

/**
 * 正则有效的字母数字密码
 */
- (BOOL)ps_isValidAlphaNumberPassword;

/**
 * 正则检测有效身份证(18位)
 */
- (BOOL)ps_isValidIdentifyEighteen;

/**
 是否以英文首字母
 */
- (BOOL)ps_isEnglishFirst;

/**
 是否以中文为首
 */
- (BOOL)ps_isChineseFirst;

/**
 是否以数字为首
 */
- (BOOL)ps_isIntFirst;

/**
 将中文转换成英文
 */
- (NSString *)ps_transform2Pinyin;

/**
 字符串是否为纯数字
 */
- (BOOL)ps_isPureNumber;

/**
 是否包含字符串
 */
- (BOOL)ps_isContainString:(NSString *)substring;

/**
 字符串转换成字典
 */
- (NSDictionary *)ps_toDictionary;

/**
 计算字体大小
 */
- (CGSize)ps_sizeWithFont:(UIFont *)font
				  maxSize:(CGSize)maxSize;

/**
 手机号码尾端使用*显示
 */
- (NSString *)ps_thumbnailMobileNumber;

/**
 邮箱前端使用*显示
 */
- (NSString *)ps_thumbnailEmail;

/**
 判断字符串的字符长度（字母一个字节，汉字两个字节）
 
 @return 字符长度
 */
- (NSUInteger)ps_charactersLength;

/**
 UTF8编码
 */
- (NSString * _Nonnull)ps_encodeUTF8;

/**
 *  对自身进行Base64编码
 *
 *  @return 返回编码后的字符串
 */
- (NSString * _Nonnull)ps_encodeToBase64;

/**
 *  对自身进行Base64解码
 *
 *  @return 返回解码后的字符串
 */
- (NSString * _Nonnull)ps_decodeBase64;

/**
 long long类型转换为字符串
 */
+ (NSString *)ps_stringWithLongLongValue:(long long)l;

/**
 字典转JSON格式字符串
 */
+ (NSString *)ps_stringWithhDict:(NSDictionary *)dict;


#pragma mark - Get Date String

/**
 * 通过时间戳计算时间差（几小时前、几天前）
 */
+ (NSString * _Nonnull)ps_compareCurrentTime:(NSTimeInterval) compareDate;

/**
 * 通过时间戳得出显示时间
 */
+ (NSString * _Nonnull)ps_dateStringWithTimestamp:(NSTimeInterval)timestamp;

/**
 * 通过时间戳和格式显示时间
 * 参数1: 时间戳
 * 参数2: 时间格式 例:@"yyyy-MM-dd HH:mm:ss",@"yyyy/MM/dd",@"yyyy-MM-dd HH:mm",@"MM-dd HH:mm"
 */
+ (NSString * _Nonnull)ps_dateStringWithTimestamp:(NSTimeInterval)timestamp
										 formatter:(NSString *_Nonnull)formatter;

#pragma mark - Get Number

/**
 *  创建一个UUID字符串
 *
 *  @return 返回被创建的UUID字符串
 */
+ (NSString * _Nonnull)ps_generateUUID;

/**
 截取小数，只舍不入,1.35 -> 1.3
 
 @param value 带格式化的值
 @param length 保留小数点后几位
 @return 截取小数后字符串
 */
- (NSString *_Nonnull)ps_roundDownForValue:(CGFloat)value
					    interceptingLength:(NSInteger)length;

/**
 格式化数字字符串，1000以下直接显示，10000及以上显示x.万+
 */
- (NSString *_Nonnull)ps_formatMaxNums;

#pragma mark - Get document/tmp/Cache path

+ (NSString *)ps_documentPath;
+ (NSString *)ps_tmpPath;
+ (NSString *)ps_cachePath;

@end

NS_ASSUME_NONNULL_END
