//
//  ShowMeNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ShowMeNode.h"
#import "NSObject+Parser.h"


@implementation ShowMeNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.avatar = [self stringFromDict:dict forKey:@"avatar"];
        self.code = [self stringFromDict:dict forKey:@"code"];
        self.content = [self stringFromDict:dict forKey:@"content"];
        self.nickname = [self stringFromDict:dict forKey:@"nickname"];
        if ([self.nickname isEqualToString:@""] || self.nickname.length == 0  || self.nickname == nil) {
            self.nickname = [self stringFromDict:dict forKey:@"mobile"];
        }
        self.src = [self stringFromDict:dict forKey:@"src"];
        self.subject = [self stringFromDict:dict forKey:@"subject"];
        self.time = [self stringFromDict:dict forKey:@"time"];
        self.title = [self stringFromDict:dict forKey:@"title"];
     
    }
    return self;
}
@end
