//
//  BuylistNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BuylistNode : NSObject


@property (nonatomic, strong) NSString *Bid;      //id
@property (nonatomic, strong) NSString *attention_id;      //attention_id
@property (nonatomic, strong) NSString *Bfine;      //fine
@property (nonatomic, strong) NSString *Bicon;      //图片
@property (nonatomic, strong) NSString *Btitle;      //标题
@property (nonatomic, strong) NSString *Bstitle;      //子标题
@property (nonatomic, strong) NSString *Bmoney;      //奖励
@property (nonatomic, strong) NSString *Bmargin;      //保证金
@property (nonatomic, strong) NSString *Bcycle;      //周期

@property (copy, nonatomic) NSString *Mylab;

-(id)initWithDict:(NSDictionary *)dict;

@end
