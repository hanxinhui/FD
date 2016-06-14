//
//  PropertyListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "PropertyListNode.h"
#import "NSObject+Parser.h"


@implementation PropertyListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.pid = [self stringFromDict:dict forKey:@"id"];
        self.pcode = [self stringFromDict:dict forKey:@"code"];
        self.pmoney = [self stringFromDict:dict forKey:@"money"];
        self.ptime = [self stringFromDict:dict forKey:@"insert_time"];
        self.pdesc = [self stringFromDict:dict forKey:@"remark"];
        
        
    }
    return self;
}
@end
