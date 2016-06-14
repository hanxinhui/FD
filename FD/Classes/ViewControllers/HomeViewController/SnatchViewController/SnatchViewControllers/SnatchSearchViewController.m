//
//  SnatchSearchViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SnatchSearchViewController.h"
#import "SnatchClassifyListCell.h"
#import "SnatchHomeListNode.h"
#import "SnatchDetailsViewController.h"
#import "LoginViewController.h"


#define CELL_HIGHT         140  // 底部高度

@interface SnatchSearchViewController ()


@end

@implementation SnatchSearchViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    //取消
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 50, 50);
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.textColor = [UIColor whiteColor];
    [cancelBtn addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = cancelBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    //    setHeight = setHeight + NVARBAR_HIGHT;
    UIImageView *seBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, setHeight + 5, iPhoneWidth - 120, 35)];
    seBgImgView.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:seBgImgView];
    [seBgImgView setImage:[UIImage imageNamed:@"search_bg.png"]];
    
    //搜索框
    _snatchSearchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(60, setHeight, iPhoneWidth - 120, 45)];
    self.snatchSearchBar.placeholder = @"搜索";
    self.snatchSearchBar.backgroundColor =[UIColor clearColor];
    [self.snatchSearchBar setSearchBarBackGround:[UIImage imageNamed:@"search_bg.png"]];
    [self.snatchSearchBar setSearchBarLeftIcon:[UIImage imageNamed:@"search.png"]];
    
    self.snatchSearchBar.delegate = self;
    [self.snatchSearchBar setContentMode:UIViewContentModeCenter];
    [self.view addSubview:_snatchSearchBar];

    
    setHeight = setHeight + NVARBAR_HIGHT;
    _listDataArr = [NSMutableArray array];
    _page = 1;
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = NO;
    [self.view addSubview:_conTabView];
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    _page = 1;
    
    [self reqGetConList:_page];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    
}


#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    [self reqGetConList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetConList:_page];
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
//    SnatchHomeListNode *lnode = [_listDataArr objectAtIndex:indexPath.row];
//    
//    SnatchDetailsViewController *detailsViewController = [[SnatchDetailsViewController alloc]init];
//
//    detailsViewController.goodID = lnode.gid;
//    [self.navigationController pushViewController:detailsViewController animated:YES];
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
    static NSString *identifier = @"SnatchClassifyListCell";
    SnatchClassifyListCell *cell = (SnatchClassifyListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[SnatchClassifyListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.delegate = self;
    
    SnatchHomeListNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.node = hnode;
    return cell;
    
}


//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //        [self reqDeleteBank:indexPath.row];
    }
}
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{
    
}

//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
}

#pragma mark -
#pragma mark ======searchBar delegate=====
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
    //    [_conTabView.table  reloadData];
    [searchBar resignFirstResponder];
    _page = 1;
    [self reqGetConList:_page];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText is %@",searchText);
    if (searchBar.text.length <= 0) {
        
        [self showProgressWithString:@"请输入搜索内容" hiddenAfterDelay:1];
        return;
    }
}

- (void)showDetail:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    
    SnatchDetailsViewController *snatchDetailsViewController = [[SnatchDetailsViewController alloc] init];
    snatchDetailsViewController.goodID = [NSString stringWithFormat:@"%ld",(long)tag];
    
    [self.navigationController pushViewController:snatchDetailsViewController animated:YES];
    
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:取消
- (void)cancelPressed{
    [_snatchSearchBar resignFirstResponder];
  
}

//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_snatchSearchBar resignFirstResponder];
}

//TODO:加入购物车
- (void)addCart:(id)sender{
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        LoginViewController *loginv = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginv animated:YES];
        return;
    }
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CART_ADD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)tag] forKey:@"gid"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

#pragma mark 网络请求
//TODO:获取列表
- (void)reqGetConList:(NSInteger)page{
    if (_snatchSearchBar.text.length <= 0) {
        
        [self showProgressWithString:@"请输入搜索内容" hiddenAfterDelay:1];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_HOME_LIST] forKey:REQ_CODE];
    [dict setObject:_snatchSearchBar.text forKey:@"keywords"];
    [dict setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"p"];

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
        switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
                // 列表
            case REQ_SNATCH_HOME_LIST:
            {
                NSInteger pages = [[resultDict objectForKey:RESP_PAGENUM] integerValue];//获得页数
                NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
                if (arr.count == 0){
                    _noImgView.hidden = NO;
                    _conTabView.hidden = YES;
                    
                    //                isHaveData = NO;
                }else{
                    _noImgView.hidden = YES;
                    //                isHaveData = YES;
                    _conTabView.hidden = NO;
                }
                if (_page == 1) {
                    
                    [self.listDataArr removeAllObjects];
                    self.listDataArr = [NSMutableArray arrayWithArray:arr];
                    [_conTabView.table scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
                    
                }else{
                    
                    [self.listDataArr addObjectsFromArray:[resultDict objectForKey:RESP_CONTENT]];
                    
                    
                }
                [self.conTabView doneLoadingTableViewData];
                _conTabView.dataArray = self.listDataArr;
                [_conTabView.table reloadData];
                
                if (pages > _page) {
                    _conTabView.hasMoreData  = YES;
                    [self doneLoadMoreTableViewData:_conTabView];
                    
                }else{
                    _conTabView.hasMoreData  = NO;
                    
                }
            }
                break;
                // 添加成功
            case REQ_SNATCH_CART_ADD:{
                [self showProgressWithString:@"添加购物车成功" hiddenAfterDelay:1];
                
            }
                break;
            default:
                break;
        }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    [self.progressView hide:YES];
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
        switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
                // 列表
            case REQ_SNATCH_HOME_LIST:        {
                [self.conTabView doneLoadingTableViewData];
                
            }
                break;
                // 添加失败
            case REQ_SNATCH_CART_ADD:{
                
            }
                break;
            default:
                break;
        }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}
@end
