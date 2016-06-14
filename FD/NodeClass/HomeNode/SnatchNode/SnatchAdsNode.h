//
//  CateNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 抽疯顶部广告
#import <Foundation/Foundation.h>


@interface SnatchAdsNode : NSObject


@property (nonatomic, strong) NSString *Aid;      //id
@property (nonatomic, strong) NSString *insert_time;      //
@property (nonatomic, strong) NSString *link;      //
@property (nonatomic, strong) NSString *name;      //
@property (nonatomic, strong) NSString *pos_id;      //
@property (nonatomic, strong) NSString *src;      //
@property (nonatomic, strong) NSString *status;      //
@property (nonatomic, strong) NSString *target;      //
@property (nonatomic, strong) NSString *update_time;      //


-(id)initWithDict:(NSDictionary *)dict;

@end
