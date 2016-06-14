//
//  ShareDataManager.m
//  FD
//
//  Created by Leo xu on 10/30/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

#import "ShareDataManager.h"

NSString * const k_downloadDictUrl = @"Url";
NSString * const k_downloadDictDelegate = @"delegate";
NSString * const k_downloadDictTag = @"tag";

ShareDataManager *shareDataManager;


@interface ShareDataManager ()

@property (nonatomic, retain)HttpDownload *httpDownload;
@property (nonatomic, retain)HttpDownload *httpDownloadMuti;
@property (nonatomic, retain)NSMutableDictionary *downloadDict;
@property (nonatomic, retain) HTTPManager *httpManager;

@end



@implementation ShareDataManager

-(id)init
{
    if (self = [super init]) {
        _tempDataDict = [[NSMutableDictionary alloc] init];
        _formatter = [[NSDateFormatter alloc] init];
        _httpDownload = [[HttpDownload alloc] initWithdelegate:self];
        [_httpDownload setMaxOperationCount:1];
        _httpDownloadMuti = [[HttpDownload alloc] initWithdelegate:self];
        _downloadDict = [[NSMutableDictionary alloc] init];
        _unzipArray = [[NSMutableArray alloc] init];
        _httpManager = [[HTTPManager alloc] init];
        _httpManager.delegate = self;
//        self.zipArchiveManager = [FZipArchiveManager defaultManager];
    }
    return self;
}

-(void)dealloc
{
//    [_formatter release];
//    [_tempDataDict release];
    [_httpDownload setDelegate:nil];
    [_httpDownloadMuti setDelegate:nil];
//    [_httpDownloadMuti release];
//    [_downloadDict release];
//    [_httpDownload release];
//    [_unzipArray release];
//    self.zipArchiveManager = nil;
    _httpManager.delegate = nil;
//    [_httpManager release];
//    [super dealloc];
}

//TODO:获取单例
+ (ShareDataManager *)sharedShareDataManager
{
    if (!shareDataManager) {
        shareDataManager = [[ShareDataManager alloc] init];
    }
    return shareDataManager;
}

//TODO:销毁单例
+(void)destory
{
//    [shareDataManager release];
    shareDataManager = nil;
}

#pragma mark -
#pragma mark ===============Methods================
//TODO:判断邮箱是否合法
+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}
//TODO:判断手机号是否合法
+ (BOOL)isValidatePhoneNum:(NSString *)phoneNum
{
    NSString *phoneRegex = @"^((13)|(15)|(18))\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL qualified = [phoneTest evaluateWithObject:phoneNum];
    if (!qualified) {
        NSString *phoneRegex = @"^((147)|(170)|(177)|(178)|(188))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        qualified = [phoneTest evaluateWithObject:phoneNum];
        
    }
    return qualified;
}

//TODO:判断身份证号是否合法
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//TODO:判断字符 是否 为空
+(BOOL)getText:(NSString *)str{
    if ([str isEqualToString:@""] || str == nil || str.length == 0) {
        return YES;
    }else{
       return NO;
    }
}

//TODO:计算字符串长度
+ (int)textLength:(NSString *)text
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number+=2;
        }
        else
        {
            number ++;
        }
    }
    return ceil(number);
}


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    if (!stringToConvert || ![stringToConvert isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];//字符串处理
    //例子，stringToConvert #ffffff
    if ([cString length] < 6)
        return [UIColor whiteColor];//如果非十六进制，返回白色
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];//去掉头
    if ([cString length] != 6)//去头非十六进制，返回白色
        return [UIColor whiteColor];
    //分别取RGB的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //转换为UIColor
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


#pragma mark ====== method ===============
//TODO:存储临时数据
-(void)saveTempObject:(id)object ForKey:(NSString*)key
{
    [_tempDataDict setObject:object forKey:key];
}
//TODO:读取临时数据
-(id)loadTempObjectForKey:(NSString *)key
{
    return [_tempDataDict objectForKey:key];
}
//TODO:删除临时数据
-(void)removeTempObjectForKey:(NSString *)key
{
    [_tempDataDict removeObjectForKey:key];
}
//TODO:清空临时数据
-(void)removeAllTempObject
{
    [_tempDataDict removeAllObjects];
}

#pragma mark ======download  method ===============

//TODO:挂载下载服务
+(void)downloadWithUrl:(NSString *)url key:(NSString *)key delegate:(id)delegate userInfo:(id)userInfo tag:(int)tag
{
    ShareDataManager *manager = [ShareDataManager sharedShareDataManager];
    if (tag) {
        [manager.httpDownloadMuti startWithinfoNode:userInfo Url:url md5Key:key];
    }
    else
    {
        [manager.httpDownload startWithinfoNode:userInfo Url:url md5Key:key];
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:url forKey:k_downloadDictUrl];
    if (delegate) {
        [dict setObject:delegate forKey:k_downloadDictDelegate];
    }
    [dict setObject:[NSNumber numberWithInt:tag] forKey:k_downloadDictTag];
    [manager.downloadDict setObject:dict forKey:key];
}

+(NSInteger)downloadWithUrls:(NSArray *)urls delegate:(id)delegate userInfo:(id)userInfo tag:(int)tag
{
    for (NSString *url in urls) {
        [ShareDataManager downloadWithUrl:url key:url delegate:delegate userInfo:userInfo tag:tag];
    }
    NSSet *set = [NSSet setWithArray:urls];
    return [set allObjects].count;
}

//TODO:取消下载
+(void)cancelDownload:(NSString *)key
{
    ShareDataManager *manager = [ShareDataManager sharedShareDataManager];
    NSMutableDictionary *dict = [manager.downloadDict objectForKey:key];
    if (dict) {
        NSString *url = [dict objectForKey:k_downloadDictUrl];
        [dict removeObjectForKey:k_downloadDictDelegate];
        if (url) {
            int tag = [[dict objectForKey:k_downloadDictTag] intValue];
            if (tag) {
                [manager.httpDownloadMuti removeDownLoadingNodeWithUrl:url];
            }
            else
                [manager.httpDownload removeDownLoadingNodeWithUrl:url];
        }
    }
}

//TODO:重置代理
+(void)setDownloadDelegate:(id)delegate key:(NSString *)key
{
    ShareDataManager *manager = [ShareDataManager sharedShareDataManager];
    NSMutableDictionary *dict = [manager.downloadDict objectForKey:key];
    if (dict) {
        if (delegate) {
            [dict setObject:delegate forKey:k_downloadDictDelegate];
        }
        else
            [dict removeObjectForKey:k_downloadDictDelegate];
    }
}

//TODO:清空代理
+(void)cleanDelegate:(id)delegate
{
    ShareDataManager *manager = [ShareDataManager sharedShareDataManager];
    
    for (NSMutableDictionary *dict in manager.downloadDict.allValues) {
        id nodeDelegate = [dict objectForKey:k_downloadDictDelegate];
        if (delegate == nodeDelegate) {
            [dict removeObjectForKey:k_downloadDictDelegate];
        }
    }
}

//TODO:是否存在文件下载
+(BOOL)isExistDownloadWithUrl:(NSString *)url
{
    ShareDataManager *manager = [ShareDataManager sharedShareDataManager];
    NSDictionary *dict = [manager.downloadDict objectForKey:url];
    if (dict) {
        return YES;
    }
    return NO;
}

//TODO:文件是否存在
+(BOOL)isExistDownloadFileWithUrl:(NSString *)url
{
    return [HttpDownload isExistFileWithMd5Key:url];
}
//TODO:是否存在缓存文件
+(BOOL)isExistCacheFileWithUrl:(NSString *)url
{
    return [HttpDownload isExistCacheFileWithMd5Key:url];
}

//TODO:删除下载文件和缓存文件
+(void)cleanDownloadFileWithUrl:(NSString *)url
{
    ShareDataManager *manager = [ShareDataManager sharedShareDataManager];
    [manager.httpDownload removeCacheWithMd5Key:url];
    [manager.httpDownload removeDownloadedFileWithMd5Key:url];
}




////TODO:下载代理
//-(void)downloadDone:(HttpQueueNode *)node
//{
//    NSDictionary *dict = [self.downloadDict objectForKey:node.url];
//    if (dict) {
//        
//        FZipRequest *zipReq =[[FZipRequest alloc] init];
//        NSString *destPath = nil;
//        if ([node.infoNode isKindOfClass:[SkinNode class]]) {
//            destPath = [SkinManager getPathWithKey:node.url];
//        }
//        if ([node.infoNode isKindOfClass:[MyNewsOffLineNode class]]) {
//            destPath = [MyNewsOffLineManager getPathWithKey:node.url];
//        }
//        zipReq.zipFilePath = [HttpDownload filePathWithMd5Key:node.url];
//        zipReq.unZipFilePath = destPath;
//        zipReq.type = ZIP_TO_UNZIP;
//        zipReq.userInfo = node;
//        
//        __block __weak FZipRequest *weakUnzip = zipReq;
//        
//        zipReq.finishUnzipHandler = ^{
//            HttpQueueNode *qeueNode = weakUnzip.userInfo;
//            [MHTool removeDirByPath:[HttpDownload filePathWithMd5Key:qeueNode.url]];
//            [_unzipArray removeObject:qeueNode];
//            id <HttpDownloadDelegate> delegate = [dict objectForKey:k_downloadDictDelegate];
//            if (delegate && [delegate respondsToSelector:@selector(downloadDone:)]) {
//                [delegate downloadDone:node];
//            }
//        };
//        [_unzipArray addObject:node];
//        [_zipArchiveManager addTask:zipReq];
//        [zipReq release];
//    }
//    [self.downloadDict removeObjectForKey:node.url];
//
//}
//-(void)downloadError:(HttpQueueNode *)node
//{
//    NSDictionary *dict = [self.downloadDict objectForKey:node.url];
//    if (dict) {
//        id <HttpDownloadDelegate> delegate = [dict objectForKey:k_downloadDictDelegate];
//        if (delegate && [delegate respondsToSelector:@selector(downloadError:)]) {
//            [delegate downloadError:node];
//        }
//    }
//    [self.downloadDict removeObjectForKey:node.url];
//
//}
//-(void)downloading:(HttpQueueNode *)node
//{
//    NSDictionary *dict = [self.downloadDict objectForKey:node.url];
//    if (dict) {
//        id <HttpDownloadDelegate> delegate = [dict objectForKey:k_downloadDictDelegate];
//        if (delegate && [delegate respondsToSelector:@selector(downloading:)]) {
//            [delegate downloading:node];
//        }
//    }
//}


@end
