//
//  HttpDownload.m
//  vanVideo
//
//  Created by leo xu on 13-6-30.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#import "HttpDownload.h"
#import "MHFile.h"
#import "MHTool.h"

const static int nMaxConcurrentDownloadCount = 3;

@implementation HttpDownload
-(id)init
{
    self = [super init];
    if (self) {
        _queue = [[ASINetworkQueue alloc] init];
        [_queue setShouldCancelAllRequestsOnFailure:NO];
        [_queue setShowAccurateProgress:YES];
        [_queue setMaxConcurrentOperationCount:nMaxConcurrentDownloadCount];
        
        _nodes = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithdelegate:(id)delegate{
    self=[super init];
    if (self) {
        _delegate=delegate;
        _queue = [[ASINetworkQueue alloc] init];
        [_queue setShouldCancelAllRequestsOnFailure:NO];
        [_queue setShowAccurateProgress:YES];
        [_queue setMaxConcurrentOperationCount:nMaxConcurrentDownloadCount];
        _nodes = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setMaxOperationCount:(int)maxOperationCount
{
    [_queue setMaxConcurrentOperationCount:maxOperationCount];

}

-(void)dealloc{
    //    NSLog(@"%s,%d",__func__,__LINE__);
    _delegate=nil;
    
    if (_queue) {
        [_queue cancelAllOperations];
        _queue.delegate = nil;
        [_queue release];
        _queue=nil;
    }
    
    if (_nodes) {
        [_nodes release];
        _nodes = nil;
    }
    [super dealloc];
}
//设置代理
-(void)setDelegate:(id)delegate
{
    _delegate = delegate;
}
//开始下载
-(void)startWithinfoNode:(id)infoNode Url:(NSString *)url md5Key:(NSString*)md5Key{
    
    HttpQueueNode *node = [[HttpQueueNode alloc] init];
    node.infoNode = infoNode;
    node.state = HTTP_DOWNLOADING;
    node.url = url;
    [_nodes addObject:node];
    
    NSString *filepath=[NSString stringWithFormat:@"%@",[MHTool getCacheFilePath:[MHTool stringToMD5Value:md5Key]]];
    
    ASIHTTPRequest *request=[[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]] retain];
    [request setDelegate:self];
    [request setDownloadProgressDelegate:self];
    [request setTemporaryFileDownloadPath:[NSString stringWithFormat:@"%@.Cache",filepath]];
    [request setDownloadDestinationPath:filepath];
    [request setAllowResumeForFileDownloads:YES];
    [request setThreadPriority:NSOperationQueuePriorityLow];
    NSDictionary *reqDict = [[NSDictionary alloc] initWithObjectsAndKeys:node,@"nodeInfo", nil];
    [request setUserInfo:reqDict];
    
    [_queue addOperation:request];
    
    NSLog(@"_queue %@",[_queue operations]);
    [_queue go];
    
    [reqDict release];
    [node release];
    [request release];
    
}


+(BOOL)isExistFileWithMd5Key:(NSString *)md5Key
{
    NSString *filepath=[MHTool getCacheFilePath:[MHTool stringToMD5Value:md5Key]];
    return[MHFile isExistsFile:filepath];
}

+(BOOL)isExistCacheFileWithMd5Key:(NSString *)md5Key
{
    NSString *filepath=[MHTool getCacheFilePath:[MHTool stringToMD5Value:md5Key]];
    NSString *cachePath = [NSString stringWithFormat:@"%@.Cache",filepath];
    return[MHFile isExistsFile:cachePath];
}

//删除缓存
-(void)removeCacheWithMd5Key:(NSString *)md5Key
{
    NSString *filepath=[MHTool getCacheFilePath:[MHTool stringToMD5Value:md5Key]];
    NSString *cachePath = [NSString stringWithFormat:@"%@.Cache",filepath];
    [MHFile removeDirByPath:cachePath];
}
//删除文件
-(void)removeDownloadedFileWithMd5Key:(NSString *)md5Key
{
    NSString *filepath=[MHTool getCacheFilePath:[MHTool stringToMD5Value:md5Key]];
    [MHFile removeDirByPath:filepath];
}


//获取正在下载的node
-(NSArray *)getDownLoadingNodes
{
    return _nodes;
}

//删除正在下载的node
-(void)removeDownLoadingNode:(id)infoNode
{
    for (ASIHTTPRequest *request in [_queue operations]) {
        NSDictionary *dict = request.userInfo;
        HttpQueueNode *node = [dict objectForKey:@"nodeInfo"];
        if (infoNode == node.infoNode) {
            [request clearDelegatesAndCancel];
            NSLog(@"_queue %@",[_queue operations]);
            
            for (HttpQueueNode *httpNode in _nodes) {
                if (httpNode.infoNode == infoNode) {
                    httpNode.state = HTTP_DOWNLOAD_SUSPEND;
                    [_nodes removeObject:httpNode];
                    break;
                }
            }
        }
    }
    
}

//TODO:删除节点
-(void)removeDownLoadingNodeWithUrl:(NSString *)url
{
    for (ASIHTTPRequest *request in [_queue operations]) {
        NSDictionary *dict = request.userInfo;
        HttpQueueNode *node = [dict objectForKey:@"nodeInfo"];
        if ([url isEqualToString:node.url]) {
            [request clearDelegatesAndCancel];
            NSLog(@"_queue %@",[_queue operations]);
            
            for (HttpQueueNode *httpNode in _nodes) {
                if (httpNode.url == url) {
                    httpNode.state = HTTP_DOWNLOAD_SUSPEND;
                    [_nodes removeObject:httpNode];
                    break;
                }
            }
        }
    }
}

//获取对应文件的地址
+(NSString *)filePathWithMd5Key:(NSString *)md5Key
{
    NSString *filepath=[MHTool getCacheFilePath:[MHTool stringToMD5Value:md5Key]];
    return filepath;
}

#pragma mark 服务器回调
//call this method when request finished
- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
    NSDictionary *dict = request.userInfo;
    HttpQueueNode *node = [dict objectForKey:@"nodeInfo"];
    node.state = HTTP_IDLE;
	NSString *responseString = [request responseString];
    NSString *buf=[MHTool decodeDES:responseString];
    node.buf=buf;
    if (_delegate && [_delegate respondsToSelector:@selector(downloadDone:)]) {
        [_delegate performSelector:@selector(downloadDone:) withObject:node];
    }
    
    for (HttpQueueNode *httpNode in _nodes) {
        if (httpNode == node) {
            [_nodes removeObject:httpNode];
            break;
        }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSDictionary *dict = request.userInfo;
    HttpQueueNode *node = [dict objectForKey:@"nodeInfo"];
    node.state = HTTP_IDLE;
    if (_delegate && [_delegate respondsToSelector:@selector(downloadError:)]) {
        [_delegate performSelector:@selector(downloadError:) withObject:node];
    }
    NSLog(@"requestFailed:%@",request.error);
    
    for (HttpQueueNode *httpNode in _nodes) {
        if (httpNode == node) {
            [_nodes removeObject:httpNode];
            break;
        }
    }
    
}

// Called when the request receives some data - bytes is the length of that data
- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes{
    NSDictionary *dict = request.userInfo;
    HttpQueueNode *node = [dict objectForKey:@"nodeInfo"];
    
    node.size+=bytes;
    if (_delegate && [_delegate respondsToSelector:@selector(downloading:)]) {
        [_delegate performSelector:@selector(downloading:) withObject:node];
    }
    //    NSLog(@"didReceiveBytes:bytes:%lld",bytes);
    
    
}

// Called when a request needs to change the length of the content to download
- (void)request:(ASIHTTPRequest *)request incrementDownloadSizeBy:(long long)newLength{
    NSDictionary *dict = request.userInfo;
    HttpQueueNode *node = [dict objectForKey:@"nodeInfo"];
    
    node.totalSize=newLength;
    NSLog(@"incrementDownloadSizeBy:newLength:%lld",newLength);
}

@end
