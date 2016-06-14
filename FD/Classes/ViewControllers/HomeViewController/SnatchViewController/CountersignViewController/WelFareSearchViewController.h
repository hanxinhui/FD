//
//  WelFareSearchViewController.h
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//


//TODO:口令搜索

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "CustomSearchBar.h"
#import "SnatchHomeListNode.h"



@interface WelFareSearchViewController : BaseViewController<FHTableViewDelegate,UISearchBarDelegate>

{
    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (strong, nonatomic) CustomSearchBar *searchBar;



@end
