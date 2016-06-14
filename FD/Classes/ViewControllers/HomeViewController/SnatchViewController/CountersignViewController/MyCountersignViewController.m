//
//  MyCountersignViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MyCountersignViewController.h"
#import "MyBagListCell.h"
#import "MyBagListNode.h"
#import "MyCountersignDetailViewController.h"

#define CELL_HIGHT         70  // Cell高度


@interface MyCountersignViewController ()


@end

@implementation MyCountersignViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"我的暗号";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    self.dlineImgView.hidden = YES;

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

    self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT + 20;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reqRelaod) name:MYCOUNTERSIGN_RELOAD object:nil];

   
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"我参与的",@"我发起的",nil];
   //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(30.0, setHeight, iPhoneWidth - 60, 40.0);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    segmentedControl.tintColor = UIColorWithRGB(238, 95, 80, 1);
    //有基本四种样式
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
    [self.view addSubview:segmentedControl];
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法

    setHeight = setHeight + 45;

    
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
    
    _headView = [[MyBagHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 190)];
    _headView.backgroundColor = [UIColor clearColor];

    self.conTabView.table.tableHeaderView = _headView;

    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_noImgView];
    _noImgView.hidden = NO;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    _page = 1;
    nowSelect = 0;
    [self reqGetList:_page];
    
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
    [self reqGetList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetList:_page];
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
  MyBagListNode *lnode = [_listDataArr objectAtIndex:indexPath.section];
    MyCountersignDetailViewController *detailsViewController = [[MyCountersignDetailViewController alloc] init];
    detailsViewController.countersignStyle = WelfareCountersign;

    detailsViewController.isKLjoin = NO;
    NSLog(@"indexPath.section  ==== %ld",(long)indexPath.section);
    switch (nowSelect) {
        case 0:
            
            detailsViewController.isMyJoin = YES;

            break;
           case 1:
            detailsViewController.isMyJoin = NO;

            break;
       
            
                default:
            break;
        
    }
    
    switch (lnode.kind) {
            // 福利抢宝
        case 1:
            detailsViewController.countersignStyle = WelfareCountersign;

            break;
            // 群抢宝
        case 2:
            detailsViewController.countersignStyle = GroupCountersign;

            break;
        default:
            break;
    }
    detailsViewController.detailID = lnode.Cid;
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
    static NSString *identifier = @"MyBagListCell";
    
    MyBagListCell *cell = (MyBagListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[MyBagListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    switch (nowSelect) {
        case 0:
            cell.isMyin = YES;
            break;
        case 1:
            cell.isMyin = NO;
            break;
        default:
            break;
    }
    MyBagListNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 0.4);
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

//TODO:分段选择
-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %li", (long)Index);
    _page = 1;
    nowSelect = Index;
    
    switch (Index) {
            // 我参与的
        case 0:{
            
            [self reqGetList:_page];
 
        }
            break;
            // 我发起的
        case 1:{
            [self reqGetList:_page];
  
        }
            break;
        default:
            break;
    }
    
}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetList:(NSInteger  )page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYBAG_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)nowSelect] forKey:@"type"];
    [dict setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"p"];

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:返回刷新界面
- (void)reqRelaod{
    _page = 1;
    [self reqGetList:_page];
}

#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 列表
        case REQ_MYBAG_LIST:
        {
            NSInteger next = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数

//            NSString *avatar = [resultDict objectForKey:@"avatar"] ;//头像
            NSString *price = [resultDict objectForKey:@"price"] ;//价格
            NSString *total = [resultDict objectForKey:@"total"] ;//个数
            
//           [_headView.goodsImgView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];
            [_headView.goodsImgView sd_setImageWithURL:[NSURL URLWithString:[UserDataManager sharedUserDataManager].userData.UAvatar] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];

            
            NSString *newTitle = [NSString stringWithFormat:@"抢到%@个宝贝，价值",total];
            if (nowSelect == 1){
                newTitle = [NSString stringWithFormat:@"发起%@个抢宝，价值",total];
            }
            _headView.titleLab.text = newTitle;
            _headView.titleLab.keyWord = [NSString stringWithFormat:@"%@",total];
            
            NSString *newMoney = [NSString stringWithFormat:@"%@元",price];
            _headView.moneyLab.text = newMoney;
            _headView.moneyLab.keyWord = @"元";

        
            NSArray *arr = [resultDict objectForKey:RESP_LIST];
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
                
                [self.listDataArr addObjectsFromArray:arr];
                
                
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
        case REQ_MYBAG_LIST:        {
            [self.conTabView doneLoadingTableViewData];
            
        }
            break;

        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MYCOUNTERSIGN_RELOAD object:nil];
    
}

@end
