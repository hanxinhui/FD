//
//  PassedSnatchNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "PassedSnatchNode.h"
#import "NSObject+Parser.h"


@implementation PassedSnatchNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Pid = [self stringFromDict:dict forKey:@"id"];
        self.code = [self stringFromDict:dict forKey:@"code"];
        self.luck_time = [self stringFromDict:dict forKey:@"luck_time"];
        self.avatar = [self stringFromDict:dict forKey:@"avatar"];
        self.nickname = [self stringFromDict:dict forKey:@"nickname"];
        if (self.nickname == nil || self.nickname.length == 0 || [self.nickname isEqualToString:@""]) {
            self.nickname = [self stringFromDict:dict forKey:@"mobile"];
  
        }
        self.luck_code = [self stringFromDict:dict forKey:@"luck_code"];
        self.uid = [self stringFromDict:dict forKey:@"uid"];
        self.winnerCount = [self stringFromDict:dict forKey:@"winnerCount"];

     
    }
    return self;
}
@end
