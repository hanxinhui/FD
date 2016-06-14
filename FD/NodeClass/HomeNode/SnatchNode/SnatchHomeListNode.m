//
//  CateNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SnatchHomeListNode.h"
#import "NSObject+Parser.h"


@implementation SnatchHomeListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Hid = [self stringFromDict:dict forKey:@"id"];
        self.code = [self stringFromDict:dict forKey:@"code"];
        self.codes_list = [self stringFromDict:dict forKey:@"codes_list"];
        self.create_time = [self stringFromDict:dict forKey:@"create_time"];
        self.deadline = [self stringFromDict:dict forKey:@"deadline"];
        self.gid = [self stringFromDict:dict forKey:@"gid"];
        self.luck_code = [self stringFromDict:dict forKey:@"luck_code"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.progress = [self stringFromDict:dict forKey:@"progress"];
        self.start = [self stringFromDict:dict forKey:@"start"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        self.step = [self stringFromDict:dict forKey:@"step"];
        self.sub_title = [self stringFromDict:dict forKey:@"sub_title"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.title = [self stringFromDict:dict forKey:@"title"];
        self.update_time = [self stringFromDict:dict forKey:@"update_time"];
        
    }
    return self;
}
@end
