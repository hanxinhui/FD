//
//  WinningRecordNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WinningRecordNode.h"
#import "NSObject+Parser.h"


@implementation WinningRecordNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Cid = [self stringFromDict:dict forKey:@"id"];
        self.Cname = [self stringFromDict:dict forKey:@"name"];

     
    }
    return self;
}
@end
