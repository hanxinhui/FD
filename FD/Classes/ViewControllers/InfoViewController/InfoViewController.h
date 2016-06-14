//
//  HomeViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:个人中心

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"



@interface InfoViewController : BaseViewController<UIScrollViewDelegate,EGORefreshTableHeaderDelegate>
{
    float setHeight;//设置高度
    float setScHeight;//设置高度
   	EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;

    NSInteger _pageCount;
    NSInteger _speed;

}

@property (nonatomic , strong) UIScrollView  *mainScrollView;//主页面
@property (nonatomic , strong) UILabel      *allMoneyLab;// 总资产
@property (nonatomic , strong) UILabel      *todayEarningsLab;//今日收益
@property (nonatomic , strong) UILabel      *allEarningsLab;//总收益
@property (nonatomic , strong) UILabel      *outLab;//可提现
@property (nonatomic , strong) UILabel      *freezeLab;//体验金
@property (nonatomic , strong) UILabel      *taskLab;//任务保证金
@property (nonatomic , strong) UILabel      *usableLab;//可用保证金

@property (nonatomic , strong) UIScrollView  *topScrollView;//头部
@property (nonatomic , strong) UIPageControl  *headPangeControl;
@property (nonatomic , strong) NSTimer        *timermao; //定时器

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
//TODO: 获取网络数据
- (void)getHttpData;
@end

