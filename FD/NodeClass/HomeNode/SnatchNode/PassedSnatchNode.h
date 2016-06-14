//
//  PassedSnatchNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 往期揭晓
#import <Foundation/Foundation.h>


@interface PassedSnatchNode : NSObject


@property (nonatomic, strong) NSString *Pid;      //id
@property (nonatomic, strong) NSString *code;      //期数
@property (nonatomic, strong) NSString *luck_time;      //揭晓时间
@property (nonatomic, strong) NSString *avatar;      //获奖者头像
@property (nonatomic, strong) NSString *nickname;      //获奖者姓名
@property (nonatomic, strong) NSString *uid;      //获奖者ID
@property (nonatomic, strong) NSString *luck_code;      //获奖号码
@property (nonatomic, strong) NSString *winnerCount;      //参与次数


-(id)initWithDict:(NSDictionary *)dict;

@end
