//
//  WelFareSearchViewController.m
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "WelFareSearchViewController.h"
#import "SearchCell.h"
#import "WelfareClassifyListViewController.h"

#define CELL_HIGHT     30

@interface WelFareSearchViewController ()

@end

@implementation WelFareSearchViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    self.dlineImgView.hidden = YES;

    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    //分类
    UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classBtn.frame = CGRectMake(0, 0, 50, 50);
    classBtn.backgroundColor = [UIColor clearColor];
    [classBtn setTitle:@"取消" forState:UIControlStateNormal];
    [classBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [classBtn addTarget:self action:@selector(classPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = classBtn;

    self.rightBtn.frame = CGRectMake(iPhoneWidth - self.rightBtn.frame.size.width, 0, self.rightBtn.frame.size.width, 45);

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
    
    [self initNavBar];
//    setHeight = setHeight + NVARBAR_HIGHT+ 5;
    
    
    //搜索框
    _searchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(15, setHeight, iPhoneWidth - 65, 45)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.backgroundColor =[UIColor clearColor];
    [self.searchBar setSearchBarBackGround:[UIImage imageNamed:@"Home_Search.png"]];
    [self.searchBar setSearchBarLeftIcon:[UIImage imageNamed:@"Home_search_left.png"]];
     [self.searchBar setSearchBarRightIcon:[UIImage imageNamed:@"search_clear.png"]];
    self.searchBar.delegate = self;
    [self.searchBar setContentMode:UIViewContentModeCenter];
    [self.view addSubview:_searchBar];
    setHeight = setHeight + 53;
    


    
    _listDataArr =  [NSMutableArray array];
    _listDataArr = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_TASK_DATA];
    
    
    
    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - 250)];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.backgroundColor = [UIColor clearColor];
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
    
    
    isLoading = NO;
    
    
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    


}


#pragma mark -
#pragma mark ======刷新或显示更多获取数据后手动调用完成函数======

-(void)doneLoadMoreTableViewData:(FHTableView *)table
{
    [table doneLoadMoreTableViewData];
}

-(void)doneLoadingTableViewData:(FHTableView *)table
{
    [table doneLoadingTableViewData];
    [table doneLoadMoreTableViewData];
}

//Section 段数
- (NSInteger)numberOfSectionsInTableView:(FHTableView *)ftableView
{
    
    return _listDataArr.count;
}
-(CGFloat)fhtable:(FHTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (NSString *)fhtable:(FHTableView *)table titleForHeaderInSection:(NSInteger)section{
    
    return nil;
    
}
- (UIView *)fhtable:(FHTableView *)table viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath node:(id)node
{
    [_searchBar resignFirstResponder];
    NSInteger tag = _listDataArr.count - indexPath.section - 1;
    
    [self classifyAction:[_listDataArr objectAtIndex:tag]];
    
}

-(CGFloat)fhtable:(FHTableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HIGHT;
}
-(NSInteger)fhtable:(FHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)fhtable:(FHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SearchCell";
    SearchCell *cell = (SearchCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    NSInteger tag = _listDataArr.count - indexPath.section - 1;
    cell.titleLab.text = [_listDataArr objectAtIndex:tag];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

//TODO:是否超过滑动高度 隐藏
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{
    
}
//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
}
//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
}

#pragma mark -
#pragma mark ======searchBar delegate=====
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_listDataArr.count == 0){
        _listDataArr = [NSMutableArray array];
        [_listDataArr addObject:searchBar.text];
        
    }else{
        _listDataArr = [NSMutableArray arrayWithCapacity:10];
        NSArray *arrs = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_TASK_DATA];
        
        for (NSString *keyW in arrs) {
            [_listDataArr insertObject:keyW atIndex:_listDataArr.count];
            
            //            [_listDataArr addObject:keyW];
        }
        for (NSString *words in arrs) {
            if ([words isEqualToString:searchBar.text]) {
                [_listDataArr removeObject:words];
            }
        }
        [_listDataArr addObject:searchBar.text];
        
        
        if (_listDataArr.count > 10) {
            [_listDataArr removeObjectAtIndex:0];
        }
        
    }
    
    [_searchBar resignFirstResponder];
    [[NSUserDefaults standardUserDefaults] setObject:_listDataArr forKey:SEARCH_TASK_DATA];
    [[NSUserDefaults standardUserDefaults] setObject:_searchBar.text forKey:SEARCH_TASK_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:SEARCH_TASK_SUCCESS object:nil];
    [self classifyAction:_searchBar.text];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText is %@",searchText);
    
    if (searchBar.text.length <= 0) {
        
        [[SystemStateManager sharedSystemStateManager] showProgressWithString:@"请输入搜索内容" hiddenAfterDelay:1];
        return;
    }
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.view removeGestureRecognizer:[self.view.gestureRecognizers lastObject]];
    
    
}
-(void)classPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark ============ 点击事件 ============

//TODO:进入分类
- (void)classifyAction:(NSString *)str{
    
    WelfareClassifyListViewController *classifyListViewController = [[WelfareClassifyListViewController alloc]init];
    classifyListViewController.listStyle = ClassifyListSearch;
    classifyListViewController.getClassifyId = str;
    [self.navigationController pushViewController:classifyListViewController animated:YES];
}



#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
