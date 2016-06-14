//
//  MHSystemTool.m
//  test
//
//  Created by libin li on 11-11-16.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import "MHSystemTool.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@implementation MHSystemTool

+ (NSString *)currentLocale
{
	NSLocale *locale=[NSLocale currentLocale];
	return [locale localeIdentifier];
}

+ (NSString *)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString *currentLanguage = [languages objectAtIndex:0];
	if (currentLanguage.length>2) {
		currentLanguage=[currentLanguage substringToIndex:2];
	}
    return currentLanguage;
}

+ (NSArray *)allLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    return languages;
}

+ (NSString *)deviceModel
{
	UIDevice *device=[UIDevice currentDevice];
	return device.model;
}
+ (NSDate *)stringDate:(NSString *)formatter string:(NSString *)string
{
	NSDateFormatter *dateFormatter= [[[NSDateFormatter alloc] init] autorelease];
	NSString *locale=[MHSystemTool currentLocale];
	[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:locale] autorelease]];
	[dateFormatter setDateFormat:formatter];
	return [dateFormatter dateFromString:string];
}

+ (BOOL )deviceCamera
{
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return YES;
    }else{
        return NO;
    }
}  
+ (NSString *)deivceVersion{
    
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deivceName{
    return [[UIDevice currentDevice] systemName];
}
+ (NSString *)deviceBattery{
    return [NSString stringWithFormat:@"%f",[[UIDevice currentDevice] batteryLevel]];
}
+ (BOOL)deviceDefinition{
    if ([[[UIDevice currentDevice]systemVersion] intValue]<4) {
        return NO;
    }else{
        return  YES;
    }
    
}

+(BOOL)locationService{
    return [CLLocationManager locationServicesEnabled];
}


/**   方法名称 :programVersion
 **   方法作用 :获取项目的版本号 
 **   方法参数 :
 **   方法返回值:项目的版本号  
 **/
+(double)programVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return [version doubleValue];
}

@end
