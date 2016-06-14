//
//  HomeNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "HomeNode.h"
#import "NSObject+Parser.h"


@implementation HomeNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Hid = [self stringFromDict:dict forKey:@"id"];
        self.Htitle = [self stringFromDict:dict forKey:@"title"];
        self.Hsub_title = [self stringFromDict:dict forKey:@"sub_title"];
        self.Hcover = [self stringFromDict:dict forKey:@"cover"];
        self.Hpath = [self stringFromDict:dict forKey:@"path"];
        self.Hdesc = [self stringFromDict:dict forKey:@"description"];
        
    }
    return self;
}
@end
