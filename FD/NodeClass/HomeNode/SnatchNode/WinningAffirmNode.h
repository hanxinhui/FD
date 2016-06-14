//
//  WinningAffirmNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 确认奖品数据
#import <Foundation/Foundation.h>


@interface WinningAffirmNode : NSObject


@property (nonatomic, strong) NSString *address;      //
@property (nonatomic, strong) NSString *address_time;      //
@property (nonatomic, strong) NSString *city;      //
@property (nonatomic, strong) NSString *code;      //
@property (nonatomic, strong) NSString *code2;      //
@property (nonatomic, strong) NSString *consignee;      //
@property (nonatomic, strong) NSString *count;      //
@property (nonatomic, strong) NSString *express_code;      //
@property (nonatomic, strong) NSString *express_status;      //快递状态 1已发货 2 已签收
@property (nonatomic, strong) NSString *express_time;      //
@property (nonatomic, strong) NSString *express_type;      //
@property (nonatomic, strong) NSString *finish_time;      //
@property (nonatomic, strong) NSString *gid;      //
@property (nonatomic, strong) NSString *wid;      //
@property (nonatomic, strong) NSString *wip;      //
@property (nonatomic, strong) NSString *luck_code;      //
@property (nonatomic, strong) NSString *luck_time;      //
@property (nonatomic, strong) NSString *microtime;      //
@property (nonatomic, strong) NSString *mobile;      //
@property (nonatomic, strong) NSString *price;      //
@property (nonatomic, assign) NSInteger status;      //状态-1 已过期 0待填写地址 1等待商品派发 2已发货 3 已签收
@property (nonatomic, strong) NSString *thumb;      //
@property (nonatomic, strong) NSString *time;      //
@property (nonatomic, strong) NSString *title;      //
@property (nonatomic, strong) NSString *uid;      //


-(id)initWithDict:(NSDictionary *)dict;

@end
