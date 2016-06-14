//
//  MyBankListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyBankListNode.h"
#import "NSObject+Parser.h"


@implementation MyBankListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Bid = [self stringFromDict:dict forKey:@"id"];
        self.bank = [self stringFromDict:dict forKey:@"bank"];
        self.bankcode = [self stringFromDict:dict forKey:@"bankcode"];
        self.cardno = [self stringFromDict:dict forKey:@"cardno"];
        self.cardtype = [self stringFromDict:dict forKey:@"cardtype"];
        self.city = [self stringFromDict:dict forKey:@"city"];
        self.icon = [self stringFromDict:dict forKey:@"icon"];
        self.insert_time = [self stringFromDict:dict forKey:@"insert_time"];
        self.lastno = [self stringFromDict:dict forKey:@"lastno"];
        self.point = [self stringFromDict:dict forKey:@"point"];
        self.province = [self stringFromDict:dict forKey:@"province"];
        self.username = [self stringFromDict:dict forKey:@"username"];
        self.status = [self stringFromDict:dict forKey:@"status"];
   
        
    }
    return self;
}
@end
