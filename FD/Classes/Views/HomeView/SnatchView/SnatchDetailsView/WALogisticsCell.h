//
//  WALogisticsCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

//中奖信息-物流信息

#import <UIKit/UIKit.h>
#import "WinningAffirmNode.h"


@interface WALogisticsCell : UIView


@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *companyLab;//物流公司
@property (nonatomic, strong) UILabel       *codeLab;//运单号
@property (nonatomic, strong) WinningAffirmNode      *node;// 数据

@end


