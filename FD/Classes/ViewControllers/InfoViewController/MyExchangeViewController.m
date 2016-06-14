//
//  MyTasksViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MyExchangeViewController.h"
#import "ExchangeDetailViewController.h"

#define CELL_HIGHT     110

@interface MyExchangeViewController ()<HYSegmentedControlDelegate>

@property (strong, nonatomic)HYSegmentedControl *segmentedControl;


@end

@implementation MyExchangeViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"我的兑换";
  
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    // 取消兑换成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeFinished) name:CLOSEEXCHANGE__SUCCESS object:nil];
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    nowSel = 1;
    
    // 选择
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:20 Titles:@[@"随时赚", @"随心兑", @"免费抽"] delegate:self] ;
    self.segmentedControl.frame = CGRectMake(0, setHeight, iPhoneWidth, 40);
//    [self.view addSubview:_segmentedControl];
//    
//    setHeight = setHeight + 40;

    _listDataArr = [NSMutableArray array];
    _page = 1;

    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    [self reqGetGoodsList];

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
    [self reqGetGoodsList];

}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetGoodsList];

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
    MyGoodsListNode *anode =  [_listDataArr objectAtIndex:indexPath.section];

    ExchangeDetailViewController *exchangeDetailViewController = [[ExchangeDetailViewController alloc] init];
    exchangeDetailViewController.goodID = anode.Gid;
    [self.navigationController pushViewController:exchangeDetailViewController animated:YES];
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
    static NSString *identifier = @"MyGoodsListCell";
    MyGoodsListCell *cell = (MyGoodsListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[MyGoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
  
    MyGoodsListNode *node =  [_listDataArr objectAtIndex:indexPath.section];
    
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 0.5);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    
    
    cell.node = node;
    return cell;
}


//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        rowS = indexPath.row;
        MyGoodsListNode *node =  [_listDataArr objectAtIndex:indexPath.section];
        if (node.status > 0) {
            [self showProgressWithString:@"此商品暂不能删除" hiddenAfterDelay:1];
            [_conTabView.table reloadData];
            return;
        }
        
        [self reqDeleteList];
        
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
    NSLog(@"当前选择  =========   %ld",(long)index);
    nowSel = index + 1 ;
    _page = 1;
    [self reqGetGoodsList];

    
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 网络请求
//TODO:获取我的兑换列表
- (void)reqGetGoodsList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYGOODS_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"p"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:删除随心兑列表
- (void)reqDeleteList{
    MyGoodsListNode *node =  [_listDataArr objectAtIndex:rowS];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYGOODS_DELETE] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
//    MyTaskAnyCellNode *node =  [_listDataArr objectAtIndex:rowS];
    
    [dict setObject:node.Gid forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:取消兑换成功
- (void)closeFinished{
    _page = 1;
    [self reqGetGoodsList];
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 我的兑换
        case REQ_MYGOODS_LIST:
        {
            isLoading = YES;
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
            
            
        }
            break;
            // 删除成功
        case REQ_MYGOODS_DELETE:{
            [self showProgressWithString:@"删除成功" hiddenAfterDelay:1];
            [_listDataArr removeObjectAtIndex:rowS];
            [_conTabView.table reloadData];
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
            // 我的兑换
        case REQ_MYGOODS_LIST:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}
//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CLOSEEXCHANGE__SUCCESS object:nil];
    
}
@end
