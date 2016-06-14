//
//  MyBagDetailListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyBagDetailListNode.h"
#import "NSObject+Parser.h"


@implementation MyBagDetailListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.avatar = [self stringFromDict:dict forKey:@"avatar"];
        self.code = [self stringFromDict:dict forKey:@"code"];
        self.count = [self stringFromDict:dict forKey:@"count"];
        self.mobile = [self stringFromDict:dict forKey:@"mobile"];
        self.nickname = [self stringFromDict:dict forKey:@"nickname"];
        if ([self.nickname isEqualToString:@""] || self.nickname.length == 0  || self.nickname == nil) {
            self.nickname = self.mobile;
        }
        NSString *timestr = [NSString stringWithFormat:@"%@:%@",[self stringFromDict:dict forKey:@"time"],[self stringFromDict:dict forKey:@"microtime"]];
        self.time = timestr;
        
        self.status = [[self stringFromDict:dict forKey:@"status"] integerValue];
        
        
    }
    return self;
}
@end
