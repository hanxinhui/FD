//
//  WinningAffirmViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:中奖确认

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WAAddressCell.h"
#import "WAGoodsCell.h"
#import "WALogisticsCell.h"
#import "WAStatusCell.h"
#import "WinningAffirmNode.h"



@interface WinningAffirmViewController : BaseViewController<UIScrollViewDelegate,WAStatusCellDelegate>
{
    float setHeight;//设置高度
    
}

@property (nonatomic, assign) NSString *winGoods;// 奖品id
@property (nonatomic , strong) UIScrollView     *mainScrollView;//主页面
@property (nonatomic, strong) WAStatusCell *statusCell;// 奖品状态
@property (nonatomic, strong) WALogisticsCell *logisticsCell;// 物流信息
@property (nonatomic, strong) WAAddressCell *addressCell;// 地址信息
@property (nonatomic, strong) WAGoodsCell *goodsCell;//奖品信息
@property (nonatomic , strong) WinningAffirmNode     *affirmNode;//详情数据

@end

