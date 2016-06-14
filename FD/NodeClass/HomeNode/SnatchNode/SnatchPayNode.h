//
//  SnatchPayNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//
// 支付结果
#import <Foundation/Foundation.h>


@interface SnatchPayNode : NSObject


@property (nonatomic, strong) NSString *Pid;      //id
@property (nonatomic, strong) NSString *title;      //
@property (nonatomic, strong) NSString *count;      //
@property (nonatomic, strong) NSString *datacode;      //
@property (nonatomic, strong) NSString *wincode;      //

-(id)initWithDict:(NSDictionary *)dict;

@end
