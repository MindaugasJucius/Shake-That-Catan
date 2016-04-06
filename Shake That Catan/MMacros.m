//
//  MMacros.m
//  Shake That Catan
//
//  Created by Mindaugas Jucius on 25/02/16.
//  Copyright © 2016 mindawg. All rights reserved.
//

#import "MMacros.h"
#import <sys/utsname.h>

@implementation MMacros

+ (BOOL)IS_IPHONE_6_PLUS {
    return [[self deviceType] isEqualToString:@"iPhone 6 Plus"] ||  [[self deviceType] isEqualToString:@"iPhone 6S Plus"];
}

+ (BOOL)IS_IPHONE_6 {
    return [[self deviceType] isEqualToString:@"iPhone 6"] || [[self deviceType] isEqualToString:@"iPhone 6S"];
}

+ (BOOL)IS_IPHONE_6S_OR_IPHONE6S_PLUS {
    return [[self deviceType] isEqualToString:@"iPhone 6S Plus"] || [[self deviceType] isEqualToString:@"iPhone 6S"];
}

+ (BOOL)IS_SIMULATOR {
    return [[self deviceType] isEqualToString:@"32-bit Simulator"]
    || [[self deviceType] isEqualToString:@"64-bit Simulator"];
}

+ (BOOL)IS_IPHONE_5 {
    NSString *device = [self deviceType];
    BOOL result = [device isEqualToString:@"iPhone 5(GSM)"] || [device isEqualToString:@"iPhone 5(GSM+CDMA)"]
    || [device isEqualToString:@"iPhone 5C(GSM)"] || [device isEqualToString:@"iPhone 5C(GSM+CDMA)"]
    || [device isEqualToString:@"iPhone 5S(GSM)"] || [device isEqualToString:@"iPhone 5S(GSM+CDMA)"];
    return result;
}

/*
 @"i386"      on 32-bit Simulator
 @"x86_64"    on 64-bit Simulator
 @"iPod1,1"   on iPod Touch
 @"iPod2,1"   on iPod Touch Second Generation
 @"iPod3,1"   on iPod Touch Third Generation
 @"iPod4,1"   on iPod Touch Fourth Generation
 @"iPod5,1"   on iPod Touch Fifth Generation
 @"iPhone1,1" on iPhone
 @"iPhone1,2" on iPhone 3G
 @"iPhone2,1" on iPhone 3GS
 @"iPad1,1"   on iPad
 @"iPad2,1"   on iPad 2
 @"iPad3,1"   on 3rd Generation iPad
 @"iPad3,2":  on iPad 3(GSM+CDMA)
 @"iPad3,3":  on iPad 3(GSM)
 @"iPad3,4":  on iPad 4(WiFi)
 @"iPad3,5":  on iPad 4(GSM)
 @"iPad3,6":  on iPad 4(GSM+CDMA)
 @"iPhone3,1" on iPhone 4
 @"iPhone4,1" on iPhone 4S
 @"iPad3,4"   on 4th Generation iPad
 @"iPad2,5"   on iPad Mini
 @"iPhone5,1" on iPhone 5(GSM)
 @"iPhone5,2" on iPhone 5(GSM+CDMA)
 @"iPhone5,3  on iPhone 5c(GSM)
 @"iPhone5,4" on iPhone 5c(GSM+CDMA)
 @"iPhone6,1" on iPhone 5s(GSM)
 @"iPhone6,2" on iPhone 5s(GSM+CDMA)
 @"iPhone7,1" on iPhone 6 Plus
 @"iPhone7,2" on iPhone 6
 @"iPhone8,1" on iPhone 6
 @"iPhone8,2" on iPhone 6 Plus ...Yes Apple switched the order...
 */

+ (NSString *)deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *result = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSDictionary *matches = @{
                              @"i386" : @"32-bit Simulator",
                              @"x86_64" : @"64-bit Simulator",
                              @"iPod1,1" : @"iPod Touch",
                              @"iPod2,1" : @"iPod Touch Second Generation",
                              @"iPod3,1" : @"iPod Touch Third Generation",
                              @"iPod4,1" : @"iPod Touch Fourth Generation",
                              @"iPod5,1" : @"iPod Touch Fifth Generation",
                              @"iPhone1,1" : @"iPhone",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPad1,1" : @"iPad",
                              @"iPad2,1" : @"iPad 2",
                              @"iPad3,1" : @"3rd Generation iPad",
                              @"iPad3,2" : @"iPad 3(GSM+CDMA)",
                              @"iPad3,3" : @"iPad 3(GSM)",
                              @"iPad3,4" : @"iPad 4(WiFi)",
                              @"iPad3,5" : @"iPad 4(GSM)",
                              @"iPad3,6" : @"iPad 4(GSM+CDMA)",
                              @"iPhone3,1" : @"iPhone 4",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPad3,4" : @"4th Generation iPad",
                              @"iPad2,5" : @"iPad Mini",
                              @"iPhone5,1" : @"iPhone 5(GSM)",
                              @"iPhone5,2" : @"iPhone 5(GSM+CDMA)",
                              @"iPhone5,3" : @"iPhone 5C(GSM)",
                              @"iPhone5,4" : @"iPhone 5C(GSM+CDMA)",
                              @"iPhone6,1" : @"iPhone 5S(GSM)",
                              @"iPhone6,2" : @"iPhone 5S(GSM+CDMA)",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6S",
                              @"iPhone8,2" : @"iPhone 6S Plus"
                              };
    
    if (matches[result]) {
        return matches[result];
    } else {
        return result;
    }
}


@end
