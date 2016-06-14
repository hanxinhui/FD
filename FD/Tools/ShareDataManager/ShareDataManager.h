//
//  ShareDataManager.h
//  FD
//
//  Created by Leo xu on 10/30/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

//!!!!:公共数据区

#import <Foundation/Foundation.h>
#import "httpDownload.h"
//#import "FZipArchiveManager.h"
#import "HTTPManager.h"


@protocol ShareDataManagerDelegate <NSObject>

@optional

@end

@interface ShareDataManager : NSObject<HttpDownloadDelegate,HTTPManagerDelegate>
{
    NSMutableDictionary *_tempDataDict;
}

//代理
@property (nonatomic, assign) id <ShareDataManagerDelegate> delegate;
//dateFormatter
@property (nonatomic, retain) NSDateFormatter *formatter;
//解压
@property (nonatomic, retain) NSMutableArray *unzipArray;
//@property (nonatomic, retain) FZipArchiveManager *zipArchiveManager;


//TODO:获取单例
+(ShareDataManager *) sharedShareDataManager;
//TODO:销毁单例
+(void)destory;

//TODO:判断邮箱是否合法
+ (BOOL)isValidateEmail:(NSString *)Email;
//TODO:校验手机号是否合法
+ (BOOL)isValidatePhoneNum:(NSString *)phoneNum;
//TODO:计算字符串长度
+ (int)textLength:(NSString *)text;
//TODO:将16进制颜色字符串转化成UICOLOR
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

//TODO:存储临时数据
-(void)saveTempObject:(id)object ForKey:(NSString*)key;
//TODO:读取临时数据
-(id)loadTempObjectForKey:(NSString *)key;
//TODO:删除临时数据
-(void)removeTempObjectForKey:(NSString *)key;
//TODO:清空临时数据
-(void)removeAllTempObject;

//TODO:挂载下载服务
+(void)downloadWithUrl:(NSString *)url key:(NSString *)key delegate:(id)delegate userInfo:(id)userInfo tag:(int)tag;
+(NSInteger)downloadWithUrls:(NSArray *)urls delegate:(id)delegate userInfo:(id)userInfo tag:(int)tag;
//TODO:取消下载
+(void)cancelDownload:(NSString *)key;
//TODO:重置代理
+(void)setDownloadDelegate:(id)delegate key:(NSString *)key;
//TODO:清空代理
+(void)cleanDelegate:(id)delegate;
//TODO:是否存在文件下载
+(BOOL)isExistDownloadWithUrl:(NSString *)url;
//TODO:文件是否存在
+(BOOL)isExistDownloadFileWithUrl:(NSString *)url;
//TODO:缓存文件是否存在
+(BOOL)isExistCacheFileWithUrl:(NSString *)url;
//TODO:删除下载文件和缓存文件
+(void)cleanDownloadFileWithUrl:(NSString *)url;


//TODO:判断字符
+(BOOL)getText:(NSString *)str;

//TODO:判断身份证号是否合法
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
@end
