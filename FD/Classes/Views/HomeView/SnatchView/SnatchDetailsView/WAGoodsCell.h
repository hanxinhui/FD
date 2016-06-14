//
//  WAGoodsCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 中奖信息-商品信息

#import <UIKit/UIKit.h>
#import "WinningAffirmNode.h"
#import "MMLabel.h"

@interface WAGoodsCell : UIView


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *datanumLab;//期号
@property (nonatomic, strong) UILabel       *allPeoLab;//总需
@property (nonatomic, strong) UILabel       *lucknumLab;//幸运号码
@property (nonatomic, strong) MMLabel       *inpeoLab;//本期参与
@property (nonatomic, strong) UILabel       *timelab;//揭晓时间

@property (nonatomic, strong) WinningAffirmNode      *node;// 数据
@end


