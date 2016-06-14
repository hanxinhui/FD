//
//  OpenAdNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "OpenAdNode.h"
#import "NSObject+Parser.h"


@implementation OpenAdNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Aid = [self stringFromDict:dict forKey:@"id"];
        self.insert_time = [self stringFromDict:dict forKey:@"insert_time"];
        self.link = [self stringFromDict:dict forKey:@"link"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.pos_id = [self stringFromDict:dict forKey:@"pos_id"];
        self.src = [self stringFromDict:dict forKey:@"src"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        self.target = [self stringFromDict:dict forKey:@"target"];
        self.time = [self stringFromDict:dict forKey:@"time"];
        self.update_time = [self stringFromDict:dict forKey:@"update_time"];
    }
    return self;
}
@end
