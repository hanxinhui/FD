//
//  ExchangeDetailNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ExchangeDetailNode.h"
#import "NSObject+Parser.h"


@implementation ExchangeDetailNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Eid = [self stringFromDict:dict forKey:@"id"];
        self.addr_id = [self stringFromDict:dict forKey:@"addr_id"];
        self.address = [self stringFromDict:dict forKey:@"address"];
        self.attr = [self stringFromDict:dict forKey:@"attr"];
        self.b_c = [self stringFromDict:dict forKey:@"b_c"];
        self.code = [self stringFromDict:dict forKey:@"code"];
        self.comment = [self stringFromDict:dict forKey:@"comment"];
        self.consignee = [self stringFromDict:dict forKey:@"consignee"];
        self.createtime = [self stringFromDict:dict forKey:@"createtime"];
        self.desc = [self stringFromDict:dict forKey:@"desc"];
        self.express_code = [self stringFromDict:dict forKey:@"express_code"];
        self.express_time = [self stringFromDict:dict forKey:@"express_time"];
        self.express_type = [self stringFromDict:dict forKey:@"express_type"];
        self.gid = [self stringFromDict:dict forKey:@"gid"];
        self.mobile = [self stringFromDict:dict forKey:@"mobile"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.signtime = [self stringFromDict:dict forKey:@"signtime"];
        self.sku = [self stringFromDict:dict forKey:@"sku"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        self.status_msg = [self stringFromDict:dict forKey:@"status_msg"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.uid = [self stringFromDict:dict forKey:@"uid"];
        self.remarks = [self stringFromDict:dict forKey:@"remarks"];

    }
    return self;
}
@end
