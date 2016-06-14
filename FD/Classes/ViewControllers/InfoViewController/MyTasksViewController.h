//
//  MyTasksViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:我的任务

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HYSegmentedControl.h"
#import "MyTaskAnyCell.h"
#import "MyTaskGetCell.h"
#import "MyTaskLayCell.h"
#import "MyTaskAnyCellNode.h"
#import "MyTaskGetCellNode.h"
#import "MyTaskLayCellNode.h"
#import "FHTableView.h"


@interface MyTasksViewController : BaseViewController<FHTableViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新

    NSInteger   nowSel;//当前选择
    NSInteger  rowS;// 选择
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (nonatomic, strong) UIImageView  *noImgView;// 没有数据显示视图

@end

