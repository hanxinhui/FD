//
//  LayDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "BankListViewController.h"
#import "MyBankListCell.h"
#import "MyBankListNode.h"
#import "AddBankViewController.h"
#import "WithdrawViewController.h"
#import "RechargeableViewController.h"


#define CELL_HIGHT     80

@interface BankListViewController ()


@end

@implementation BankListViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"我的银行卡";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
//    //添加
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addBtn.frame = CGRectMake(0, 0, 50, 50);
////    [addBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
//    addBtn.backgroundColor = [UIColor clearColor];
//    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
//    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [addBtn addTarget:self action:@selector(addBtnPressed) forControlEvents:UIControlEventTouchUpInside];
//    self.rightBtn = addBtn;
//    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reqGetList) name:BANKLIST_RELOAD object:nil];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    _listDataArr = [NSMutableArray array];
    
    _page = 1;

    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - 60)];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];

    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    // 添加
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, iPhoneHeight - 60, 100,  60)];
    addBtn.backgroundColor = UIColorWithRGB(252, 132, 37, 1);
    //    [_addBtn setImage:[UIImage imageNamed:@"myLogin_loginBg.png"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addPressed) forControlEvents:UIControlEventTouchUpInside];
    //    [_addBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    addBtn.titleLabel.font = defaultFontSize(13);
    [addBtn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    addBtn.frame = CGRectMake(0, iPhoneHeight - 50 , iPhoneWidth, 50);
    
    [self.view addSubview:addBtn];
    UILabel *alab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 50)];
    alab.backgroundColor = [UIColor clearColor];
    alab.textAlignment = NSTextAlignmentCenter;
    alab.textColor = [UIColor whiteColor];
    [addBtn addSubview:alab];
    alab.font = defaultFontSize(15);
    alab.text = @"添加";

    [self reqGetList];
    
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
    [self reqGetList];
    //    [self reqShopList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetList];
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
    if (_bankStyle == BankWithGet) {
        WithdrawViewController *bankV = [[WithdrawViewController alloc] init];
        MyBankListNode *bnode = [_listDataArr objectAtIndex:indexPath.section];
        bankV.bankNode = bnode;
        [self.navigationController pushViewController:bankV animated:YES];
    }
    if (_bankStyle == BankWithPay){
        RechargeableViewController *controller = [[RechargeableViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
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
    static NSString *identifier = @"MyBankListCell";
    MyBankListCell *cell = (MyBankListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[MyBankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    MyBankListNode *node =  [_listDataArr objectAtIndex:indexPath.section];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.node = node;
    return cell;
    
}


//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self reqDeleteBank:indexPath.row];
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

//TODO:添加
- (void)addPressed{
    if (_listDataArr.count == 5) {
        [self showProgressWithString:@"最多绑定5张银行卡" hiddenAfterDelay:2];
        return;
    }
    
   
    AddBankViewController *bankV = [[AddBankViewController alloc] init];
    [self.navigationController pushViewController:bankV animated:YES];
    
}

#pragma mark 网络请求
//TODO:获取列表
- (void)reqGetList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYBANKCARD_LIST] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:删除数据
- (void)reqDeleteBank:(NSInteger )row{
    DFrow = row;
    MyBankListNode *node = [_listDataArr objectAtIndex:row];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYBANKCARD_DELETE] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:node.Bid forKey:@"id"];
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
            //
        case REQ_MYBANKCARD_LIST:
        {
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            if (arr.count == 0){
//                [self showProgressWithString:@"暂无数据" hiddenAfterDelay:1];
                _noImgView.hidden = NO;

//                return;
            }else{
                _noImgView.hidden = YES;

            }

            [self.listDataArr removeAllObjects];
            self.listDataArr = [NSMutableArray arrayWithArray:arr];

            _conTabView.dataArray = self.listDataArr;
            [_conTabView.table reloadData];

            
        }
            break;
            // 删除
        case REQ_MYBANKCARD_DELETE:{
            [self showProgressWithString:@"删除成功" hiddenAfterDelay:1];

            [_listDataArr removeObjectAtIndex:DFrow];
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
            //
        case REQ_MYBANKCARD_LIST:
        case REQ_MYBANKCARD_DELETE:{
            [self showProgressWithString:@"请求失败" hiddenAfterDelay:1];
        }
            break;
        
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BANKLIST_RELOAD object:nil];
    
}


@end
