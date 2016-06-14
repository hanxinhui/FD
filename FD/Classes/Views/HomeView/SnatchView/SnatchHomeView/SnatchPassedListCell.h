//
//  GoodsListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//
// 往期揭晓

#import <UIKit/UIKit.h>
#import "PassedSnatchNode.h"
#import "MMLabel.h"

@interface SnatchPassedListCell : UITableViewCell

@property (nonatomic, strong) UILabel       *periodsLab;//期数
@property (nonatomic, strong) UILabel       *timeLab;//揭晓时间
@property (nonatomic, strong) UIImageView   *xuImgView;//虚线
@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *nameLab;//获奖者
@property (nonatomic, strong) UILabel       *idLab;//获奖id
@property (nonatomic, strong) UILabel       *numLab;//获奖号码
@property (nonatomic, strong) MMLabel       *countLab;//参与次数

@property (nonatomic, strong) PassedSnatchNode      *node;// 数据

@end


