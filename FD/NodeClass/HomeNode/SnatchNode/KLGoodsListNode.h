//
//  KLGoodsListNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KLGoodsListNode : NSObject


@property (nonatomic, strong) NSString *kid;      //id
@property (nonatomic, strong) NSString *thumb;      //图片
@property (nonatomic, strong) NSString *title;      //名称
@property (nonatomic, strong) NSString *price;      //价格

-(id)initWithDict:(NSDictionary *)dict;

@end
