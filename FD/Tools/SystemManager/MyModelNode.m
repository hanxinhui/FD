//
//  MyModelNode.m
//  JSNews
//
//  Created by Leo xu on 14-10-16.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import "MyModelNode.h"
#import "NSObject+Parser.h"

@implementation MyModelNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.mid = [self stringFromDict:dict forKey:@"id"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.mark = [self stringFromDict:dict forKey:@"mark"];
        self.flag = [self stringFromDict:dict forKey:@"flag"];
    }
    return self;
}
@end
