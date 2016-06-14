//
//  MyBankListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBankListNode.h"

@interface MyBankListCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *bankLab;//银行名称
@property (nonatomic, strong) UILabel       *codeLab;//卡号
@property (nonatomic, strong) UILabel       *typeLab;//类型

@property (nonatomic, strong) MyBankListNode      *node;// 数据

@end


