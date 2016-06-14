//
//  GoodsDetailNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GoodsDetailNode : NSObject

//@property (nonatomic, strong) NSMutableArray  *booklist;           //年级 数组列表

@property (nonatomic, strong) NSString *Gid;      //
@property (nonatomic, strong) NSString *b_c;
@property (nonatomic, strong) NSString *content;      //
@property (nonatomic, strong) NSString *desc;      //
@property (nonatomic, strong) NSString *end_time;      //
@property (nonatomic, strong) NSString *cid;      //
@property (nonatomic, strong) NSString *insert_time;      //
@property (nonatomic, strong) NSString *is_recommend;      //
@property (nonatomic, strong) NSString *join_count;      //
@property (nonatomic, strong) NSString *like_count;      //
@property (nonatomic, strong) NSString *name;      //
@property (nonatomic, strong) NSString *price;      //
@property (nonatomic, strong) NSString *scid;      //
@property (nonatomic, strong) NSString *seo_description;      //
@property (nonatomic, strong) NSString *seo_keywords;      //
@property (nonatomic, strong) NSString *seo_title;      //
@property (nonatomic, strong) NSMutableArray  *sku;      //
@property (nonatomic, strong) NSString *start_time;      //
@property (nonatomic, strong) NSString *status;      //
@property (nonatomic, strong) NSString *stock;      //
@property (nonatomic, strong) NSString *thumb;      //
@property (nonatomic, strong) NSString *view_count;      //
@property (nonatomic, strong) NSString *attention;      //
@property (nonatomic, strong) NSString *is_virtual;      //是否实物  0是实物  1 话费  2 Q币

-(id)initWithDict:(NSDictionary *)dict;

@end
