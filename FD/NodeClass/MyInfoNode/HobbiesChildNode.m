//
//  HobbiesChildNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "HobbiesChildNode.h"
#import "NSObject+Parser.h"


@implementation HobbiesChildNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Hid = [self stringFromDict:dict forKey:@"id"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.pid = [self stringFromDict:dict forKey:@"pid"];
        self.sort = [self stringFromDict:dict forKey:@"sort"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        self.selected = [[self stringFromDict:dict forKey:@"selected"] integerValue];
     
    }
    return self;
}
@end
