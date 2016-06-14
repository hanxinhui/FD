//
//  MyBagOpenHeadView.h
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnatchHomeListNode.h"


@protocol MyBagOpenHeadViewDelegate <NSObject>

// 显示详情
- (void)showGoodsDetailPressed;
//TODO:显示中奖计算详情
- (void)showCountDetails;

@end

@interface MyBagOpenHeadView : UIView

@property (nonatomic, strong) UIImageView   *bgImgView; //背景
@property (nonatomic, strong) UIImageView   *headImgView;//头像
@property (nonatomic, strong) UILabel       *nameLab;//名称
@property (nonatomic, strong) UILabel       *conLab;//说明
@property (nonatomic, strong) UILabel       *myconLab;//我发起说明
@property (nonatomic, strong) UIImageView   *goodsImgView;//商品图标
@property (nonatomic, strong) UILabel       *goodsLab;//商品介绍
@property (nonatomic, strong) UILabel       *goodsfLab;//商品副标题介绍

@property (nonatomic, strong) UIView        *footView;//底部界面
@property (nonatomic, strong) UILabel       *dateLab;//时间

@property (nonatomic, strong) UIImageView   *showImgView;//已显示领取数目
@property (nonatomic, strong) UILabel       *showLab;//未显示领取数目
@property (nonatomic, strong) UILabel        *numberLab;//号码
@property (nonatomic, strong) UIButton       *lookBtn;//查看

@property (nonatomic, strong) NSDictionary       *dataDic;// 数据
@property (nonatomic, assign) BOOL          isJoin;// 是否是参加

@property (nonatomic, strong) SnatchHomeListNode      *node;// 数据
@property (nonatomic, assign) id<MyBagOpenHeadViewDelegate>          delegate;//



@end
