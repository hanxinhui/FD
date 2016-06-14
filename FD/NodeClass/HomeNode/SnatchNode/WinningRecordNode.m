//
//  WinningRecordNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WinningRecordNode.h"
#import "NSObject+Parser.h"


@implementation WinningRecordNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {

        self.address = [self stringFromDict:dict forKey:@"address"];
        self.avatar = [self stringFromDict:dict forKey:@"avatar"];
        self.code = [self stringFromDict:dict forKey:@"code"];
        self.count = [self stringFromDict:dict forKey:@"count"];
        self.express_status = [self stringFromDict:dict forKey:@"express_status"];
        self.wid = [self stringFromDict:dict forKey:@"id"];
        self.kind = [self stringFromDict:dict forKey:@"kind"];
        self.luck_code = [self stringFromDict:dict forKey:@"luck_code"];
        self.luck_time = [self stringFromDict:dict forKey:@"luck_time"];
        self.nickname = [self stringFromDict:dict forKey:@"nickname"];
        self.mobile = [self stringFromDict:dict forKey:@"mobile"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.status = [[self stringFromDict:dict forKey:@"status"] integerValue];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.title = [self stringFromDict:dict forKey:@"title"];
       
    }
    return self;
}
@end
