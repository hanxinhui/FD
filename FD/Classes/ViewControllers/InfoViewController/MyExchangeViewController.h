//
//  MyTasksViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:我的兑换

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HYSegmentedControl.h"
#import "MyGoodsListCell.h"

#import "MyGoodsListNode.h"

#import "FHTableView.h"


@interface MyExchangeViewController : BaseViewController<FHTableViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新

    NSInteger   nowSel;//当前选择
    
    NSInteger   rowS;
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (nonatomic, strong) UIImageView  *noImgView;// 没有数据显示视图

@end

