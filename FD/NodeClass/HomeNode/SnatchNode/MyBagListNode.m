//
//  CateNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyBagListNode.h"
#import "NSObject+Parser.h"


@implementation MyBagListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Cid = [self stringFromDict:dict forKey:@"id"];
        self.gid = [self stringFromDict:dict forKey:@"gid"];
        
        self.kind = [[self stringFromDict:dict forKey:@"kind"] integerValue];
        self.mobile = [self stringFromDict:dict forKey:@"mobile"];
        self.title = [self stringFromDict:dict forKey:@"title"];
        self.nickname = [self stringFromDict:dict forKey:@"nickname"];
        if ([self.nickname isEqualToString:@""] || self.nickname.length == 0  || self.nickname == nil) {
            self.nickname = self.mobile;
        }
        self.status = [[self stringFromDict:dict forKey:@"status"] integerValue];
        self.create_time = [self stringFromDict:dict forKey:@"create_time"];

     
    }
    return self;
}
@end
