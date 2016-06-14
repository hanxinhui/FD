//
//  SnatchGoodsView.h
//  SnatchGoodsView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnatchHomeListNode.h"



@protocol SnatchGoodsViewDelegate <NSObject>

//TODO:加入购物车
- (void)addCartPressed:(id)sender;
// 显示详情
- (void)showDetailPressed:(id)sender;

@end
@interface SnatchGoodsView : UIView

@property (nonatomic, strong) UIImageView   *goodsImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *progressLab;//进度
@property (nonatomic, strong) UIProgressView    *progressView;//进度条
@property (nonatomic, strong) UIButton    *showBtn;//显示详情

@property (nonatomic, strong) UIButton    *addBtn;//加入清单

@property (nonatomic, strong) SnatchHomeListNode      *node;// 数据
@property (nonatomic, assign) id<SnatchGoodsViewDelegate>          delegate;//

@end
