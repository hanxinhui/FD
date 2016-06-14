//
//  SkuNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SkuNode : NSObject


@property (nonatomic, strong) NSString *attr;      // 
@property (nonatomic, strong) NSString *gid;      //
@property (nonatomic, strong) NSString *sid;      //
@property (nonatomic, strong) NSString *market_price;      //
@property (nonatomic, strong) NSString *price;      //
@property (nonatomic, strong) NSString *stock;      //



-(id)initWithDict:(NSDictionary *)dict;

@end
