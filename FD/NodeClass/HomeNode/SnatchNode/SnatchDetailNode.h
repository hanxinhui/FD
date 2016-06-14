//
//  SnatchDetailNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SnatchDetailNode : NSObject


@property (nonatomic, strong) NSString *Sid;      //
@property (nonatomic, strong) NSString *step;      //可选倍数
@property (nonatomic, strong) NSString *start;      //起始数量
@property (nonatomic, strong) NSString *price;      //总价
@property (nonatomic, strong) NSString *progress;      //进度
@property (nonatomic, assign) NSInteger less;      //剩余

-(id)initWithDict:(NSDictionary *)dict;

@end
