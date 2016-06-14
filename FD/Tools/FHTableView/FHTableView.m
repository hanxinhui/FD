//
//  FHTableView.m
//  ChengHongInformation
//
//  Created by Leoxu on 13-4-15.
//  Copyright (c) 2013年 Leoxu. All rights reserved.
//

#import "FHTableView.h"
#import "FontDefine.h"

#define OFFSET_TABLE_Y      3

#define controlsDistance 100

@implementation FHTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableViewWithFrame:self.bounds];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initTableViewWithFrame:self.bounds];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _table.frame = self.bounds;
    _canMove = NO;
    _isMyCountersign = NO;
}
-(void)initTableViewWithFrame:(CGRect)frame
{
    _table = [[UITableView alloc] initWithFrame:frame];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor clearColor];
    [self addSubview:_table];
    _table.showsVerticalScrollIndicator = NO;

    _canHidden = YES;
    _canBeHidden = YES;
    _table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _hasReloadView = YES;

    //下拉刷新
    if (_refreshHeaderView == nil && _hasReloadView) {
        
        _refreshHeaderView = [[WZRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _table.bounds.size.height, _table.frame.size.width, _table.bounds.size.height)];

        _refreshHeaderView.delegate = self;
        [_table addSubview:_refreshHeaderView];
        
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    [self performSelector:@selector(addFooterView) withObject:nil afterDelay:0.3f];
    
    [_table addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

-(void)setHasReloadView:(BOOL)hasReloadView
{
    if (!hasReloadView) {
        [_refreshHeaderView removeFromSuperview];
        [_refreshHeaderView release];
        _refreshHeaderView = nil;
    }
    else
    {
        if (_refreshHeaderView == nil) {
            
            _refreshHeaderView = [[WZRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _table.bounds.size.height, _table.frame.size.width, _table.bounds.size.height)];
            _refreshHeaderView.delegate = self;
            [_table addSubview:_refreshHeaderView];
            
        }
    }
    if (_isMyCountersign) {
        _refreshHeaderView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    }
}

-(void)delReloadView
{
    _refreshHeaderView.delegate = nil;
    [_refreshHeaderView removeFromSuperview];
    [_refreshHeaderView release];
    _refreshHeaderView = nil;
}

-(void)delLoadMoreView
{
    _loadMoreFooterView.delegate = nil;
    [_loadMoreFooterView removeFromSuperview];
    [_loadMoreFooterView release];
    _loadMoreFooterView = nil;
}

/**   函数名称 :addFooterView
 **   函数作用 :TODO:添加上拉加载更多
 **   函数参数 :
 **   函数返回值:
 **/
- (void)addFooterView {
    if (_loadMoreFooterView == nil) {
        
        _loadMoreFooterView = [[WZLoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.0f, _table.contentSize.height, _table.frame.size.width,_table.bounds.size.height)];
        _loadMoreFooterView.delegate = self;
        _loadMoreFooterView.hidden = !_hasMoreData;
        [_table insertSubview:_loadMoreFooterView atIndex:0];
    }
    [_loadMoreFooterView loadmoreLastUpdatedDate];
    
}
/**   函数名称 :setDataArray
 **   函数作用 :TODO:设置数据，更新列表
 **   函数参数 :
 **   函数返回值:
 **/
-(void)setDataArray:(NSArray *)dataArray
{
    if (dataArray != _dataArray) {
        [_dataArray release];
        _dataArray = [dataArray retain];
    }
    [_table reloadData];
//    if (_showSearchBar && !_searchBar.text.length && ![_searchBar isFirstResponder]) {
//        _table.contentInset = UIEdgeInsetsMake(-_searchBar.frame.size.height-8+OFFSET_TABLE_Y, 0, 0, 0);
//    }
}

-(void)setHasMoreData:(BOOL)hasMoreData
{
    _hasMoreData = hasMoreData;
    _loadMoreFooterView.frame = CGRectMake(0.0f, _table.contentSize.height, _table.frame.size.width,_table.bounds.size.height);
    [_table sendSubviewToBack:_loadMoreFooterView];
    _loadMoreFooterView.hidden = !_hasMoreData;
}

-(void)dealloc
{
    [_table removeObserver:self forKeyPath:@"contentSize"];
    [_table release];
    [_dataArray release];
    
    [_config release];
    [_refreshHeaderView release];
    [_loadMoreFooterView release];
//    [_searchBar release];
    [_searchDisplayController release];
    [super dealloc];
}

/**   函数名称 :scrollToTopWithAnimotion
 **   函数作用 :TODO:滑动到顶部
 **   函数参数 :
 **   函数返回值:
 **/
-(void)scrollToTopWithAnimotion:(BOOL)animotion
{
    [_table scrollRectToVisible:CGRectMake(0, 0, _table.frame.size.width, _table.frame.size.height) animated:animotion];
      //    [_table setContentOffset:CGPointZero];
}

-(void)setCanBeHidden:(BOOL)canBeHidden
{
    _canBeHidden = canBeHidden;
    if (canBeHidden == NO) {
        _isHidden = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(showControls)]) {
            [_delegate showControls];
        }
    }
}

//设置
-(void)setIsHidden:(BOOL)isHidden
{
    _isHidden = isHidden;
}

//-(void)setShowSearchBar:(BOOL)showSearchBar
//{
//    _showSearchBar = showSearchBar;
//    if (showSearchBar && [_delegate isKindOfClass:[UIViewController class]]) {
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 43)];
//        _searchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(7, 5, iPhoneWidth - 15, 39)];
//        self.searchBar.placeholder = @"输入你要搜索的标题或者关键字";
//        //        [self.searchBar setSearchBarBackGround:[UIImage imageNamed:@"searchBar_bg.png"]];
//        [self.searchBar setSearchBarLeftIcon:[UIImage imageNamed:@"searchBar_left.png"]];
//        [self.searchBar setSearchBarRightIcon:[UIImage imageNamed:@"search_clear.png"]];
//        self.searchBar.delegate = _delegate;
//        [self.searchBar setContentMode:UIViewContentModeCenter];
//        //        [self.searchBar sizeToFit];
//        
//        //        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:(UIViewController *)_delegate];
//        //        self.searchDisplayController.searchResultsDataSource = self;
//        //        self.searchDisplayController.searchResultsDelegate = self;
//        //        self.searchDisplayController.delegate = _delegate;
//        [headerView addSubview:_searchBar];
//        _table.tableHeaderView = headerView;
//        [headerView release];
//        
//        _table.contentInset = UIEdgeInsetsMake(-_searchBar.frame.size.height-8+OFFSET_TABLE_Y, 0, 0, 0);
//        
//    }
//    else
//    {
//        _table.tableHeaderView = nil;
//        self.searchBar = nil;
//        self.searchDisplayController = nil;
//        _table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        
//    }
//}

#pragma mark
#pragma mark =======tableView Delegate=======
//TODO:Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_delegate numberOfSectionsInTableView:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_delegate fhtable:self titleForHeaderInSection:section];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [_delegate fhtable:self viewForHeaderInSection:section];
    
}

//TODO:section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [_delegate fhtable:self heightForHeaderInSection:section];
    
}
//TODO:Row
//有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_delegate fhtable:self numberOfRowsInSection:section];
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_delegate fhtable:self heightForRowAtIndexPath:indexPath];
}
//获取cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_delegate fhtable:self cellForRowAtIndexPath:indexPath];
}
//删除行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_delegate fhtable:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
// 是否需要删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_canDelete)
        return UITableViewCellEditingStyleNone;
    else {
        return UITableViewCellEditingStyleDelete;
    }
    
}
//点击代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRowAtIndexPath:node:)]) {
       id node = [_dataArray objectAtIndex:indexPath.row];
        [_delegate didSelectRowAtIndexPath:indexPath node:node];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

-(UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    return [_table dequeueReusableCellWithIdentifier:identifier];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _loading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _loading = NO;
    _canHidden = NO;
    [_refreshHeaderView wzRefreshScrollViewDataSourceDidFinishedLoading:_table];
//    if (_showSearchBar && !_searchBar.text.length && ![_searchBar isFirstResponder]) {
//        if (_table.contentSize.height < _table.frame.size.height+_searchBar.frame.size.height) {
//            _table.contentSize = CGSizeMake(iPhoneWidth, _table.frame.size.height+_searchBar.frame.size.height+5);
//        }else if (_table.contentSize.height < _table.frame.size.height) {
//            _table.contentSize = CGSizeMake(iPhoneWidth, _table.frame.size.height+5);
//        }
//        _table.contentInset = UIEdgeInsetsMake(-_searchBar.frame.size.height-8+OFFSET_TABLE_Y, 0, 0, 0);
//    }
    _canHidden = YES;
    
}
- (void)loadMoreTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _loading = YES;
    
}

- (void)doneLoadMoreTableViewData{
    
    //  model should call this when its done loading
    _loading = NO;
    _canHidden = NO;
    _loadMoreFooterView.hidden = !_hasMoreData;
    _canHidden = YES;
    [_loadMoreFooterView wzLoadMoreScrollViewDataSourceDidFinishedLoading:_table];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    [_refreshHeaderView wzRefreshScrollViewDidScroll:scrollView];
    [_loadMoreFooterView wzLoadMoreScrollViewDidScroll:scrollView];
    if (scrollView.contentSize.height <= scrollView.frame.size.height) {
        return;
    }
    if (scrollView.contentOffset.y > 0 &&  scrollView.contentOffset.y+scrollView.frame.size.height < scrollView.contentSize.height) {
        _canHidden = YES;
    }else
//        _canHidden = NO;
        _canHidden = NO;
    
    BOOL exceedUpLine = scrollView.contentOffset.y <= 0;
    BOOL exceedDownLine = scrollView.contentOffset.y+scrollView.frame.size.height >= scrollView.contentSize.height;
    
    if ((_YContentOffSet + controlsDistance < scrollView.contentOffset.y || exceedDownLine)&& !_isHidden &&(_canHidden||exceedDownLine) && _canBeHidden) {
        _YContentOffSet = scrollView.contentOffset.y;
        if (_delegate && [_delegate respondsToSelector:@selector(hideControls)]) {
            [_delegate hideControls];
            _isHidden = YES;
        }
    }
    else if ((_YContentOffSet - controlsDistance > scrollView.contentOffset.y || exceedUpLine)&&_isHidden &&(_canHidden||exceedUpLine)&& _canBeHidden)
    {
        _YContentOffSet = scrollView.contentOffset.y;
        if (_delegate && [_delegate respondsToSelector:@selector(showControls)]) {
            [_delegate showControls];
            _isHidden = NO;
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(isSurpassOriginY:)]) {
        [_delegate isSurpassOriginY:scrollView.contentOffset.y];
        
        //
    }
    [NSObject
     
     cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:)
               withObject:scrollView
               afterDelay:0.3];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_canMove) {
        if (_delegate && [_delegate respondsToSelector:@selector(isBeginMove:)]) {
            [_delegate isBeginMove:YES];
            
        }
    }

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [_refreshHeaderView wzRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreFooterView wzLoadMoreScrollViewDidEndDragging:scrollView];
    _YContentOffSet = scrollView.contentOffset.y;
 

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (_delegate && [_delegate respondsToSelector:@selector(isBeginMove:)]) {
//        NSLog(@"======DidEndDecelerating=====");
//        [_delegate isBeginMove:NO];
//        
//    }
}





-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //do something here
    if (_canMove) {
        if (_delegate && [_delegate respondsToSelector:@selector(isBeginMove:)]) {
            [_delegate isBeginMove:NO];
            
        }
    }
 
}

#pragma mark -
#pragma mark WZRefreshTableHeaderDelegate Methods
- (void)wzRefreshTableHeaderDidTriggerRefresh:(WZRefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    if (_delegate && [_delegate respondsToSelector:@selector(reloadTableViewDataSource:)]) {
        [_delegate reloadTableViewDataSource:self];
    }
}

- (BOOL)wzRefreshTableHeaderDataSourceIsLoading:(WZRefreshTableHeaderView*)view{
    
    return _loading; // should return if data source model is reloading
    
}

- (NSDate*)wzRefreshTableHeaderDataSourceLastUpdated:(WZRefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}
#pragma mark -
#pragma mark WZLoadMoreTableFooterDelegate Methods
- (void)wzLoadMoreTableHeaderDidTriggerRefresh:(WZLoadMoreTableFooterView*)view {
    
    [self loadMoreTableViewDataSource];
    if (_delegate && [_delegate respondsToSelector:@selector(loadMoreTableViewDataSource:)]) {
        [_delegate loadMoreTableViewDataSource:self];
    }
}
- (BOOL)wzLoadMoreTableHeaderDataSourceIsLoading:(WZLoadMoreTableFooterView*)view {
    return _loading;
}
- (NSDate*)wzLoadMoreTableHeaderDataSourceLastUpdated:(WZLoadMoreTableFooterView*)view {
    return [NSDate date]; // should return date data source was last changed
}


//观察者
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentSize"])
    {
        _loadMoreFooterView.frame = CGRectMake(0.0f, _table.contentSize.height, _table.frame.size.width,_table.bounds.size.height);
        //        if (_table.contentOffset.y + _table.frame.size.height > _table.contentSize.height) {
        //            [_table scrollRectToVisible:CGRectMake(0, _table.contentSize.height-_table.frame.size.height+_table.contentInset.bottom, _table.frame.size.width, _table.frame.size.height) animated:YES];
        //        }
    }
}




-(void)setReloadingStateString:(NSString *)normal loading:(NSString *)loading
{
    _refreshHeaderView.normalStr = normal;
    _refreshHeaderView.loadingStr = loading;
}

@end
