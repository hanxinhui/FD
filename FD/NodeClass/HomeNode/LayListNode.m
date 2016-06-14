//
//  BuylistNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "LayListNode.h"
#import "NSObject+Parser.h"


@implementation LayListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Bid = [self stringFromDict:dict forKey:@"id"];
        self.Bicon = [self stringFromDict:dict forKey:@"logo"];
        self.Btitle = [self stringFromDict:dict forKey:@"title"];
        self.bond = [self stringFromDict:dict forKey:@"bond"];
        self.sub_title = [self stringFromDict:dict forKey:@"sub_title"];
//        self.start_time = [self stringFromDict:dict forKey:@"start_time"];
        self.stop_time = [self stringFromDict:dict forKey:@"enroll_time"];
        self.draw_time = [self stringFromDict:dict forKey:@"draw_time"];
     
    }
    return self;
}
@end
