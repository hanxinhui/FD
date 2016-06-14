//
//  MyTaskAnyCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTaskAnyCellNode.h"

@interface MyTaskAnyCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *priceLab;//价格
@property (nonatomic, strong) UILabel       *pricesLab;//价格

@property (nonatomic, strong) UILabel       *marginLab;//保证金
@property (nonatomic, strong) UILabel       *cycleLab;//周期

@property (nonatomic, strong) MyTaskAnyCellNode      *node;// 数据

@end


