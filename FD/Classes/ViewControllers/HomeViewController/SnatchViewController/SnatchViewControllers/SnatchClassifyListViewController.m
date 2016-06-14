//
//  MyConViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SnatchClassifyListViewController.h"
#import "SnatchHomeListNode.h"
#import "SnatchDetailsViewController.h"
#import "LoginViewController.h"
#import "ShoppingCartViewController.h"


#define CELL_HIGHT         140  // 底部高度

@interface SnatchClassifyListViewController ()


@end

@implementation SnatchClassifyListViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"抽疯";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}

//TODO:获取数据
- (void)setGetClassifyId:(NSString *)getClassifyId{
    if (_getClassifyId == getClassifyId) {
        return;
    }
    _getClassifyId = getClassifyId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    _listDataArr = [NSMutableArray array];
    _page = 1;
    isFirstIn = YES;

    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
//     _conTabView.canMove = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    _page = 1;
    
    _cartBtn.hidden = NO;

    [self reqGetClassList:_page];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

//TODO:显示购物车浮标
- (void)loadAvatarInKeyWindow:(NSString *)numStr {
    if (_cartBtn) {
        _cartBtn.numLab.text = numStr;
        return;
    }
    _cartBtn = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(iPhoneWidth - 50, iPhoneHeight - 50, 50, 50)];
    _cartBtn.numLab.text = numStr;
    [_cartBtn setTapBlock:^(RCDraggableButton *avatar) {
        //        NSLog(@"\n\tAvatar in keyWindow ===  Tap!!! ===");
        [self toshop];
        
    }];
    
    [_cartBtn setDragDoneBlock:^(RCDraggableButton *avatar) {
        //        NSLog(@"\n\tAvatar in keyWindow === DragDone!!! ===");
        //More todo here.
        
    }];
    
}

//TODO:进入购物车
- (void)toshop{
    
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        LoginViewController *loginv = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginv animated:YES];
    }else{
        ShoppingCartViewController *shoppingCartViewController = [[ShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shoppingCartViewController animated:YES];
    }
   
}

#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    [self reqGetClassList:_page];
}

-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetClassList:_page];
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
    SnatchHomeListNode*lnode = [_listDataArr objectAtIndex:indexPath.row];
    SnatchDetailsViewController *detailsViewController = [[SnatchDetailsViewController alloc] init];
    detailsViewController.goodID = lnode.Hid;
    [self.navigationController pushViewController:detailsViewController animated:YES];
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
#pragma mark ============ 响应事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)reqGetClassList:(NSInteger)page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_HOME_LIST] forKey:REQ_CODE];
    [dict setObject:_getClassifyId forKey:@"cid"];
    [dict setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"p"];

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:获取购物车数量
- (void)reqCartNum{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CART_COUNT] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
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
                
                NSInteger next = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数
                NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
                if (arr.count == 0){
                    _noImgView.hidden = NO;
                }else{
                    _noImgView.hidden = YES;
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
                
                if (next > 0) {
                    _conTabView.hasMoreData  = YES;
                    [self doneLoadMoreTableViewData:_conTabView];
                    
                }else{
                    _conTabView.hasMoreData  = NO;
                    
                }
                
                if (isFirstIn) {
                    [self reqCartNum];
                    
                }
            }
                break;
                // 添加成功
            case REQ_SNATCH_CART_ADD:{
                [self showProgressWithString:@"添加购物车成功" hiddenAfterDelay:1];
                [self reqCartNum];

            }
                break;
                // 获取购物车数量
            case REQ_SNATCH_CART_COUNT:{
                isFirstIn = NO;
                NSDictionary *infoD = [resultDict objectForKey:RESP_CONTENT];
                NSString *countS = [infoD objectForKey:@"count"];
                [self loadAvatarInKeyWindow:countS];
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
                if (isFirstIn) {
                    [self reqCartNum];
                    
                }
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


//TODO:进入界面隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    if (!isFirstIn) {
        [self reqCartNum];
        _cartBtn.hidden = NO;

    }
    [super viewWillAppear:animated];
    
}

//TODO:离开页面删除界面
- (void)viewWillDisappear:(BOOL)animated{
    _cartBtn.hidden = YES;
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    _cartBtn.hidden = YES;
    [super viewDidDisappear:animated];
}

@end
