//
//  DeviceTool.m
//  MemorTest
//
//  Created by fuzhifei on 11-10-26.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import "MHDeviceTool.h"
#import <UIKit/UIKit.h>

// mac调用类
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation MHDeviceTool

#pragma mark -

//判断设备是否为iPad
+(BOOL)isiPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

//是否为高清
+(BOOL)isRetina
{
    return ([UIScreen mainScreen].scale > 1.0);
}

//是否iphone（非Touch,ipad）
+ (BOOL)isiPhone
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType length] >=6){
        NSString *device = [deviceType substringToIndex:6];
        
        return [device isEqualToString:@"iPhone"];
    }
    
    return NO;
    
}
//获取当前设备的model
+(NSString *)deviceModel
{
	UIDevice *device=[UIDevice currentDevice];
	return device.model;
}

//判断相机是否可用
+ (BOOL)isCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//获取区域标志符（非语言标志）
+(NSString *)localeIdentifier
{
    NSLocale *frLocale = [NSLocale autoupdatingCurrentLocale];
    return frLocale.localeIdentifier;
}


/*
//获取设备标志符  ios 5.0 后弃用
+(NSString *)deviceIdentifier{
    UIDevice *myDevice=[UIDevice currentDevice];
    return myDevice.uniqueIdentifier;
}
 */

//电池量
+ (float)batteryLevel
{
    return [[UIDevice currentDevice] batteryLevel];
}


#pragma mark -
+ (float) sysInfo: (uint) typeSpecifier
{
    
    size_t size = sizeof(int);
    
    int results;
    
    int mib[2] = {CTL_HW, typeSpecifier};
    
    sysctl(mib, 2, &results, &size, NULL, 0);
    
    return (NSUInteger) results * 1.0;
    
}


//cpu是用频率
+ (float) cpuFrequency
{
    
    return [self sysInfo:HW_CPU_FREQ] * 1.0;
    
}

+ (float) busFrequency
{
    
    return [self sysInfo:HW_BUS_FREQ] * 1.0;
    
}

//总内存
+ (float) totalMemory
{
    
    return [self sysInfo:HW_PHYSMEM] * 1.0;
    
    //or
    //return NSRealMemoryAvailable() * 1.0;
    
}

//用户可使用内存 ？？
+ (float) userMemory
{
    
    return [self sysInfo:HW_USERMEM] * 1.0;
    
}

+ (float) maxSocketBufferSize
{
    
    return [self sysInfo:KIPC_MAXSOCKBUF] * 1.0;
    
}

#pragma mark file system —
#pragma mark file system — ios自带方法 推荐使用

//总磁盘空间
+ (float) totalDiskSpace
{
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [[fattributes objectForKey:NSFileSystemSize] floatValue];
    
}

//剩余磁盘空间
+ (float) freeDiskSpace
{
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [[fattributes objectForKey:NSFileSystemFreeSize] floatValue];
    
}

//磁盘号
+(NSNumber *)diskNumber
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [fattributes objectForKey:NSFileSystemNumber];
}


#pragma mark file system — c方法

/*
 ..........................目录文件大小..........................
 */

//目录下所有文件大小
+(float)sizeOfDirectory:(NSString *)dir
{
    /*
	NSString* docDir = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(),dir];
	NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:docDir];
     */
    
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    
	NSString *pname;
	int64_t s=0;
	while (pname = [direnum nextObject])
    {
        //NSLog(@"pname   %@",pname);
		NSDictionary *currentdict=[direnum fileAttributes];
		NSString *filesize=[NSString stringWithFormat:@"%@",[currentdict objectForKey:NSFileSize]];
		NSString *filetype=[currentdict objectForKey:NSFileType];
		
		if([filetype isEqualToString:NSFileTypeDirectory]) continue;
		s=s+[filesize longLongValue];
	}
	
	return s*1.0;
}


/*
 ..........................转化显示..........................
 */

//将大小转化为格式,B,L,M,G之间的转换
+ (NSString *)convertFloatSizeToString:(float)size 
{
    if(size < 1024L * 1024L) {
		return [NSString stringWithFormat:@"%1.2fK", (float)size / 1024.0];
	} else if(size < 1024L * 1024L * 1024L) {
		return [NSString stringWithFormat:@"%1.2fM", (float)size / 1024.0 / 1024.0];
	} else {
		return [NSString stringWithFormat:@"%1.2fG", (float)size / 1024.0 / 1024.0 / 1024.0];
	}
    /*
	if(size < 1024L) {
		return [NSString stringWithFormat:@"%ldB", size];
	} else if(size < 1024L * 1024L) {
		return [NSString stringWithFormat:@"%1.2fK", (float)size / 1024.0];
	} else if(size < 1024L * 1024L * 1024L) {
		return [NSString stringWithFormat:@"%1.2fM", (float)size / 1024.0 / 1024.0];
	} else {
		return [NSString stringWithFormat:@"%1.2fG", (float)size / 1024.0 / 1024.0 / 1024.0];
	}
     */
}


/*
 ..........................磁盘..........................
 */

//剩余磁盘空间
+(float)getFreeDiskSpace
{
    
    NSString *str = @"~/Documents";
    
    int64_t size = 0;
    struct statfs disk_statfs;
    
	if(statfs([[str stringByExpandingTildeInPath] fileSystemRepresentation], &disk_statfs) == 0) {
		size=(int64_t)disk_statfs.f_bsize * (int64_t)disk_statfs.f_bavail;
    }
    
	return size*1.0;
}

//总磁盘空间
+(float)getTotalDiskSpace
{
    NSString *str = @"~/Documents";
    
    int64_t size = 0;
    struct statfs disk_statfs;
    
	if(statfs([[str stringByExpandingTildeInPath] fileSystemRepresentation], &disk_statfs) == 0) {
		size=(int64_t)disk_statfs.f_bsize * (int64_t)disk_statfs.f_blocks;
    }
    
	return size*1.0;
}


/*
 ..........................内存..........................
 */


+(float)freeMemory
{
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT; 
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount); 
    
    if(kernReturn == KERN_SUCCESS)
    {
        return vmStats.free_count * vm_page_size * 1.0;
    }
    
    return -1.0;
    
}


+(float)activeMemory
{
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT; 
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount); 
    
    if(kernReturn == KERN_SUCCESS)
    {
        return vmStats.active_count * vm_page_size * 1.0;
    }
    
    return -1.0;
    
}

+(float)inactiveMemory
{
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT; 
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount); 
    
    if(kernReturn == KERN_SUCCESS)
    {
        return vmStats.inactive_count * vm_page_size * 1.0;
    }
    
    return -1.0;
    
}


+(float)wireMemory
{
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT; 
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount); 
    
    if(kernReturn == KERN_SUCCESS)
    {
        return vmStats.wire_count * vm_page_size * 1.0;
    }
    
    return -1.0;
    
}

/**   函数名称 :macAddress
 **   函数作用 :得到mac
 **   函数参数 :  macAddress
 **   函数返回值: mac值
 **/
+(NSString *)macAddress
{
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
    
    if ((mib[5] = if_nametoindex("en0")) == 0) 
    {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) 
    {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 2");
        free(buf);
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

/*
BOOL memoryInfo(vm_statistics_data_t *vmStats) { 
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT; 
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)vmStats, &infoCount); 
    
    return kernReturn == KERN_SUCCESS; 
} 

//+(void)logMemoryInfo{
void logMemoryInfo() { 
    vm_statistics_data_t vmStats; 
    
    if (memoryInfo(&vmStats)) { 
        NSLog(@"free: %f\nactive: %f\ninactive: %f\nwire: %f\nzero fill: %f\nreactivations: %f\npageins: %f\npageouts: %f\nfaults: %f\ncow_faults: %f\nlookups: %f\nhits: %f", 
              vmStats.free_count * vm_page_size/1024*1.0/1024, 
              vmStats.active_count * vm_page_size/1024*1.0/1024, 
              vmStats.inactive_count * vm_page_size/1024*1.0/1024, 
              vmStats.wire_count * vm_page_size/1024*1.0/1024, 
              vmStats.zero_fill_count * vm_page_size/1024*1.0/1024, 
              vmStats.reactivations * vm_page_size/1024*1.0/1024, 
              vmStats.pageins * vm_page_size/1024*1.0/1024, 
              vmStats.pageouts * vm_page_size/1024*1.0/1024, 
              vmStats.faults/1024*1.0/1024, 
              vmStats.cow_faults/1024*1.0/1024, 
              vmStats.lookups/1024*1.0/1024, 
              vmStats.hits/1024*1.0/1024 
              ); 
    } 
} 
*/

@end
