//
//  PSCommonDefine.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#ifndef PSCommonDefine_h
#define PSCommonDefine_h

#import <UIKit/UIKit.h>

/*-----------------------------分割线-------------------------------*/

#pragma mark - 调试DEBUG

#ifdef DEBUG
//处于开发阶段
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
// 处于发布阶段
#define NSLog(format, ...)
#endif

/*-----------------------------分割线-------------------------------*/

#pragma mark - 当前屏幕尺寸

/**
 *  主屏的宽
 */
#define PS_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define PS_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  主屏的size
 */
#define PS_SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

/**
 *  主屏的frame
 */
#define PS_SCREEN_FRAME  [UIScreen mainScreen].applicationFrame

/**
 *  iPhoneX顶部安全距离
 */
#define PS_SAFEAREA_TOP_DISTANCE (PS_iPhoneX ? 24 : 0)

/**
 *  iPhoneX底部安全距离
 */
#define PS_SAFEAREA_BOTTOM_DISTANCE (PS_iPhoneX ? 34 : 0)

/*-----------------------------分割线-------------------------------*/

#pragma mark - UINavigationBar and  UITabBar

#define PS_STATUS_BAR_H [[UIApplication sharedApplication] statusBarFrame].size.height
#define PS_NAV_BAR_H	(PS_iPhoneX ? 88.0f: 64.0f)
#define PS_TAB_BAR_H 	(PS_iPhoneX ? 83.0f: 49.0f)
#define PS_STATUSBAR_ISOPEN_HOTSPOTS  [UIApplication sharedApplication].statusBarFrame.size.height > 20 // 状态栏是否开启热点（状态栏高度大于20）

/*-----------------------------分割线-------------------------------*/

#pragma mark - Layout

/**
 这里以iPhone6的尺寸（375，667）为基准缩放，如果效果图是6P为基准，替换宏系数为（414，736）
 ceil向上取整
 */
#define PS_LAYOUT_W(v) ceil(((v)/375.0f * [UIScreen mainScreen].bounds.size.width))
/**
 设备为iPhoneX，高度取iphon8Plus的高度
 */
#define PS_LAYOUT_H(v) ( PS_iPhoneX ? (ceil(((v)/667.0f * 736.0f))) : (ceil(((v)/667.0f * [UIScreen mainScreen].bounds.size.height))) )

/**
 屏幕比例,以iphone6为基准
 */
#define PS_RATIO_H PS_SCREEN_HEIGHT /667.0f
#define PS_RATIO_W PS_SCREEN_WIDTH /375.0f

/**
 解决在iOS11下 heightForHeaderInSection heightForFooterInSection 方法设置无效的情况及刷新抖动的情况
 */
#define PS_TABLEVIEW_FIX(tableView)\
if(@available(iOS 11.0, *)) {\
tableView.estimatedRowHeight = 0;\
tableView.estimatedSectionHeaderHeight = 0;\
tableView.estimatedSectionFooterHeight = 0;\
}

/**
 解决UIImageView的图片居中问题（http://blog.csdn.net/zhoutao198712/article/details/8762012）
 */
#define PS_IMAGEVIEW_CENTER_FIX(imageView)\
[imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];\
imageView.contentMode =  UIViewContentModeScaleAspectFill;\
imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;\
imageView.clipsToBounds  = YES;\

/**
 关闭视图的自带间距
 */
#define PS_SCROLLVIEWINSETS_NO(scrollView)\
if(@available(iOS 11.0, *)) {\
scrollView.contentInsetAdjustmentBehavior =\
UIScrollViewContentInsetAdjustmentNever;\
}else {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}

/*-----------------------------分割线-------------------------------*/

#pragma mark - 当前设备
/**
 *  iPhone4_4s设备,注意iPad不适配情况下，默认为320X480，这里识别为iPhone4_4s
 */
#define PS_iPhone4_4s  ([UIScreen instancesRespondToSelector:@selector(bounds)] ?  CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size)  : NO)

/**
 *  iPhone5_5s设备
 */
#define PS_iPhone5_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  iPhone6_6s_7设备
 */
#define PS_iPhone6_6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  iPhone6Plus_6sPlus_7Plus设备
 */
#define PS_iPhone6Plus_6sPlus_7Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

/**
 *  iPhone6Plus_6sPlus_7Plus设备放大模式
 */
#define PS_iPhone6Plus_6sPlus_7Plus_BigMode ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen]currentMode].size) : NO)

/**
 *  iPhoneXr
 */
#define PS_iPhone_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  iPhoneXsMax
 */
#define PS_iPhone_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  iPhoneX设备
 */
#define PS_iPhoneX (PS_SCREEN_HEIGHT >= 812.0f)

/**
 *  iPad设备
 */
#define PS_isiPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

/*-----------------------------分割线-------------------------------*/

#pragma mark - 当前系统版本

//  ==
#define PS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
//  >
#define PS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
//  >=
#define PS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//  <
#define PS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
//  <=
#define PS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/*-----------------------------分割线-------------------------------*/

#pragma mark - 解决循环引用

#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(x) autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
#else
#define weakify(x) autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
#endif
#endif

#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(x) try{} @finally{} __typeof__(x)x = __weak_##x##__;
#else
#define strongify(x) try{} @finally{} __typeof__(x)x = __block_##x##__;
#endif
#endif

/*-----------------------------分割线-------------------------------*/

#pragma mark - 自定义颜色

#define PSColorFromRGBA(hexValue, alphaValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(hexValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define PSColorFromRGB(rgbValue) PSColorFromRGBA(rgbValue, 1.0)

#define PS_RGB_COLOR(_red, _green, _blue) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:1]

#define PS_RGBA_COLOR(_red, _green, _blue, _alpha) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:(_alpha)]

#define PS_RANDOM_COLOR PS_RGB_COLOR(arc4random_uniform(256.0),arc4random_uniform(256.0),arc4random_uniform(256.0))

/*-----------------------------分割线-------------------------------*/

#pragma makr - 字体大小

#define PS_FONT_10     [UIFont systemFontOfSize:10.0f]
#define PS_FONT_11     [UIFont systemFontOfSize:11.0f]
#define PS_FONT_12     [UIFont systemFontOfSize:12.0f]
#define PS_FONT_13     [UIFont systemFontOfSize:13.0f]
#define PS_FONT_14     [UIFont systemFontOfSize:14.0f]
#define PS_FONT_15     [UIFont systemFontOfSize:15.0f]
#define PS_FONT_16     [UIFont systemFontOfSize:16.0f]
#define PS_FONT_17     [UIFont systemFontOfSize:17.0f]
#define PS_FONT_18     [UIFont systemFontOfSize:18.0f]
#define PS_FONT_20     [UIFont systemFontOfSize:20.0f]
#define PS_FONT_22     [UIFont systemFontOfSize:22.0f]
#define PS_FONT_NUM(num)     [UIFont systemFontOfSize:num]

/*-----------------------------分割线-------------------------------*/

#pragma mark - 数据存储
/**
 *	偏好设置存储对象
 *
 *	@param	object    需存储的对象
 *	@param	key    对应的key
 */
#define PS_USERDEFAULTS_SET_OBJECT(object, key) \
({\
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];\
[defaults setObject:object forKey:key];\
[defaults synchronize];\
})

/**
 *	偏好设置取出对象
 *
 *	@param	key    所需对象对应的key
 *	@return	key所对应的对象
 */
#define PS_USERDEFAULTS_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]


/*-----------------------------分割线-------------------------------*/

#pragma mark - 其他自定义宏

#define PS_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define PS_SYSETMVERSION [[UIDevice currentDevice] systemVersion]
#define PS_FORMATSTRING(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]

#define PS_FRAME(x,y,w,h) CGRectMake(x, y, w, h)
#define PS_POINT(x,y)     CGPointMake(x, y)
#define PS_SIZE(w,h)      CGSizeMake(w, h)

/**
 keyWindow的存在的意义:
 其实就是为了说明当前的window接管了这个控制器的view而已，你可以在keyWindow上加载你自己的建立的view了
 使用[UIApplication sharedApplication].keyWindow：
 应用程序出现了跳转（分享跳转到其他APP，访问系统相册等），
 这时返回原APP，你会发现加载原窗口上的视图位置会发生明显偏移
 这时候采用 [UIApplication sharedApplication].delegate.window
 */
#define PS_WINDOOW [UIApplication sharedApplication].delegate.window

/**
 当前正在显示的Window为KeyWindow,
 KeyWindow一定要等到其根控制器viewWillAppear:方法走完，走完makeKeyAndVisible。
 https://www.jianshu.com/p/86a8909fe1d1
 */
#define PS_KEYWINDOOW [[UIApplication sharedApplication] keyWindow];

#define PS_APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define PS_IMAGE(img)  [UIImage imageNamed:img]
#define PS_NOTI [NSNotificationCenter defaultCenter]

#define PS_DICT_IS_EMPTY(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#define PS_ARRAY_IS_EMPTY(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#define PS_OBJ_IS_EMPTY(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#define PS_DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define PS_TEMP_PATH NSTemporaryDirectory()
#define PS_CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

/**
 由角度转换弧度 由弧度转换角度
 */
#define PS_DEGREES_TO_RADIAN(x) (M_PI * (x) / 180.0)
#define PS_RADIAN_TO_DEGRESS(radian) (radian*180.0)/(M_PI)

/**
 获取沙盒temp，Document，Cache目录
 */
#define PS_PATH_TEMP NSTemporaryDirectory()
#define PS_PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define PS_PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define PS_BUNDLE_PATH(name) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: (name)]

/**
 设置状态栏网络提示
 */
#define PS_NETWORK_ACTIVITY_VISIBLE (b)  [UIApplication sharedApplication].networkActivityIndicatorVisible = b

/**
 圆角描边
 */
#define PS_STROKE_PARAMETER(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/**
 圆角
 */
#define PS_CIRCULAR_PARAMETER(View,Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#define USE_CIRCULAR_FORVIEW(View)\
\
[View.layer setCornerRadius:View.frame.size.width *0.5];\
[View.layer setMasksToBounds:YES]

/*----------------------------—分割线------------------------------*/

/**
 懒加载
 */
#define LAZY_LOAD(object, assignment) (object = object ?: assignment)

/*
 主线程
 dispatch_async_main_safe(^{
 
 });
 */
#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define PSLOG(format,...) NSLog(@"%@",[NSString stringWithFormat:format,##__VA_ARGS__])


/*-----------------------------分割线-------------------------------*/

#pragma mark - 控制台输出宏定义

#define LOG_FRAME(f)   NSLog(@"%@",NSStringFromCGRect(f));
#define LOG_SIZE(s)    NSLog(@"%@",NSStringFromCGSize(s))
#define LOG_RANGE(r)   NSLog(@"%@",NSStringFromRange(r))
#define LOG_CGPOINT(p) NSLog(@"%@",NSStringFromCGPoint(p))
#define LOG_EDGEINSETS(e) NSLog(@"%@",NSStringFromUIEdgeInsets(e))
#define LOG_FUNC       NSLog(@"%s",__func__);

#define LOG_FONTFAMILY_NAMEES NSArray *familyNames = [UIFont familyNames];\
for(NSString *familyName in familyNames) {\
NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];\
for(NSString *fontName in fontNames){\
printf( "\tfontName: %s \n", [fontName UTF8String] );\
}\
}

#define LOG_IsMainThread \
BOOL isMainThread = [NSThread isMainThread];\
NSLog(@"当前线程为%@线程!",isMainThread ? @"主":@"子");\

#define DEBUG_VIEW(v)\
if ([v isKindOfClass:[UIView class]]) {\
[v.subviews enumerateObjectsUsingBlock:\
^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {\
if (![obj isKindOfClass:[UIView class]]) {\
return;\
}\
int r = arc4random() % 255;\
int g = arc4random() % 255;\
int b = arc4random() % 255;\
obj.backgroundColor = [UIColor colorWithRed:(r/255.0)\
green:(g/255.0)\
blue:(b/255.0)\
alpha:1.0];\
}];\
}\


/*-----------------------------分割线-------------------------------*/

/**
 *  字体适配,根据屏幕宽度适配字体
 */
static inline CGFloat AUTO_ADAPT_FONT_SIZE(CGFloat fontSize) {
	
	CGFloat x = floorf(fontSize *PS_RATIO_W); // 向下取整
	return x;
}


/*-----------------------------分割线-------------------------------*/

// 字体自动适配
#define PS_LABEL_FONT_ADAPT(label)\
CGFloat adaptPointSize = AUTO_ADAPT_FONT_SIZE(label.font.pointSize);\
UIFont  *adaptFont = [UIFont fontWithName:label.font.familyName size:adaptPointSize];\
label.font = adaptFont ? :[UIFont systemFontOfSize:adaptPointSize]

#endif /* PSCommonDefine_h */
