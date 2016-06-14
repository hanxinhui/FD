//
//  WinningRecordNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 中奖记录
#import <Foundation/Foundation.h>


@interface WinningRecordNode : NSObject


@property (nonatomic, strong) NSString *address;      //
@property (nonatomic, strong) NSString *avatar;      //
@property (nonatomic, strong) NSString *code;      //
@property (nonatomic, strong) NSString *count;      //
@property (nonatomic, strong) NSString *express_status;      // 1已发货     2 已签收
@property (nonatomic, strong) NSString *wid;      //
@property (nonatomic, strong) NSString *kind;      //
@property (nonatomic, strong) NSString *luck_code;      //
@property (nonatomic, strong) NSString *luck_time;      //
@property (nonatomic, strong) NSString *mobile;      //
@property (nonatomic, strong) NSString *price;      //
@property (nonatomic, strong) NSString *nickname;      //
@property (nonatomic, assign) NSInteger  status;      //状态-1 已过期 0待填写地址 1等待商品派发 2已发货 3 已签收
@property (nonatomic, strong) NSString *thumb;      //
@property (nonatomic, strong) NSString *title;      //


-(id)initWithDict:(NSDictionary *)dict;

@end
