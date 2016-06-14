//
//  BuylistNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "BuylistNode.h"
#import "NSObject+Parser.h"


@implementation BuylistNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Bid = [self stringFromDict:dict forKey:@"id"];
        self.attention_id = [self stringFromDict:dict forKey:@"attention_id"];
        self.Bfine = [self stringFromDict:dict forKey:@"fine"];
        self.Bicon = [self stringFromDict:dict forKey:@"thumb"];
        self.Btitle = [self stringFromDict:dict forKey:@"name"];
        self.Bstitle = [self stringFromDict:dict forKey:@"sub_name"];
        self.Bmoney = [self stringFromDict:dict forKey:@"bond"];
        self.Bmargin = [self stringFromDict:dict forKey:@"profit"];
        self.Bcycle = [self stringFromDict:dict forKey:@"cycle"];
     
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@",self.Mylab];
}
@end
