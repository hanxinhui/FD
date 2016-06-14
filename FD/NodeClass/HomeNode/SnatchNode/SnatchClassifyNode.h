//
//  SnatchClassifyNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 分类浏览
#import <Foundation/Foundation.h>


@interface SnatchClassifyNode : NSObject


@property (nonatomic, strong) NSString *Cid;      //id
@property (nonatomic, strong) NSString *icon;      //
@property (nonatomic, strong) NSString *name;      //id
@property (nonatomic, strong) NSString *pid;      //
@property (nonatomic, strong) NSString *seo_description;      //id
@property (nonatomic, strong) NSString *seo_keywords;      //
@property (nonatomic, strong) NSString *seo_title;      //id
@property (nonatomic, strong) NSString *sort;      //
@property (nonatomic, strong) NSString *status;      //id


-(id)initWithDict:(NSDictionary *)dict;

@end
