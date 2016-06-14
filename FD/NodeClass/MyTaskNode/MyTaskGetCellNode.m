//
//  MyTaskGetCellNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyTaskGetCellNode.h"
#import "NSObject+Parser.h"


@implementation MyTaskGetCellNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Gid = [self stringFromDict:dict forKey:@"id"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.express_status = [self stringFromDict:dict forKey:@"express_status"];
        self.express_status_msg = [self stringFromDict:dict forKey:@"express_status_msg"];
        self.express_company = [self stringFromDict:dict forKey:@"express_company"];
        self.express_code = [self stringFromDict:dict forKey:@"express_code"];
        self.bond = [self stringFromDict:dict forKey:@"bond"];
        self.surplus = [self stringFromDict:dict forKey:@"surplus"];

    }
    return self;
}
@end
