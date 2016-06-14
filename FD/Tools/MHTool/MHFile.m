//
//  MHFile.m
//  YangziNew
//
//  Created by yao wang on 11-11-2.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import "MHFile.h"
#define kDSRoot @"Documents/"

@implementation MHFile

/*
 * 函数作用: 根据文件名称获取资源文件路径
 * 函数参数: filename  文件名称
 * 函数返回值: 返回资源文件路径
 */
+(NSString *)getResourcesFile:(NSString *)fileName
{
	return [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
}

/*
 * 函数作用: 根据文件名称获取Doc目录中文件路径
 * 函数参数: fileName  文件名称
 * 函数返回值: 返回Doc目录中文件路径
 */
+(NSString *)getLocalFilePath:(NSString *) fileName
{
	return [NSString stringWithFormat:@"%@/%@%@", NSHomeDirectory(),kDSRoot,fileName];
}

/*
 * 函数作用: 根据文件名称获取缓存目录中文件路径
 * 函数参数: fileName  文件名称
 * 函数返回值: 返回Doc目录中文件路径
 */
+(NSString *)getCacheFilePath:(NSString *)fileName{
    return [NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(),fileName];
}

/*
 * 函数作用: 根据目录名称创建文件夹目录
 * 函数参数: dir 目录名称
 * 函数返回值: 返回文件夹目录名称
 */
+(NSString *)createDir:(NSString *)dir
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *path=[self getLocalFilePath:dir];
	BOOL bDir = NO;
	[fm fileExistsAtPath:path isDirectory:&bDir];
	if(bDir==YES) 
    {
        return path;
    }
    
	NSError **error=NULL;
	[fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    
	return path;
}

/*
 * 函数作用: 根据目录路径创建文件夹目录
 * 函数参数: 文件夹目录绝对路径
 * 函数返回值: N/A
 */
+(void)createDirWithDirPath:(NSString *)path
{
	NSFileManager *fm = [NSFileManager defaultManager];
	
	BOOL bDir = NO;
	[fm fileExistsAtPath:path isDirectory:&bDir];
	if(bDir==YES) return;
	
	NSError **error=NULL;
	[fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
	return;
}


/*
 * 函数作用: 根据文件名判断Doc目录中是否存在
 * 函数参数: fileName 文件目录名称
 * 函数返回值: 是否存在 BOOL  YES (存在) NO (不存在)
 */
+(BOOL)isExistsFileInDoc:(NSString *)fileName
{
	NSFileManager *fm = [NSFileManager defaultManager];
	return [fm fileExistsAtPath:[self getLocalFilePath:fileName]];
}

/*
 * 函数作用: copy文件
 * 函数参数: srcPath--原始文件  dstPath--目标文件
 * 函数返回值: 
 */
+(BOOL)copyFile:(NSString *)srcPath dstPath:(NSString *)dstPath{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError **error=NULL;
    return [fm copyItemAtPath:srcPath toPath:dstPath error:error];
}

/*
 * 函数作用: 根据文件名判断资源文件中是否存在
 * 函数参数: fileName 文件目录名称
 * 函数返回值: 是否存在 BOOL  YES (存在) NO (不存在)
 */
+(BOOL)isExistsFileInRescource:(NSString *)fileName
{
	NSFileManager *fm = [NSFileManager defaultManager];
	return [fm fileExistsAtPath:[self getResourcesFile:fileName]];
}

/*
 * 函数作用: 根据文件路径判断是否存在
 * 函数参数: filePath 文件目录名称
 * 函数返回值: 是否存在 BOOL  YES (存在) NO (不存在)
 */
+(BOOL)isExistsFile:(NSString *)filePath
{
	NSFileManager *fm = [NSFileManager defaultManager];
	return [fm fileExistsAtPath:filePath];
}


/*
 * 函数作用: 根据文件路径获取文件名称
 * 函数参数: filepath  文件的绝对路径
 * 函数返回值: 文件名称 (带文件类型的）
 */
+(NSString *)getFileNameByPath:(NSString *)filepath
{
	NSArray *array=[filepath componentsSeparatedByString:@"/"];
	if (array.count==0) return filepath;
	
	return [array objectAtIndex:array.count-1];
}

/*
 * 函数作用:  根据文件路径删除目录
 * 函数参数:  filepath 文件路径
 * 函数返回值: N/A
 */
+(void)removeDirByPath:(NSString *)filepath
{
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm removeItemAtPath:filepath error:nil];
}

/*
 * 函数作用:  根据文件名称删除目录
 * 函数参数:  fileName 文件目录名称
 * 函数返回值: N/A
 */
+(void)removeDirByName:(NSString *)fileName
{
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm removeItemAtPath:[self getLocalFilePath:fileName] error:nil];
}

//函数作用:  获取文件目录下所有文件名称
+(NSArray *)getAllFileByName:(NSString *)path
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];	
	NSArray *array = [defaultManager contentsOfDirectoryAtPath:path error:nil];
    return array;
}
@end
