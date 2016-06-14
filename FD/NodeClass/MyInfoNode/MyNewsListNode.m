//
//  MyNewsListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyNewsListNode.h"
#import "NSObject+Parser.h"


@implementation MyNewsListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Nid = [self stringFromDict:dict forKey:@"id"];
        self.Ntitle = [self stringFromDict:dict forKey:@"title"];
        self.Ncontent = [self stringFromDict:dict forKey:@"content"];
        self.Nuname = [self stringFromDict:dict forKey:@"uname"];
        self.Ntime = [self stringFromDict:dict forKey:@"send_time"];
        self.to_uid = [self stringFromDict:dict forKey:@"to_uid"];

    }
    return self;
}
@end
