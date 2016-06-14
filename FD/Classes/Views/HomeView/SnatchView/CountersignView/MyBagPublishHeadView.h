//
//  MyBagPublishHeadView.h
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol MyBagPublishHeadViewDelegate <NSObject>

// 显示详情
- (void)showGoodsDetailPressed;
//TODO:显示中奖计算详情
- (void)showCountDetails;
//揭晓抽奖
- (void)publishDraw;//
@end

@interface MyBagPublishHeadView : UIView{
    BOOL    timeStart;// 第一次调用
    float    countDown;// 倒计时
}

@property (nonatomic, strong) UIImageView   *bgImgView;// 背景
@property (nonatomic, strong) UIImageView   *headImgView;//头像
@property (nonatomic, strong) UILabel       *nameLab;//名称
@property (nonatomic, strong) UILabel       *myConLab;//我发起的说明
@property (nonatomic, strong) UILabel       *conLab;//说明
@property (nonatomic, strong) UIButton      *lookBtn;


@property (nonatomic, strong) UIView        *footView;//商品界面
@property (nonatomic, strong) UIImageView   *goodsImgView;//商品图标
@property (nonatomic, strong) UILabel       *goodsLab;//商品介绍
@property (nonatomic, strong) UILabel       *goodsfLab;//商品介绍
@property (nonatomic, strong) UILabel       *countdownLab;//倒计时
@property (nonatomic, strong) NSTimer *timer;// 定时器

@property (nonatomic, strong) UILabel       *showLab;//底部显示
@property (nonatomic, assign) BOOL          isJoin;//是否加入
@property (nonatomic, strong) NSDictionary       *dataDic;//数据数目


@property (nonatomic, assign) id<MyBagPublishHeadViewDelegate>          delegate;//



@end
