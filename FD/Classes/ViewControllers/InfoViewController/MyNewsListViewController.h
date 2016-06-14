//
//  MyNewsListViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:我的消息

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"



@interface MyNewsListViewController : BaseViewController<FHTableViewDelegate>
{
    float setHeight;//设置高度
    
    BOOL  isLoading;//是否刷新
    
    NSInteger  rowS;//选择删除
    
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;


@end

