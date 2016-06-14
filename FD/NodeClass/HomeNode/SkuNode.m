//
//  SkuNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SkuNode.h"
#import "NSObject+Parser.h"


@implementation SkuNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.attr = [self stringFromDict:dict forKey:@"attr"];
        self.gid = [self stringFromDict:dict forKey:@"gid"];
        self.sid = [self stringFromDict:dict forKey:@"id"];
        self.market_price = [self stringFromDict:dict forKey:@"market_price"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.stock = [self stringFromDict:dict forKey:@"stock"];

    }
    return self;
}
@end
