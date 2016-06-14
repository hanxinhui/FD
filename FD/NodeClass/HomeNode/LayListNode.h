//
//  BuylistNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LayListNode : NSObject


@property (nonatomic, strong) NSString *Bid;      //id
@property (nonatomic, strong) NSString *Bicon;      //图片
@property (nonatomic, strong) NSString *Btitle;      //标题
@property (nonatomic, strong) NSString *bond;      //保证金
@property (nonatomic, strong) NSString *sub_title;      //
@property (nonatomic, strong) NSString *stop_time;      //报名截止时间
@property (nonatomic, strong) NSString *start_time;      //开始 时间
@property (nonatomic, strong) NSString *draw_time;      //开奖时间

-(id)initWithDict:(NSDictionary *)dict;

@end
