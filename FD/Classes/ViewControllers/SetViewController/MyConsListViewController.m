//
//  MyConsListViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MyConsListViewController.h"
#import "BuyListCell.h"
#import "BuylistNode.h"
#import "BuyDetailViewController.h"
#import "GoodsListCell.h"
#import "GoodsListNode.h"
#import "GoodsDetailViewController.h"


#define CELL_HIGHT     120

@interface MyConsListViewController ()<HYSegmentedControlDelegate>
@property (strong, nonatomic)HYSegmentedControl *segmentedControl;


@end

@implementation MyConsListViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"我的关注";
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    _listDataArr = [NSMutableArray array];
    seType = 1;
    _page = 1;
    // 选择
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:20 Titles:@[@"随时赚", @"随心兑"] delegate:self] ;
    self.segmentedControl.frame = CGRectMake(0, setHeight, iPhoneWidth, 40);
    [self.view addSubview:_segmentedControl];
    setHeight = setHeight + 40;

    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}
#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    [self reqGetDetail];
    //    [self reqShopList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetDetail];
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
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    if (seType == 1) {
        BuylistNode *lnode =  [_listDataArr objectAtIndex:indexPath.section];
        BuyDetailViewController *detailViewController = [[BuyDetailViewController alloc] init];
        detailViewController.goodID = lnode.Bid;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }else{
        GoodsListNode *lnode =  [_listDataArr objectAtIndex:indexPath.section];
        GoodsDetailViewController *goodsDetailViewController = [[GoodsDetailViewController alloc] init];
        goodsDetailViewController.goodID = lnode.Gid;
        [self.navigationController pushViewController:goodsDetailViewController animated:YES];
    }
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

    if (seType == 1) {
        static NSString *identifier = @"BuyListCell";
        BuyListCell *cell = (BuyListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        cell = [[BuyListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        if (_listDataArr.count == 0) {
            return cell;
            
        }
        BuylistNode *node =  [_listDataArr objectAtIndex:indexPath.section];
        
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
        lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
        [cell addSubview:lineImgView];
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.node = node;
        return cell;
    }else{
        static NSString *identifier = @"GoodsListCell";
        GoodsListCell *cell = (GoodsListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        cell = [[GoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        if (_listDataArr.count == 0) {
            return cell;

        }
        GoodsListNode *node =  [_listDataArr objectAtIndex:indexPath.section];
    
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
        lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
        [cell addSubview:lineImgView];
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.node = node;
        return cell;
    }
   
    
}


//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
}
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{
    
}

//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
}

#pragma mark ============ 筛选 ============
#pragma  === HYSegmentedControlDelegate ===

- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    _page = 1;
    seType = index+1;
    [_listDataArr removeAllObjects];
    [self reqGetDetail];
    
    
}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetDetail{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    switch (seType) {
        case 1:
            [dict setObject:[NSNumber numberWithInt:REQ_MYCON_LIST_BUY] forKey:REQ_CODE];
            break;
        case 2:
            [dict setObject:[NSNumber numberWithInt:REQ_MYCON_LIST_GOODS] forKey:REQ_CODE];
            break;
        default:
            break;
    }
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)seType] forKey:@"type"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"p"];
    
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
            // 我的关注
        case REQ_MYCON_LIST_BUY:
        case REQ_MYCON_LIST_GOODS:
        {
            NSLog(@"111111111");
            isLoading = YES;
            NSInteger next = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            if (arr.count == 0){
                [self showProgressWithString:@"暂无数据" hiddenAfterDelay:1];
                _noImgView.hidden = NO;
                _conTabView.hidden = YES;
                return;
            }else{
                _noImgView.hidden = YES;
                _conTabView.hidden = NO;

            }
            if (_page == 1) {
                
                [self.listDataArr removeAllObjects];
                self.listDataArr = [NSMutableArray arrayWithArray:arr];
                
            }else{
                
                [self.listDataArr addObjectsFromArray:[resultDict objectForKey:RESP_CONTENT]];
                
                
            }
         
    _conTabView.dataArray = self.listDataArr;

            [_conTabView.table reloadData];
            
            [self.conTabView doneLoadingTableViewData];
            
            if (next > 0) {
                _conTabView.hasMoreData  = YES;
                [self doneLoadMoreTableViewData:_conTabView];
                
            }else{
                _conTabView.hasMoreData  = NO;
                
            }
            
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
            // 我的关注
        case REQ_MYCON_LIST_BUY:
        case REQ_MYCON_LIST_GOODS:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}

//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reqGetDetail];

}

@end
