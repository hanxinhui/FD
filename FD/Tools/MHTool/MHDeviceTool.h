//
//  DeviceTool.h
//  MemorTest
//
//  Created by fuzhifei on 11-10-26.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <sys/sysctl.h> 
#include <mach/mach.h>

#include <sys/stat.h>
#include <sys/mount.h>


@interface MHDeviceTool : NSObject

/* 
 方法名称 :isiPad
 方法作用 :判断当前设备类型
 方法参数 : 
 方法返回值:YES:iPad  NO:iPhone,iPod
 */
+(BOOL)isiPad;

/*
 方法名称 :是否iphone（非Touch,ipad）
 方法作用 :判断当前设备类型
 方法参数 :
 方法返回值:
 */
+ (BOOL)isiPhone;

/* 
 方法名称 :isRetina
 方法作用 :是否为高清
 方法参数 : 
 方法返回值:YES:高清
 */
+(BOOL)isRetina;

/* 
 方法名称 :isCameraAvailable
 方法作用 :判断相机是否可用
 方法参数 : 
 方法返回值:YES:可用 NO:不可用
 */
+ (BOOL)isCameraAvailable;

/* 
 方法名称 :deviceModel
 方法作用 :得到当前设备的model
 方法参数 : 
 方法返回值:model:iPhone,iPad,iPhone...
 */
+(NSString *)deviceModel;


/* 
 方法名称 :localeIdentifier
 方法作用 :获取区域标志符（非语言标志）
 方法参数 : 
 方法返回值:localeIdentifier
 */
+(NSString *)localeIdentifier;


/* 
 方法名称 :deviceIdentifier ios 5.0后弃用
 方法作用 :得到当前设备的唯一标志符
 方法参数 : 
 方法返回值:uniqueIdentifier
 */
//+(NSString *)deviceIdentifier;

/* 
 方法名称 :deviceIdenbatteryLeveltifier
 方法作用 :获取当前电池量
 方法参数 : 
 方法返回值:电池量
 */
+ (float)batteryLevel;

/*
 方法名称：sysInfo:
 作用：获取系统信息
 参数：GetSysInfo
 返回值：
 */
+ (float) sysInfo: (uint) typeSpecifier;


/*
 方法名称：cpuFrequency
 作用：cpu使用频率
 参数：
 返回值：
 */
+ (float) cpuFrequency;


/*
 方法名称：busFrequency
 作用：获取总线频率
 参数：
 返回值：
 */
+ (float) busFrequency;


/*
 方法名称：totalMemory
 作用：获取设备总内存
 参数：
 返回值：
 */
+ (float) totalMemory;


/*
 方法名称：userMemory
 作用：获取用户内存
 参数：
 返回值：
 */
+ (float) userMemory;


/*
 方法名称：maxSocketBufferSize
 作用：获取socketBufferSize
 参数：
 返回值：
 */
+ (float) maxSocketBufferSize;

#pragma mark - Disk

/*
 .....................ios方法.....................
 */

/*
 方法名称：totalDiskSpace
 作用：获取总磁盘空间
 参数：
 返回值：
 */
+ (float) totalDiskSpace;


/*
 方法名称：freeDiskSpace
 作用：获取空余磁盘空间
 参数：
 返回值：
 */
+ (float) freeDiskSpace;


/*
 方法名称：diskNumber
 作用：获取磁盘设备号
 参数：
 返回值：
 */
+(NSNumber *)diskNumber;

/*
 .....................ios方法.....................
 */




/*
 .....................c方法.....................
 */
/*
 方法名称：getFreeDiskSpace
 作用：获取可用磁盘空间大小
 参数：
 返回值：
 */
+(float)getFreeDiskSpace;


/*
 方法名称：getTotalDiskSpace
 作用：获取磁盘总大小
 参数：
 返回值：
 */
+(float)getTotalDiskSpace;


/*
 .....................c方法.....................
 */


#pragma mark - 文件夹或文件大小

/*
 方法名称：sizeOfDirectory:
 作用：获取路径下文件的大小
 参数：dir：文件或文件夹目录
 返回值：
 */
+(float)sizeOfDirectory:(NSString *)dir;


#pragma mark - Memory

/*
 方法名称：freeMemory
 作用：获取可用内存
 参数：
 返回值：
 */
+(float)freeMemory;


/*
 方法名称：activeMemory
 作用：获取已使用但可被分割的内存
 参数：
 返回值：
 */
+(float)activeMemory;


/*
 方法名称：inactiveMemory
 作用：获取非活跃内存
 参数：
 返回值：
 */
+(float)inactiveMemory;


/*
 方法名称：wireMemory
 作用：获取已使用，且不可被分页的内存
 参数：
 返回值：
 */
+(float)wireMemory;


/*
 方法名称：GetFloatSizeString
 作用：将大小转化为KB，MB，GB
 参数：size:大小
 返回值：
 */
+ (NSString*)convertFloatSizeToString:(float)size;

/**   函数名称 :macAddress
 **   函数作用 :得到mac
 **   函数参数 :  macAddress
 **   函数返回值: mac值
 **/
+(NSString *)macAddress;

@end
