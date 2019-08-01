//
//  UIDevice+CommonKit.m
//  LenovoStudyPlan
//
//  Created by rsf on 2019/7/30.
//  Copyright © 2019 spap. All rights reserved.
//

#import "UIDevice+CommonKit.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#import "sys/utsname.h"
#import <mach-o/arch.h>
#include <net/if.h>
#include <net/if_dl.h>

static NSString * const BFUniqueIdentifierDefaultsKey = @"BFUniqueIdentifier";

@implementation UIDevice (CommonKit)

+ (NSString *)ps_devicePlatform {
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithUTF8String:machine];
	free(machine);
	
	return platform;
}

+ (NSString *)ps_appVersion {
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	return version;
}

+ (NSString *)ps_appName {
	NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
	NSString *appName = [infoDic objectForKey:@"CFBundleName"];
	return appName;
}

+ (NSString *)ps_devicePlatformString {
	NSString *name = nil;
	NSString *deviceModel = [self deviceModelName];
	if (!deviceModel) {
		UIDevice *device = [UIDevice currentDevice];
		name = device.model;
	} else {
		name = deviceModel;
	}
	return name;
}

/**
 *  设备版本
 *  https://www.theiphonewiki.com/wiki/Models
 *  @return e.g. iPhone 5S
 */
+ (NSString*)deviceModelName
{
	struct utsname systemInfo;
	uname(&systemInfo);
	NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
	
	if ([deviceString hasPrefix:@"iPhone"]) {
		// iPhone
		if ([deviceString isEqualToString:@"iPhone1,1"]) {
			return @"iPhone 1G";
		} else if ([deviceString isEqualToString:@"iPhone1,2"]) {
			return @"iPhone 3G";
		} else if ([deviceString isEqualToString:@"iPhone2,1"]) {
			return @"iPhone 3GS";
		} else if ([deviceString isEqualToString:@"iPhone3,1"]
				   || [deviceString isEqualToString:@"iPhone3,2"]
				   || [deviceString isEqualToString:@"iPhone3,3"]) {
			return @"iPhone 4";
		} else if ([deviceString isEqualToString:@"iPhone4,1"]) {
			return @"iPhone 4S";
		} else if ([deviceString isEqualToString:@"iPhone5,1"]
				   || [deviceString isEqualToString:@"iPhone5,2"]) {
			return @"iPhone 5";
		} else if ([deviceString isEqualToString:@"iPhone5,3"]
				   || [deviceString isEqualToString:@"iPhone5,4"]) {
			return @"iPhone 5c";
		} else if ([deviceString isEqualToString:@"iPhone6,1"]
				   || [deviceString isEqualToString:@"iPhone6,2"]) {
			return @"iPhone 5S";
		} else if ([deviceString isEqualToString:@"iPhone7,1"]) {
			return @"iPhone 6 Plus";
		} else if ([deviceString isEqualToString:@"iPhone7,2"]) {
			return @"iPhone 6";
		} else if ([deviceString isEqualToString:@"iPhone8,1"]) {
			return @"iPhone 6s";
		} else if ([deviceString isEqualToString:@"iPhone8,2"]) {
			return @"iPhone 6s Plus";
		} else if ([deviceString isEqualToString:@"iPhone8,4"]) {
			return @"iPhone SE";
		} else if ([deviceString isEqualToString:@"iPhone9,1"]
				   || [deviceString isEqualToString:@"iPhone9,3"]){
			return @"iPhone 7";
		} else if ([deviceString isEqualToString:@"iPhone9,2"]
				   || [deviceString isEqualToString:@"iPhone9,4"]){
			return @"iPhone 7 Plus";
		} else if ([deviceString isEqualToString:@"iPhone10,1"]
				   || [deviceString isEqualToString:@"iPhone10,4"]) {
			return @"iPhone 8";
		} else if ([deviceString isEqualToString:@"iPhone10,2"]
				   || [deviceString isEqualToString:@"iPhone10,5"]) {
			return @"iPhone 8 Plus";
		}else if ([deviceString isEqualToString:@"iPhone10,3"]
				  || [deviceString isEqualToString:@"iPhone10,6"]){
			return @"iPhone X";
		}else if ([deviceString isEqualToString:@"iPhone11,8"]){
			return @"iPhone XR";
		}else if ([deviceString isEqualToString:@"iPhone11,2"]){
			return @"iPhone XS";
		}else if ([deviceString isEqualToString:@"iPhone11,6"]){
			return @"iPhone XS Max";
		}else {
			return @"iPhone";
		}
	} else if ([deviceString hasPrefix:@"iPod"]) {
		// iPod
		if ([deviceString isEqualToString:@"iPod1,1"]) {
			return @"iPod Touch 1G";
		} else if ([deviceString isEqualToString:@"iPod2,1"]) {
			return @"iPod Touch 2G";
		} else if ([deviceString isEqualToString:@"iPod3,1"]) {
			return @"iPod Touch 3G";
		} else if ([deviceString isEqualToString:@"iPod4,1"])  {
			return @"iPod Touch 4G";
		} else if ([deviceString isEqualToString:@"iPod5,1"]) {
			return @"iPod Touch 5G";
		} else if ([deviceString isEqualToString:@"iPod7,1"]) {
			return @"iPod Touch 6G";
		}  else if ([deviceString isEqualToString:@"iPod9,1"]) {
			return @"iPod Touch 7G";
		} else {
			return @"iPod";
		}
	} else if ([deviceString hasPrefix:@"iPad"]) {
		// iPad
		if ([deviceString isEqualToString:@"iPad1,1"]) {
			return @"iPad";
		} else if ([deviceString isEqualToString:@"iPad2,1"]) {
			return @"iPad 2 (WiFi)";
		} else if ([deviceString isEqualToString:@"iPad2,2"]) {
			return @"iPad 2 (GSM)";
		} else if ([deviceString isEqualToString:@"iPad2,3"]) {
			return @"iPad 2 (CDMA)";
		} else if ([deviceString isEqualToString:@"iPad2,4"]) {
			return @"iPad 2 (32nm)";
		} else if ([deviceString isEqualToString:@"iPad2,5"]) {
			return @"iPad mini (WiFi)";
		} else if ([deviceString isEqualToString:@"iPad2,6"]) {
			return @"iPad mini (GSM)";
		} else if ([deviceString isEqualToString:@"iPad2,7"]) {
			return @"iPad mini (CDMA)";
		} else if ([deviceString isEqualToString:@"iPad3,1"]) {
			return @"iPad 3 (WiFi)";
		} else if ([deviceString isEqualToString:@"iPad3,2"]) {
			return @"iPad 3 (CDMA)";
		} else if ([deviceString isEqualToString:@"iPad3,3"]) {
			return @"iPad 3 (4G)";
		} else if ([deviceString isEqualToString:@"iPad3,4"]) {
			return @"iPad 4 (WiFi)";
		} else if ([deviceString isEqualToString:@"iPad3,5"]) {
			return @"iPad 4 (4G)";
		} else if ([deviceString isEqualToString:@"iPad3,6"]) {
			return @"iPad 4 (CDMA)";
		} else if ([deviceString isEqualToString:@"iPad4,1"]) {
			return @"iPad Air";
		} else if ([deviceString isEqualToString:@"iPad4,2"]) {
			return @"iPad Air";
		} else if ([deviceString isEqualToString:@"iPad4,3"]) {
			return @"iPad Air";
		} else if ([deviceString isEqualToString:@"iPad5,3"]) {
			return @"iPad Air 2";
		} else if ([deviceString isEqualToString:@"iPad5,4"]) {
			return @"iPad Air 2";
		} else if ([deviceString isEqualToString:@"iPad6,7"]
				   || [deviceString isEqualToString:@"iPad6,8"]) {
			return @"iPad Pro (12.9-inch)";
		} else if ([deviceString isEqualToString:@"iPad6,3"]
				   || [deviceString isEqualToString:@"iPad6,4"]) {
			return @"iPad Pro (9.7-inch)";
		} else if ([deviceString isEqualToString:@"iPad6,11"]
				   || [deviceString isEqualToString:@"iPad6,12"]) {
			return @"iPad 5";
		} else if ([deviceString isEqualToString:@"iPad7,1"]
				   || [deviceString isEqualToString:@"iPad7,2"]) {
			return @"iPad Pro (12.9-inch 2G)";
		} else if ([deviceString isEqualToString:@"iPad7,3"]
				   || [deviceString isEqualToString:@"iPad7,4"]) {
			return @"iPad Pro (10.5-inch)";
		} else if ([deviceString isEqualToString:@"iPad4,7"]
				   ||[deviceString isEqualToString:@"iPad4,8"]
				   ||[deviceString isEqualToString:@"iPad4,9"]) {
			return @"iPad mini 3";
			
		} else if ([deviceString isEqualToString:@"iPad5,1"]
				   ||[deviceString isEqualToString:@"iPad5,2"]) {
			return @"iPad mini 4";
		} else {
			return @"iPad";
		}
		
	} else if ([deviceString hasPrefix:@"Watch"]) {
		//TODO Apple Watch
		
	} else if ([deviceString hasPrefix:@"AppleTV"]) {
		//TODO Apple TV
	} else {
		if ([deviceString isEqualToString:@"i386"]
			|| [deviceString isEqualToString:@"x86_64"])
			return @"Simulator";
	}
	
	return deviceString;
}

+ (NSString *)ps_deviceCPUArchiveName {
	const NXArchInfo *info = NXGetLocalArchInfo();
	NSString *typeOfCpu = [NSString stringWithUTF8String:info->description];
	return typeOfCpu;
}

+ (NSString *)ps_deviceLocalLanguage {
	NSString *language = [[NSBundle mainBundle] preferredLocalizations].firstObject;
	return language;
}

+ (BOOL)ps_isiPad {
	return [[[self ps_devicePlatform] substringToIndex:4] isEqualToString:@"iPad"];
}

+ (BOOL)ps_isiPhone {
	return [[[self ps_devicePlatform] substringToIndex:6] isEqualToString:@"iPhone"];
}

+ (BOOL)ps_isiPod {
	return [[[self ps_devicePlatform] substringToIndex:4] isEqualToString:@"iPod"];
}

+ (BOOL)ps_isSimulator {
	return [[self ps_devicePlatform] isEqualToString:@"i386"]
	|| [[self ps_devicePlatform] isEqualToString:@"x86_64"];
}

+ (BOOL)ps_isRetina {
	return [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
	&& ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0);
}

+ (BOOL)ps_isRetinaHD {
	return [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
	&& ([UIScreen mainScreen].scale == 3.0);
}

+ (NSString *)ps_iOSVersionString {
	return [[UIDevice currentDevice] systemVersion];
}

+ (NSInteger)ps_iOSVersion {
	return [[[UIDevice currentDevice] systemVersion] integerValue];
}

+ (NSUInteger)ps_cpuFrequency {
	return [self _getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)ps_busFrequency {
	return [self _getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ps_ramSize {
	return [self _getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)ps_cpuNumber {
	return [self _getSysInfo:HW_NCPU];
}

+ (NSUInteger)ps_totalMemory {
	return [self _getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)ps_userMemory {
	return [self _getSysInfo:HW_USERMEM];
}

+ (NSNumber *)ps_totalDiskSpace {
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *)ps_freeDiskSpace {
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemFreeSize];
}

+ (NSString *)ps_macAddress {
	int                 mib[6];
	size_t              len;
	char                *buf;
	unsigned char       *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl  *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error\n");
		return NULL;
	}
	
	if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1\n");
		return NULL;
	}
	
	if((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. Rrror!\n");
		return NULL;
	}
	
	if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
						   *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	
	return outstring;
}

+ (NSString *)ps_uniqueIdentifier {
	NSString *uuid;
	if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
		uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
	} else {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		uuid = [defaults objectForKey:BFUniqueIdentifierDefaultsKey];
		if (!uuid) {
			uuid = [self _generateUUID];
			[defaults setObject:uuid forKey:BFUniqueIdentifierDefaultsKey];
			[defaults synchronize];
		}
	}
	return uuid;
}

+ (NSString *)ps_UUIDString {
	return [NSUUID UUID].UUIDString;
}

#pragma mark - Private
+ (NSUInteger)_getSysInfo:(uint)typeSpecifier {
	size_t size = sizeof(int);
	int results;
	int mib[2] = {CTL_HW, typeSpecifier};
	sysctl(mib, 2, &results, &size, NULL, 0);
	return (NSUInteger) results;
}

+ (NSString *)_generateUUID {
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return (__bridge_transfer NSString *)string;
}

@end
