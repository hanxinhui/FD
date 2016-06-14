//
//  WinningRecordNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 夺宝记录
#import <Foundation/Foundation.h>


@interface SnatchRecordListNode : NSObject


@property (nonatomic, strong) NSString *code;      //
@property (nonatomic, strong) NSString *codes_list;      //
@property (nonatomic, strong) NSString *count;      //
@property (nonatomic, strong) NSString *create_time;      //
@property (nonatomic, strong) NSString *deadline;      //
@property (nonatomic, strong) NSString *Cname;      //
@property (nonatomic, strong) NSString *gid;      //
@property (nonatomic, strong) NSString *wid;      //
@property (nonatomic, strong) NSString *kind;      //
@property (nonatomic, strong) NSString *lottery;      //
@property (nonatomic, strong) NSString *lottery_expect;      //
@property (nonatomic, strong) NSString *luck_code;      //
@property (nonatomic, strong) NSString *luck_time;      //
@property (nonatomic, strong) NSString *nickname;      //
@property (nonatomic, strong) NSString *old_price;      //
@property (nonatomic, strong) NSString *price;      //
@property (nonatomic, strong) NSString *progress;      //
@property (nonatomic, strong) NSString *ready_time;      //
@property (nonatomic, strong) NSString *remark;      //
@property (nonatomic, strong) NSString *start;      //
@property (nonatomic, assign) NSInteger status;      //1 人未满  2，已揭晓  3，揭晓中
@property (nonatomic, strong) NSString *step;      //
@property (nonatomic, strong) NSString *sub_title;      //
@property (nonatomic, strong) NSString *thumb;      //
@property (nonatomic, strong) NSString *title;      //
@property (nonatomic, strong) NSString *type;      //
@property (nonatomic, strong) NSString *update_time;      //
@property (nonatomic, strong) NSString *wincount;      //


-(id)initWithDict:(NSDictionary *)dict;

@end
