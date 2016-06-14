//
//  AnyTimeBuyViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:随心兑

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ShopTabarView.h"
#import "GoodsBtnScrollView.h"
#import "FHTableView.h"
#import "InstructionsView.h"
#import "ScreenGoodsView.h"

@interface ShopViewController : BaseViewController<ShopTabarViewDelegate,FHTableViewDelegate,GoodsBtnScrollViewDelegate,UIGestureRecognizerDelegate,InstructionsViewDelegate,ScreenGoodsViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新

    BOOL  isFirstL; //是否第一次进入
    NSInteger   headNum;//  头部选择
    NSInteger   footNum;// 底部选择
    
    NSInteger  noSelect;// 当前选择
    NSInteger  noSelecttag;// 当前选择
    BOOL    isSarch;// 是否搜索

}
@property (nonatomic, strong) GoodsBtnScrollView *selectBtnScrollView;

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, strong) NSMutableArray      *cateDataArr;//类别列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;

//@property (nonatomic, strong) ShopTabarView  *shopTabarView;
@property (nonatomic, strong) UIImageView  *noImgView;// 没有数据显示视图

@property (nonatomic, strong) InstructionsView  *instructionsView;//
@property (nonatomic, strong) UIButton          *bgHiddenBtn;// 隐藏
@property (nonatomic, strong) ScreenGoodsView     *screenGoodsView;//筛选
@property (nonatomic, strong) NSString          *firstStr;//收益
@property (nonatomic, strong) UIButton          *screenbgHiddenBtn;// 隐藏

@end

