//
//  KLGoodsListNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "KLGoodsListNode.h"
#import "NSObject+Parser.h"


@implementation KLGoodsListNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.kid = [self stringFromDict:dict forKey:@"id"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.title = [self stringFromDict:dict forKey:@"title"];
        self.price = [self stringFromDict:dict forKey:@"price"];
     
    }
    return self;
}
@end
