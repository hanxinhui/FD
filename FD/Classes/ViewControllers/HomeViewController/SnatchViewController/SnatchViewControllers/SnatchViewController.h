//
//  MyFavViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:抽疯

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "SnatchAdView.h"
#import "HYSegmentedControl.h"
#import "SnatchHomeCell.h"
#import "RCDraggableButton.h"


@interface SnatchViewController : BaseViewController<FHTableViewDelegate,SnatchAdViewDelegate,SnatchHomeCellDelegate>
{
    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新
    NSInteger   nowSel;//当前选择类别
    BOOL isFirstIn;// 第一次进入
    
}
@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) UIView    *headView;// 头部View

@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, strong) NSMutableArray      *adsDataArr;//广告数据
@property (nonatomic, strong) UIImageView           *noImgView;//无数据
@property (nonatomic, strong) RCDraggableButton           *cartBtn;//购物车浮标

//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;




@end

