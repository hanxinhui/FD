//
//  MyModelSwitchNode.m
//  JSNews
//
//  Created by Leo xu on 14-10-16.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import "MyModelSwitchNode.h"
#import "NSObject+Parser.h"

@implementation MyModelSwitchNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.mid = [self stringFromDict:dict forKey:@"id"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.mark = [self stringFromDict:dict forKey:@"flag"];
        self.flag = [self stringFromDict:dict forKey:@"flag"];
        
        NSArray *arr = [dict objectForKey:@"child"];
        if ([arr isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArr = [NSMutableArray array];
            for (NSDictionary *cDict in arr) {
                MyModelNode *model = [[MyModelNode alloc] initWithDict:cDict];
                [tempArr addObject:model];
            }
            self.child = tempArr;
        }
    }
    return self;
}
@end
