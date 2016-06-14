//
//  WelfareGetDetailsViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:选择商品

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#import "FHTableView.h"
#import "SnatchHomeListNode.h"

@protocol WelfareGetSearchDelegate <NSObject>

@optional

- (void)getGoodsNode:(SnatchHomeListNode *)node;//传回数据


@end

@interface WelfareGetSearchListViewController : BaseViewController<UISearchBarDelegate,FHTableViewDelegate>
{
    float setHeight;//设置高度
    BOOL isLoading;
}
@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (assign, nonatomic) id<WelfareGetSearchDelegate> delegate;



@end

