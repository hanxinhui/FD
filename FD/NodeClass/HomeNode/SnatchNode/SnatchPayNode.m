//
//  SnatchPayNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SnatchPayNode.h"
#import "NSObject+Parser.h"


@implementation SnatchPayNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Pid = [self stringFromDict:dict forKey:@"id"];
        self.title = [self stringFromDict:dict forKey:@"title"];
        self.count = [self stringFromDict:dict forKey:@"count"];
        self.datacode = [self stringFromDict:dict forKey:@"code"];
        self.wincode = [self stringFromDict:dict forKey:@"deadline"];

     
    }
    return self;
}
@end
