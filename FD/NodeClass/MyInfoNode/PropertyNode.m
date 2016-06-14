//
//  HomeNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "PropertyNode.h"
#import "NSObject+Parser.h"
#import "PropertyListNode.h"

@implementation PropertyNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
    
        self.pname = [self stringFromDict:dict forKey:@"name"];
        self.pin = [self stringFromDict:dict forKey:@"in"];
        self.pout = [self stringFromDict:dict forKey:@"out"];
        
        //类型 列表
        NSMutableArray *typeArrs = [NSMutableArray array];
        NSArray *typeArr = [dict objectForKey:@"list"];
        if ([typeArr isKindOfClass:[NSArray class]]) {
            for (NSDictionary *proDict in typeArr) {
                PropertyListNode *node = [[PropertyListNode alloc] initWithDict:proDict];
                [typeArrs addObject:node];
            }
        }
        
        self.prolist = typeArrs;
        
        
    }
    return self;
}

@end
