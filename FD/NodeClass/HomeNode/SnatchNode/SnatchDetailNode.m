//
//  SnatchDetailNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SnatchDetailNode.h"
#import "NSObject+Parser.h"


@implementation SnatchDetailNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Sid = [self stringFromDict:dict forKey:@"id"];
        self.step = [self stringFromDict:dict forKey:@"step"];
        self.start = [self stringFromDict:dict forKey:@"start"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.progress = [self stringFromDict:dict forKey:@"progress"];
        self.less = [self.price integerValue] - [self.progress integerValue];

    }
    return self;
}
@end
