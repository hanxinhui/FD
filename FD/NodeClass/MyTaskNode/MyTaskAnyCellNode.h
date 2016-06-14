//
//  MyTaskAnyCellNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyTaskAnyCellNode : NSObject


@property (nonatomic, strong) NSString *Mid;      //id
@property (nonatomic, strong) NSString *Mmid;      //mid
@property (nonatomic, strong) NSString *bond;      //保证金
@property (nonatomic, strong) NSString *cycle;      //周期
@property (nonatomic, strong) NSString *thumb;      //图片
@property (nonatomic, strong) NSString *mission_status;      // 状态
@property (nonatomic, strong) NSString *mission_time;      //
@property (nonatomic, strong) NSString *name;      //标题
@property (nonatomic, strong) NSString *profit;      //奖励
@property (nonatomic, strong) NSString *surplus;      //剩余
@property (nonatomic, strong) NSString *timeT;      //剩余

-(id)initWithDict:(NSDictionary *)dict;

@end
