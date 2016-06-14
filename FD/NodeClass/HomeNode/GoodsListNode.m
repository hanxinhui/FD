//
//  GoodsListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "GoodsListNode.h"
#import "NSObject+Parser.h"


@implementation GoodsListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Gid = [self stringFromDict:dict forKey:@"id"];
        self.Gdesc = [self stringFromDict:dict forKey:@"desc"];
        self.Gcid = [self stringFromDict:dict forKey:@"cid"];
        self.Gname = [self stringFromDict:dict forKey:@"name"];
        self.Gprice = [self stringFromDict:dict forKey:@"price"];
        self.Gstock = [self stringFromDict:dict forKey:@"stock"];
        self.Gthumb = [self stringFromDict:dict forKey:@"thumb"];
     
    }
    return self;
}
@end
