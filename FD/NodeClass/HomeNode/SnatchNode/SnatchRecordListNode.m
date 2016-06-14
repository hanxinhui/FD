//
//  SnatchRecordListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SnatchRecordListNode.h"
#import "NSObject+Parser.h"


@implementation SnatchRecordListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {

        self.code = [self stringFromDict:dict forKey:@"code"];
        self.codes_list = [self stringFromDict:dict forKey:@"codes_list"];
        self.count = [self stringFromDict:dict forKey:@"count"];
        self.create_time = [self stringFromDict:dict forKey:@"create_time"];
        self.deadline = [self stringFromDict:dict forKey:@"deadline"];
        self.gid = [self stringFromDict:dict forKey:@"gid"];
        self.wid = [self stringFromDict:dict forKey:@"id"];
        self.kind = [self stringFromDict:dict forKey:@"kind"];
        self.lottery = [self stringFromDict:dict forKey:@"lottery"];
        self.lottery_expect = [self stringFromDict:dict forKey:@"lottery_expect"];
        self.luck_code = [self stringFromDict:dict forKey:@"luck_code"];
        self.luck_time = [self stringFromDict:dict forKey:@"luck_time"];
        self.nickname = [self stringFromDict:dict forKey:@"nickname"];
        self.old_price = [self stringFromDict:dict forKey:@"old_price"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.progress = [self stringFromDict:dict forKey:@"progress"];
        self.ready_time = [self stringFromDict:dict forKey:@"ready_time"];
        self.Cname = [self stringFromDict:dict forKey:@"name"];
        self.remark = [self stringFromDict:dict forKey:@"remark"];
        self.start = [self stringFromDict:dict forKey:@"start"];
        self.status = [[self stringFromDict:dict forKey:@"status"] integerValue];
        self.step = [self stringFromDict:dict forKey:@"step"];
        self.sub_title = [self stringFromDict:dict forKey:@"sub_title"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.title = [self stringFromDict:dict forKey:@"title"];
        self.type = [self stringFromDict:dict forKey:@"type"];
        self.update_time = [self stringFromDict:dict forKey:@"update_time"];
        self.wincount = [self stringFromDict:dict forKey:@"wincount"];
     
    }
    return self;
}
@end
