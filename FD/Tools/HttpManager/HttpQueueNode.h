//
//  HttpQueueNode.h
//  vanVideo
//
//  Created by leo xu on 13-6-30.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _HttpNodeState
{
    HTTP_IDLE,
    HTTP_DOWNLOADING,
    HTTP_DOWNLOAD_SUSPEND,
}HttpNodeState;


@interface HttpQueueNode : NSObject
//http下载的bookNode   
@property (strong, nonatomic) id                       infoNode;
//收到的数据
@property (strong, nonatomic) NSMutableData            *data;
//收到的文本数据
@property (strong, nonatomic) NSString                 *buf;
//数据的总大小
@property (assign, nonatomic) long long                totalSize;
//数据已经下载的大小
@property (assign, nonatomic) long long                size;
//数据状态
@property (assign, nonatomic) HttpNodeState            state;
//url
@property (strong, nonatomic) NSString                 *url;
@end
