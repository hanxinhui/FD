//
//  MyFavViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:分类浏览列表

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "SnatchHomeListNode.h"


typedef enum {
    ClassifyListWelfare,// 分类进入
    ClassifyListSearch //搜索进入
    
} ClassifyListStyle;


@interface WelfareClassifyListViewController : BaseViewController<FHTableViewDelegate>
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

@property (nonatomic, strong) NSString   *getClassifyId;// 数据加载tab
@property (nonatomic) ClassifyListStyle   listStyle;//类型


@end

