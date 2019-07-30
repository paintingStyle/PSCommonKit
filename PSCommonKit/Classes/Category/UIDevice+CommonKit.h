//
//  UIDevice+CommonKit.h
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (CommonKit)

/**
 *  Return the device platform string
 *  Example: "iPhone3,2"
 *
 *  @return Return the device platform string
 */
+ (NSString *)ps_devicePlatform;

/**
 *  Return the user-friendly device platform string
 *  Example: "iPad Air (Cellular)"
 *
 *  @return Return the user-friendly device platform string
 */
+ (NSString *)ps_devicePlatformString;

/**
 *  Check if the current device is an iPad
 *
 *  @return Return YES if it's an iPad, NO if not
 */
+ (BOOL)ps_isiPad;

/**
 *  Check if the current device is an iPhone
 *
 *  @return Return YES if it's an iPhone, NO if not
 */
+ (BOOL)ps_isiPhone;

/**
 *  Check if the current device is an iPod
 *
 *  @return Return YES if it's an iPod, NO if not
 */
+ (BOOL)ps_isiPod;

/**
 *  Check if the current device is the simulator
 *
 *  @return Return YES if it's the simulator, NO if not
 */
+ (BOOL)ps_isSimulator;

/**
 *  Check if the current device has a Retina display
 *
 *  @return Return YES if it has a Retina display, NO if not
 */
+ (BOOL)ps_isRetina;

/**
 *  Check if the current device has a Retina HD display
 *
 *  @return Return YES if it has a Retina HD display, NO if not
 */
+ (BOOL)ps_isRetinaHD;

/**
 *  Return the iOS version without the subversion
 *  Example: 7
 *
 *  @return Return the iOS version
 */
+ (NSInteger)ps_iOSVersion;

/**
 *  Return the current device CPU frequency
 *
 *  @return Return the current device CPU frequency
 */
+ (NSUInteger)ps_cpuFrequency;

/**
 *  Return the current device BUS frequency
 *
 *  @return Return the current device BUS frequency
 */
+ (NSUInteger)ps_busFrequency;

/**
 *  Return the current device RAM size
 *
 *  @return Return the current device RAM size
 */
+ (NSUInteger)ps_ramSize;

/**
 *  Return the current device CPU number
 *
 *  @return Return the current device CPU number
 */
+ (NSUInteger)ps_cpuNumber;

/**
 *  Return the current device total memory
 *
 *  @return Return the current device total memory
 */
+ (NSUInteger)ps_totalMemory;

/**
 *  Return the current device non-kernel memory
 *
 *  @return Return the current device non-kernel memory
 */
+ (NSUInteger)ps_userMemory;

/**
 *  Return the current device total disk space
 *
 *  @return Return the current device total disk space
 */
+ (NSNumber *)ps_totalDiskSpace;

/**
 *  Return the current device free disk space
 *
 *  @return Return the current device free disk space
 */
+ (NSNumber *)ps_freeDiskSpace;

/**
 *  Return the current device MAC address
 *
 *  @return Return the current device MAC address
 */
+ (NSString *)ps_macAddress;

/**
 *  Generate an unique identifier and store it into standardUserDefaults
 *
 *  @return Return a unique identifier as a NSString
 */
+ (NSString *)ps_uniqueIdentifier;

@end

NS_ASSUME_NONNULL_END
