//
//  HttpDownload.h
//  vanVideo
//
//  Created by leo xu on 13-6-30.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "HttpQueueNode.h"
#import "ASINetworkQueue.h"

@protocol HttpDownloadDelegate <NSObject>
@optional
-(void)downloadDone:(HttpQueueNode *)node;
-(void)downloadError:(HttpQueueNode *)node;
-(void)downloading:(HttpQueueNode *)node;

@end


@interface HttpDownload : NSObject
{
    ASINetworkQueue       *_queue;
    NSMutableArray        *_nodes;
    id <HttpDownloadDelegate>   _delegate;
}

-(id)initWithdelegate:(id<HttpDownloadDelegate>)delegate;
-(void)setDelegate:(id<HttpDownloadDelegate>)delegate;
-(void)setMaxOperationCount:(int)maxOperationCount;
//开始下载
-(void)startWithinfoNode:(id)infoNode Url:(NSString *)url md5Key:(NSString*)md5Key;
//删除缓存
-(void)removeCacheWithMd5Key:(NSString *)md5Key;
//删除文件
-(void)removeDownloadedFileWithMd5Key:(NSString *)md5Key;
//获取下载列表
-(NSArray *)getDownLoadingNodes;
//删除正在下载的node
-(void)removeDownLoadingNode:(id)infoNode;
//删除正在下载的node
-(void)removeDownLoadingNodeWithUrl:(NSString *)url;
//是否存在文件
+(BOOL)isExistFileWithMd5Key:(NSString *)md5Key;
//是否存在缓存文件
+(BOOL)isExistCacheFileWithMd5Key:(NSString *)md5Key;
//获取对应文件的地址
+(NSString *)filePathWithMd5Key:(NSString *)md5Key;
@end
