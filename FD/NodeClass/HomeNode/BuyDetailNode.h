//
//  BuyDetailNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BuyDetailNode : NSObject


@property (nonatomic, strong) NSString *ad_owner;      //
@property (nonatomic, strong) NSString *attention_count;
@property (nonatomic, strong) NSString *bond;      //押金
@property (nonatomic, strong) NSString *channel;      //
@property (nonatomic, strong) NSString *cid;      //
@property (nonatomic, strong) NSString *content;      //
@property (nonatomic, strong) NSString *cycle;      //
@property (nonatomic, strong) NSString *del;      //
@property (nonatomic, strong) NSString *end_time;      //
@property (nonatomic, strong) NSString *fine;      //
@property (nonatomic, strong) NSString *gid;      //
@property (nonatomic, strong) NSString *insert_time;      //
@property (nonatomic, strong) NSString *is_recommend;      //
@property (nonatomic, strong) NSString *join_count;      //
@property (nonatomic, strong) NSString *like_count;      //
@property (nonatomic, strong) NSString *mid;      //
@property (nonatomic, strong) NSString *mstatus;      //
@property (nonatomic, strong) NSString *name;      //
@property (nonatomic, strong) NSString *sub_name;      //
@property (nonatomic, strong) NSString *profit;      //
@property (nonatomic, strong) NSString *province;      //
@property (nonatomic, strong) NSString *repeat_count;      //


@property (nonatomic, strong) NSString *src;      //
@property (nonatomic, strong) NSString *start_time;      //
@property (nonatomic, strong) NSString *status;      //
@property (nonatomic, strong) NSString *surplus;      //
@property (nonatomic, strong) NSString *thumb;      //
@property (nonatomic, strong) NSString *time;      //
@property (nonatomic, strong) NSString *update_time;      //
@property (nonatomic, strong) NSString *valid;      //

@property (nonatomic, strong) NSString *mission_status;      //判断任务是否可做
@property (nonatomic, strong) NSString *attention;      //收藏
-(id)initWithDict:(NSDictionary *)dict;

@end
