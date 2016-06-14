//
//  LayListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayListNode.h"

@interface LayListCell : UITableViewCell
{
    NSInteger    djsNum;
}

@property (nonatomic, strong) UIImageView   *bgImgView;//图标
@property (nonatomic, strong) UIImageView   *footBGImgView;//底部背景
@property (nonatomic, strong) UIImageView   *timeImgView;// 背景
@property (nonatomic, strong) UILabel       *timeLab;//开奖时间
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *conLab;//说明
@property (nonatomic, strong) UILabel       *moneynLab;//保证金
@property (nonatomic, strong) UILabel       *timeconLab;//开奖时间说明
@property (nonatomic, strong) UILabel       *stoptLab;//截止时间

@property (nonatomic, strong) LayListNode      *node;// 数据

@end


