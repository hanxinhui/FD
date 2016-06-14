//
//  MyTaskGetCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTaskGetCellNode.h"

@interface MyTaskGetCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UIButton      *sendStateBtn;//发送状态
@property (nonatomic, strong) UILabel       *numLab;//单号

@property (nonatomic, strong) UILabel       *marginLab;//保证金
@property (nonatomic, strong) UILabel       *cycleLab;//周期

@property (nonatomic, strong) MyTaskGetCellNode      *node;// 数据

@end


