//
//  MyBagDetailListNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyBagDetailListNode : NSObject


@property (nonatomic, strong) NSString *Cid;      //id
@property (nonatomic, strong) NSString *avatar;      //头像
@property (nonatomic, strong) NSString *code;      //抢宝号码
@property (nonatomic, strong) NSString *mobile;      //手机号
@property (nonatomic, strong) NSString *nickname;      // 
@property (nonatomic, strong) NSString *time;      //进度
@property (nonatomic, strong) NSString *count;      //次数

@property (nonatomic, assign) NSInteger status;      //0 未中  1 中奖


-(id)initWithDict:(NSDictionary *)dict;

@end
