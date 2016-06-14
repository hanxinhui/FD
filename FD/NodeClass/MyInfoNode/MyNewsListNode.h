//
//  BuylistNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyNewsListNode : NSObject


@property (nonatomic, strong) NSString *Nid;      //id
@property (nonatomic, strong) NSString *Ntitle;      //标题
@property (nonatomic, strong) NSString *Ncontent;      //正文
@property (nonatomic, strong) NSString *Nuname;      //消息人
@property (nonatomic, strong) NSString *Ntime;      //时间
@property (nonatomic, strong) NSString *to_uid;      //时间

-(id)initWithDict:(NSDictionary *)dict;

@end
