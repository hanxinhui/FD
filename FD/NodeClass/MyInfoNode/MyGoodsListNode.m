//
//  MyGoodsListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyGoodsListNode.h"
#import "NSObject+Parser.h"


@implementation MyGoodsListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Gid = [self stringFromDict:dict forKey:@"id"];
        self.comment = [self stringFromDict:dict forKey:@"comment"];
        self.createtime = [self stringFromDict:dict forKey:@"createtime"];
        self.express_code = [self stringFromDict:dict forKey:@"express_code"];
        self.express_type = [self stringFromDict:dict forKey:@"express_type"];
        self.Ggid = [self stringFromDict:dict forKey:@"Ggid"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.signtime = [self stringFromDict:dict forKey:@"signtime"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        self.status_msg = [self stringFromDict:dict forKey:@"status_msg"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.name = [self stringFromDict:dict forKey:@"name"];
     
    }
    return self;
}
@end
