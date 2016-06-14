//
//  WinningRecordCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningRecordNode.h"
#import "MMLabel.h"

@protocol WinningRecordCellDelegate <NSObject>

- (void)doAnyPressed:(id)sender;// 点击事件

@end

@interface WinningRecordCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *datanumLab;//期号
@property (nonatomic, strong) UILabel       *allPeoLab;//总需
@property (nonatomic, strong) UILabel       *lucknumLab;//幸运号码
@property (nonatomic, strong) MMLabel       *inpeoLab;//本期参与
@property (nonatomic, strong) UILabel       *timelab;//揭晓时间
@property (nonatomic, strong) UILabel       *explainlab;//进度说明
@property (nonatomic, strong) UIButton      *sureAddressBtn;//确认收货地址

@property (nonatomic, strong) WinningRecordNode      *node;// 数据
@property (nonatomic, assign) id<WinningRecordCellDelegate>      delegate;// 

@end


