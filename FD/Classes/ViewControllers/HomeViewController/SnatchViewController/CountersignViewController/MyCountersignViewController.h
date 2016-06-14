//
//  MyFavViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:我的暗号

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "MyBagHeadView.h"



@interface MyCountersignViewController : BaseViewController<FHTableViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新
    
    NSInteger nowSelect;
}

@property (nonatomic, strong) MyBagHeadView  *headView;// 头部界面


@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (nonatomic, strong) UIImageView       *noImgView;// 没有数据显示视图

@property (nonatomic, strong) NSString   *getClassifyId;// 数据加载tab

@end

