//
//  MyTaskGetCellNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyTaskGetCellNode : NSObject


@property (nonatomic, strong) NSString *Gid;      //id
@property (nonatomic, strong) NSString *thumb;      //图片
@property (nonatomic, strong) NSString *name;      //标题
@property (nonatomic, strong) NSString *express_status;      //状态 0 未发货 / 1 已发货 / 2 已签收
@property (nonatomic, strong) NSString *express_status_msg;      //状态名称
@property (nonatomic, strong) NSString *express_company;      //快递公司
@property (nonatomic, strong) NSString *express_code;   //运单号
@property (nonatomic, strong) NSString *bond;      //保证金
@property (nonatomic, strong) NSString *surplus;      //周期

-(id)initWithDict:(NSDictionary *)dict;

@end
