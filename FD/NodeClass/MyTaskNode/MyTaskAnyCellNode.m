//
//  MyTaskAnyCellNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyTaskAnyCellNode.h"
#import "NSObject+Parser.h"


@implementation MyTaskAnyCellNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Mid = [self stringFromDict:dict forKey:@"id"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.profit = [self stringFromDict:dict forKey:@"profit"];
        self.bond = [self stringFromDict:dict forKey:@"bond"];
        self.surplus = [self stringFromDict:dict forKey:@"surplus"];
        self.cycle = [self stringFromDict:dict forKey:@"cycle"];
        self.Mmid = [self stringFromDict:dict forKey:@"mid"];
        self.mission_status = [self stringFromDict:dict forKey:@"mission_status"];
        self.mission_time = [self stringFromDict:dict forKey:@"mission_time"];
        self.timeT = [self stringFromDict:dict forKey:@"time"];
     
    }
    return self;
}
@end
