//
//  WinningRecordViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "WinningRecordViewController.h"

#import "WinningRecordNode.h"
#import "WinningAffirmViewController.h"
#import "AddressViewController.h"


#define CELL_HIGHT         230  // Cell高度

@interface WinningRecordViewController ()


@end

@implementation WinningRecordViewController




//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"中奖记录";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}


//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SETADDRSSS_WINNER_DETAIL object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSureAddress) name:SETADDRSSS_WINNER_DETAIL object:nil];

    self.view.backgroundColor = UIColorWithRGB(246, 246, 246, 1);
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    _listDataArr = [NSMutableArray array];
    _page = 1;
   
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
//    _conTabView.canMove = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];

    [self reqGetRecordList:_page];
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
    [self reqGetRecordList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
   [self reqGetRecordList:_page];
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
    WinningRecordNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];
    if (hnode.status <0 ){
        return;
    }
    WinningAffirmViewController *winningAffirmViewController = [[WinningAffirmViewController alloc] init];
    winningAffirmViewController.winGoods = hnode.wid;
    [self.navigationController pushViewController:winningAffirmViewController animated:YES];
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
    static NSString *identifier = @"WinningRecordCell";
    
    WinningRecordCell *cell = (WinningRecordCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[WinningRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.delegate = self;
   WinningRecordNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];

    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 10, iPhoneWidth, 10)];
    lineImgView.backgroundColor = UIColorWithRGB(247, 247, 247, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.node = hnode;
    cell.sureAddressBtn.tag = indexPath.section;
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
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:获得cell位置
- (void)doAnyPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    WinningRecordNode *hnode =  [_listDataArr objectAtIndex:tag];
   //   hnode.wid;
    switch (hnode.status) {
            // 确认地址
        case 0:
        {
            AddressViewController *addressViewController = [[AddressViewController alloc] init];
            addressViewController.addressStyle = winnerAddress;
            addressViewController.winnerGoodsID = hnode.wid;
            addressViewController.isBuyIn = NO;
            [self.navigationController pushViewController:addressViewController animated:YES];

        }
            break;
            // 确认收货
        case 2:
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_MYWINNER_SURE] forKey:REQ_CODE];
            
            [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
            [dict setObject:hnode.wid forKey:@"id"];
            [self.httpManager sendReqWithDict:dict];
            [self.progressView show:YES];

        }
            break;
            // 晒单
        case 3:
        {
            
        }
            break;
        default:
            break;
    }

}

//TODO:选择送货地址成功
- (void)setSureAddress{
    [self reqGetRecordList:_page];
}


//#pragma mark 网络请求
////TODO:获取详情
- (void)reqGetRecordList:(NSInteger )page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_MYWINNER_LIST] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"p"];
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
            // 中奖纪录
        case REQ_SNATCH_MYWINNER_LIST:
        {
            NSInteger pages = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            if (arr.count == 0){
                
                [self showProgressWithString:@"暂无数据" hiddenAfterDelay:1];
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
        // 确认收货
        case REQ_SNATCH_MYWINNER_SURE:{
            [self showProgressWithString:@"确认成功" hiddenAfterDelay:1];
            [self reqGetRecordList:_page];
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
            // 中奖纪录
        case REQ_SNATCH_MYWINNER_LIST:
        case REQ_SNATCH_MYWINNER_SURE:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}

@end
