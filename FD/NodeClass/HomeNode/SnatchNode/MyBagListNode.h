//
//  MyBagListNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyBagListNode : NSObject


@property (nonatomic, strong) NSString *Cid;      //id
@property (nonatomic, strong) NSString *gid;      //id
@property (nonatomic, assign) NSInteger kind;      //1 福利抢宝  2 群抢宝 3 心愿单 （icon也不一样）

@property (nonatomic, strong) NSString *mobile;      //手机号
@property (nonatomic, strong) NSString *title;      //说明
@property (nonatomic, strong) NSString *nickname;      //昵称
@property (nonatomic, assign) NSInteger  status;      //1 参与中  2 已揭晓 3 等待开奖
@property (nonatomic, strong) NSString *create_time;      //时间
-(id)initWithDict:(NSDictionary *)dict;

@end
