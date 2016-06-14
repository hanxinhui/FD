//
//  HobbiesNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "HobbiesNode.h"
#import "NSObject+Parser.h"
#import "HobbiesChildNode.h"


@implementation HobbiesNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Hid = [self stringFromDict:dict forKey:@"id"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.pid = [self stringFromDict:dict forKey:@"pid"];
        self.sort = [self stringFromDict:dict forKey:@"sort"];
        self.status = [self stringFromDict:dict forKey:@"status"];
     
        NSMutableArray *chArr = [NSMutableArray array];
        NSArray *child = [dict objectForKey:@"child"];
        if ([child isKindOfClass:[NSArray class]]) {
            for (NSDictionary *childDict in child) {
                HobbiesChildNode *cnode = [[HobbiesChildNode alloc] initWithDict:childDict];
                [chArr addObject:cnode];
            }
        }
        
        self.childArr = chArr;
        
    }
    return self;
}
@end
