//
//  MyTaskLayCellNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyTaskLayCellNode : NSObject


@property (nonatomic, strong) NSString *Bid;        //id
@property (nonatomic, strong) NSString *Bicon;      //图片
@property (nonatomic, strong) NSString *Btitle;     //标题
@property (nonatomic, strong) NSString *Bcon;       //说明
@property (nonatomic, strong) NSString *Bmargin;    //保证金
@property (nonatomic, strong) NSString *Bstate;     //开奖状态

-(id)initWithDict:(NSDictionary *)dict;

@end
