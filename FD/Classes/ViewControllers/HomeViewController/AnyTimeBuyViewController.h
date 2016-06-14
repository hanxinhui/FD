//
//  AnyTimeBuyViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:随时赚

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BuyTabarView.h"
#import "FHTableView.h"
#import "BarBtnScrollView.h"
#import "InstructionsView.h"
#import "ScreenBuyView.h"
#import "ScreenBuyBgView.h"

#import "AnyBuyView.h"


@interface AnyTimeBuyViewController : BaseViewController<BuyTabarViewDelegate,FHTableViewDelegate,BarBtnScrollViewDelegate,UIGestureRecognizerDelegate,InstructionsViewDelegate,ScreenBuyViewDelegate,AnyBuyViewDelegate>
{
    float setHeight;//设置高度
    float   setChangeH;//是否改变高度
    float  phoneH;
    float  tableh;
    BOOL  isLoading;//是否刷新
    BOOL    isSarch;// 是否搜索

    NSInteger  noSelect;// 当前选择

    NSInteger   headNum;//  头部选择
    NSInteger   footNum;// 底部选择
    
    BOOL  isHaveData;// 是否有数据
    UIButton   *_allBtn;
    
    NSInteger  nowCurrentIndex;// 当前综合选择
    
    BOOL  isUsedYE;// 是否使用余额
}

@property (nonatomic, strong) BarBtnScrollView *selectBtnScrollView;

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;

@property (nonatomic, strong) BuyTabarView      *buyTabarView;
@property (nonatomic, strong) UIImageView       *noImgView;// 没有数据显示视图
@property (nonatomic, strong) InstructionsView  *instructionsView;//
@property (nonatomic, strong) UIButton          *bgHiddenBtn;// 隐藏
@property (nonatomic, strong) ScreenBuyView     *screenBuyView;//筛选
@property (nonatomic, strong) ScreenBuyBgView     *screenBuyBgView;//筛选背景
@property (nonatomic, strong) UIButton          *screenbgHiddenBtn;// 隐藏

@property (nonatomic, strong) NSString      *profitStr;//收益
@property (nonatomic, strong) NSString     *cycleStr;//期限
@property (nonatomic, strong) AnyBuyView    *buyView;//综合筛选
@property (nonatomic, strong) UIView    *hiddenView;// 筛选阴影界面

@end

