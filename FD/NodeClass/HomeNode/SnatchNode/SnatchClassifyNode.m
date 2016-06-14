//
//  SnatchClassifyNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SnatchClassifyNode.h"
#import "NSObject+Parser.h"


@implementation SnatchClassifyNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Cid = [self stringFromDict:dict forKey:@"id"];
        self.icon = [self stringFromDict:dict forKey:@"icon"];
        self.pid = [self stringFromDict:dict forKey:@"pid"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.seo_description = [self stringFromDict:dict forKey:@"seo_description"];
        self.seo_keywords = [self stringFromDict:dict forKey:@"seo_keywords"];
        self.seo_title = [self stringFromDict:dict forKey:@"seo_title"];
        self.sort = [self stringFromDict:dict forKey:@"sort"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        
    }
    return self;
}
@end
