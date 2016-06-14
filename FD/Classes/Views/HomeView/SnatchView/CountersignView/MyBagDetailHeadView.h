//
//  MyBagDetailHeadView.h
//  MyBagDetailHeadView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnatchHomeListNode.h"

typedef enum {
    WelfareCoun,// 福利抢宝
    GroupCoun // 群抢宝
    
} CounStyle;

@protocol MyBagDetailHeadViewDelegate <NSObject>

// 显示详情
- (void)showGoodsDetailPressed;
//揭晓抽奖
- (void)publishDraw;//

//立即参加
- (void)payNowPressed;
@end

@interface MyBagDetailHeadView : UIView
{
    BOOL    timeStart;// 第一次调用

    float    countDown;// 倒计时

}
@property (nonatomic, strong) UIImageView   *bgImgView;//背景
@property (nonatomic, strong) UIImageView   *headImgView;//头像
@property (nonatomic, strong) UILabel       *nameLab;//名称
@property (nonatomic, strong) UILabel       *conLab;//说明
@property (nonatomic, strong) UILabel       *myconLab;//我发起说明

@property (nonatomic, strong) UIView        *footView;//底部界面
@property (nonatomic, strong) UIImageView   *goodsImgView;//商品图标
@property (nonatomic, strong) UILabel       *goodsLab;//商品介绍
@property (nonatomic, strong) UILabel       *goodsfLab;//商品介绍
@property (nonatomic, strong) UIProgressView    *progressView;//进度条
@property (nonatomic, strong) UILabel       *joinLab;//参加人数
@property (nonatomic, strong) UILabel       *remainLab;//剩余
@property (nonatomic, strong) UILabel       *footshowConLab;//底部说明
@property (nonatomic, strong) UILabel       *countdownLab;//倒计时
@property (nonatomic, strong) NSTimer *timer;// 定时器
@property (nonatomic, strong) UILabel       *footConLab;//底部说明
@property (nonatomic, strong) NSDictionary       *dataDic;// 数据
@property (nonatomic, assign) BOOL          isJoin;// 是否是参加
@property (nonatomic, assign) BOOL          isCancel;// 是否取消
@property (nonatomic, strong) UIImageView   *footImgView;//底部图片

@property (nonatomic, strong)  UIButton *showBtn;  //显示详情
@property (nonatomic, strong)  UIButton *addPayBtn;  //立即参与

@property (nonatomic, assign) id<MyBagDetailHeadViewDelegate>          delegate;//
@property (nonatomic) CounStyle       counStyle;// 请求类型

@end
