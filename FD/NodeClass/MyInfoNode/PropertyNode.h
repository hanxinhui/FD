//
//  PropertyNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PropertyNode : NSObject

@property (nonatomic, strong) NSMutableArray  *prolist;           //资产列表
@property (nonatomic, strong) NSString        *pname;           //日期
@property (nonatomic, strong) NSString      *pin;           //进账
@property (nonatomic, strong) NSString      *pout;           //出账
@property (nonatomic, assign, getter = isOpened) BOOL opened;
-(id)initWithDict:(NSDictionary *)dict;


@end
