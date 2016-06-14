//
//  AddressNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "AddressNode.h"
#import "NSObject+Parser.h"

@implementation AddressNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.AID = [self stringFromDict:dict forKey:@"id"];
        self.consignee = [self stringFromDict:dict forKey:@"consignee"];
        self.mobile = [self stringFromDict:dict forKey:@"mobile"];
        self.province = [self stringFromDict:dict forKey:@"province"];
        self.city = [self stringFromDict:dict forKey:@"city"];
        self.area = [self stringFromDict:dict forKey:@"area"];
        self.addr = [self stringFromDict:dict forKey:@"addr"];

        self.def = [self stringFromDict:dict forKey:@"def"];
        
        self.region = [self stringFromDict:dict forKey:@"region"];
        
        
        
    }
    return self;
}
@end
