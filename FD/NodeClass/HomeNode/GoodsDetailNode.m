//
//  GoodsDetailNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "GoodsDetailNode.h"
#import "NSObject+Parser.h"
#import "SkuNode.h"


@implementation GoodsDetailNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Gid = [self stringFromDict:dict forKey:@"id"];
        self.b_c = [self stringFromDict:dict forKey:@"b_c"];
        self.content = [self stringFromDict:dict forKey:@"content"];
        self.desc = [self stringFromDict:dict forKey:@"desc"];
        self.end_time = [self stringFromDict:dict forKey:@"end_time"];
        self.insert_time = [self stringFromDict:dict forKey:@"insert_time"];
        self.is_recommend = [self stringFromDict:dict forKey:@"is_recommend"];
        self.join_count = [self stringFromDict:dict forKey:@"join_count"];
        self.like_count = [self stringFromDict:dict forKey:@"like_count"];
        self.name = [self stringFromDict:dict forKey:@"name"];
        self.price = [self stringFromDict:dict forKey:@"price"];
        self.scid = [self stringFromDict:dict forKey:@"scid"];
        self.seo_description = [self stringFromDict:dict forKey:@"seo_description"];
        self.seo_keywords = [self stringFromDict:dict forKey:@"seo_keywords"];
        self.seo_title = [self stringFromDict:dict forKey:@"seo_title"];
        
//        self.sku = [self stringFromDict:dict forKey:@"sku"];
        //类型 列表
        NSMutableArray *skuArrs = [NSMutableArray array];
        NSArray *skuArr = [dict objectForKey:@"sku"];
        if ([skuArr isKindOfClass:[NSArray class]]) {
            for (NSDictionary *proDict in skuArr) {
                SkuNode *node = [[SkuNode alloc] initWithDict:proDict];
                [skuArrs addObject:node];
            }
        }
        
        self.sku = skuArrs;
        
        
        self.start_time = [self stringFromDict:dict forKey:@"start_time"];
        self.status = [self stringFromDict:dict forKey:@"status"];
        self.stock = [self stringFromDict:dict forKey:@"stock"];
        self.thumb = [self stringFromDict:dict forKey:@"thumb"];
        self.view_count = [self stringFromDict:dict forKey:@"view_count"];
        self.attention = [self stringFromDict:dict forKey:@"attention"];
        self.is_virtual = [self stringFromDict:dict forKey:@"is_virtual"];
 
     
    }
    return self;
}
@end
