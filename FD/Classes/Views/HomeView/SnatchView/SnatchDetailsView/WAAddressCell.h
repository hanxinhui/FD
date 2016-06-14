//
//  GoodsListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

//中奖信息-地址信息

#import <UIKit/UIKit.h>
#import "WinningAffirmNode.h"

@interface WAAddressCell : UIView


@property (nonatomic, strong) UILabel       *nameLab;//姓名
@property (nonatomic, strong) UILabel       *phoneLab;//电话
@property (nonatomic, strong) UILabel       *addressLab;//地址

@property (nonatomic, strong) WinningAffirmNode      *node;// 数据

@end


