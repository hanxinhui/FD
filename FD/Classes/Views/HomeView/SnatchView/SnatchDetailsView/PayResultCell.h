//
//  PayResultCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 支付结果列表

#import <UIKit/UIKit.h>
#import "SnatchPayNode.h"
#import "MMLabel.h"

@interface PayResultCell : UITableViewCell

@property (nonatomic, strong) UIImageView       *bgImgView;//背景图
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong)MMLabel       *peoLab;//人次
@property (nonatomic, strong) UILabel       *dateLab;//商品期号
@property (nonatomic, strong) UILabel       *numLab;//夺宝号码

@property (nonatomic, strong) SnatchPayNode      *snode;// 数据

@end


