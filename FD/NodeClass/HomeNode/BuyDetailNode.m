//
//  BuyDetailNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "BuyDetailNode.h"
#import "NSObject+Parser.h"


@implementation BuyDetailNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.ad_owner = [self stringFromDict:dict forKey:@"ad_owner"];
        self.attention_count = [self stringFromDict:dict forKey:@"attention_count"];
        self.bond = [self stringFromDict:dict forKey:@"bond"];
        self.channel = [self stringFromDict:dict forKey:@"channel"];
        self.cid = [self stringFromDict:dict forKey:@"cid"];
        self.content = [self stringFromDict:dict forKey:@"content"];
        self.cycle = [self stringFromDict:dict forKey:@"cycle"];
        self.del = [self stringFromDict:dict forKey:@"del"];
        self.end_time = [self stringFromDict:dict forKey:@"end_time"];
        self.fine = [self stringFromDict:dict forKey:@"fine"];
        self.gid = [self stringFromDict:dict forKey:@"id"];
        self.insert_time = [self stringFromDict:dict forKey:@"insert_time"];
        self.is_recommend = [self stringFromDict:dict forKey:@"is_recommend"];
        self.join_count = [self stringFromDict:dict forKey:@"join_count"];
        self.like_count = [self stringFromDict:dict forKey:@"like_count"];
        self.mid = [self stringFromDict:dict forKey:@"mid"];
        self.mstatus = [self stringFromDict:dict forKey:@"mstatus"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.sub_name = [self stringFromDict:dict forKey:@"sub_name"];
        self.profit = [self stringFromDict:dict forKey:@"profit"];
        self.province = [self stringFromDict:dict forKey:@"province"];
        self.repeat_count = [self stringFromDict:dict forKey:@"repeat_count"];
        self.src = [self stringFromDict:dict forKey:@"src"];
        self.start_time = [self stringFromDict:dict forKey:@"start_time"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        self.surplus = [self stringFromDict:dict forKey:@"surplus"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.time = [self stringFromDict:dict forKey:@"time"];
        self.update_time = [self stringFromDict:dict forKey:@"update_time"];
        self.valid = [self stringFromDict:dict forKey:@"valid"];
        self.mission_status = [self stringFromDict:dict forKey:@"mission_status"];
        self.attention = [self stringFromDict:dict forKey:@"attention"];
     
    }
    return self;
}
@end
