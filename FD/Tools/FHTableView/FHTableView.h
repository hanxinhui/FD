//
//  FHTableView.h
//  ChengHongInformation
//
//  Created by Leoxu on 13-4-15.
//  Copyright (c) 2013年 Leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomSearchBar.h"
#import "WZRefreshTableHeaderView.h"
#import "WZLoadMoreTableFooterView.h"

@class FHTableView;

@protocol FHTableViewDelegate <UISearchBarDelegate,UISearchDisplayDelegate>

@optional
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath node:(id)node;
-(void)reloadTableViewDataSource:(FHTableView *)table;
-(void)loadMoreTableViewDataSource:(FHTableView *)table;
-(void)showControls;
-(void)hideControls;
@required
-(CGFloat)fhtable:(FHTableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)fhtable:(FHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)fhtable:(FHTableView *)tableView numberOfRowsInSection:(NSInteger)section;
//删除操作
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

//Section
- (NSInteger)numberOfSectionsInTableView:(FHTableView *)ftableView;
- (NSString *)fhtable:(FHTableView *)table titleForHeaderInSection:(NSInteger)section;
- (UIView *)fhtable:(FHTableView *)table viewForHeaderInSection:(NSInteger)section;
// 高度
- (CGFloat )fhtable:(FHTableView *)table heightForHeaderInSection:(NSInteger)section;

//TODO:是否超过滑动高度 隐藏
- (void )isSurpassOriginY:(CGFloat )surpassOriginY;

- (void)isBeginMove:(BOOL)isMove;
@end

@interface FHTableView : UIView <UITableViewDataSource,UITableViewDelegate,WZRefreshTableHeaderDelegate,WZLoadMoreTableFooterDelegate,UIGestureRecognizerDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
{
    //一页多少row
    int     _numInPage;
    //配置
    NSDictionary *_config;
    //上拉加载更多，下拉刷新
    WZRefreshTableHeaderView * _refreshHeaderView;
    WZLoadMoreTableFooterView * _loadMoreFooterView;
    BOOL _loading;
    //停留的y坐标
    float _YContentOffSet;
    BOOL _isHidden;
    BOOL _canHidden;
    
}
//table
@property (retain, nonatomic) UITableView *table;
//数据源
@property (retain ,nonatomic) NSArray *dataArray;
//是否还有数据
@property (assign, nonatomic) BOOL hasMoreData;
//是否可以下拉刷新
@property (assign, nonatomic) BOOL hasReloadView;
//代理
@property (assign, nonatomic) IBOutlet id <FHTableViewDelegate> delegate;
//是否可以显示隐藏控件
@property (assign, nonatomic) BOOL canBeHidden;
//是否可以删除
@property (assign, nonatomic) BOOL canDelete;
@property (assign, nonatomic) BOOL canMove;// 可以移动

////搜索栏
//@property (retain, nonatomic) CustomSearchBar *searchBar;
@property (assign, nonatomic) BOOL showSearchBar;
@property (retain, nonatomic) UISearchDisplayController *searchDisplayController;

@property (assign, nonatomic) BOOL isMyCountersign;// 是我的抢宝



//删除重新加载功能
-(void)delReloadView;
//删除加载更多功能
-(void)delLoadMoreView;
//重用
-(UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
//滑动到顶端
-(void)scrollToTopWithAnimotion:(BOOL)animotion;
//完成上拉加载更多
-(void)doneLoadMoreTableViewData;
//完成刷新
-(void)doneLoadingTableViewData;
//设置
-(void)setIsHidden:(BOOL)isHidden;


-(void)setReloadingStateString:(NSString *)normal loading:(NSString *)loading;
@end

