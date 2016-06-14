//
//  HTTPManager.h
//  cardPreferential
//
//  Created by leo xu on 13-4-11.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "HTTPKeysDefine.h"

#define DEFAULT_NUM_PAGE   @"15"

@protocol HTTPManagerDelegate <NSObject>
@optional
//TODO:请求成功
-(void)requestFinished:(NSDictionary *)resultDict;
//TODO:请求失败
-(void)requestFailed:(NSDictionary *)errorDict;
//TODO:所有请求全部完成
-(void)allRequestDone;
//TODO:进度
-(void)setProgress:(float)progress;
@end


@interface HTTPManager : NSObject <ASIProgressDelegate>
{
    //队列
    ASINetworkQueue *_httpQueue;
    ASIHTTPRequest *_httpRequest;
    ASIFormDataRequest *_httpPost;
    
    BOOL isupdate;
    

}

@property(nonatomic, assign)id <HTTPManagerDelegate> delegate;

//TODO:发送请求
//带数据格式
-(void)sendReqWithDict:(NSDictionary *)dict;
//TODO:取消请求
-(void)cancelReqWithReqCode:(HTTP_CODE)reqCode;
@end
