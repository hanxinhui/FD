//
//  MyConViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:分类列表

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "SnatchClassifyListCell.h"
#import "RCDraggableButton.h"




@interface SnatchClassifyListViewController :  BaseViewController<FHTableViewDelegate,SnatchClassifyListCellDelegate>
{
    float setHeight;//设置高度
     BOOL  isLoading;//是否刷新
    BOOL isFirstIn;// 第一次进入

}

@property (nonatomic, strong) NSString   *getClassifyId;// 数据加载tab
@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (nonatomic, strong) UIImageView       *noImgView;// 没有数据显示视图
@property (nonatomic, strong) RCDraggableButton           *cartBtn;//购物车浮标

@end

