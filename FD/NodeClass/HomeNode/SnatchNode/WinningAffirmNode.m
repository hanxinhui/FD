//
//  WinningAffirmNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WinningAffirmNode.h"
#import "NSObject+Parser.h"


@implementation WinningAffirmNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.address = [self stringFromDict:dict forKey:@"address"];
        
        self.address_time = [self stringFromDict:dict forKey:@"address_time"];
        self.city = [self stringFromDict:dict forKey:@"city"];
        self.code = [self stringFromDict:dict forKey:@"code"];
        self.code2 = [self stringFromDict:dict forKey:@"code2"];
        self.consignee = [self stringFromDict:dict forKey:@"consignee"];
        self.count = [self stringFromDict:dict forKey:@"count"];
        self.express_code = [self stringFromDict:dict forKey:@"express_code"];
        self.express_status = [self stringFromDict:dict forKey:@"express_status"];
        self.express_time = [self stringFromDict:dict forKey:@"express_time"];
        self.express_type = [self stringFromDict:dict forKey:@"express_type"];
        self.finish_time = [self stringFromDict:dict forKey:@"finish_time"];
        self.gid = [self stringFromDict:dict forKey:@"gid"];
        self.wid = [self stringFromDict:dict forKey:@"id"];
        self.wip = [self stringFromDict:dict forKey:@"ip"];
        self.luck_code = [self stringFromDict:dict forKey:@"luck_code"];
        self.luck_time = [self stringFromDict:dict forKey:@"luck_time"];
        self.microtime = [self stringFromDict:dict forKey:@"microtime"];
        self.mobile = [self stringFromDict:dict forKey:@"mobile"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.status = [[self stringFromDict:dict forKey:@"status"] integerValue];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.time = [self stringFromDict:dict forKey:@"time"];
        self.title = [self stringFromDict:dict forKey:@"title"];
    }
    return self;
}
@end
