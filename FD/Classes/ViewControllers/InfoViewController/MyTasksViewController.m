//
//  MyTasksViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MyTasksViewController.h"
#import "MyTasksDetailViewController.h"

#define CELL_HIGHT     120

@interface MyTasksViewController ()<HYSegmentedControlDelegate>

@property (strong, nonatomic)HYSegmentedControl *segmentedControl;


@end

@implementation MyTasksViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"我的任务";
  
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doMytaskSuccess) name:DOMYTASK_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showScoreSuccess) name:ISSHOW_SCORE_SUCCESS object:nil];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    nowSel = 1;
    
    // 选择
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:20 Titles:@[@"今日未完成",@"今日已完成",@"全部"] delegate:self] ;
    self.segmentedControl.frame = CGRectMake(0, setHeight, iPhoneWidth, 40);
    [self.view addSubview:_segmentedControl];
    
    setHeight = setHeight + 40;

    _listDataArr = [NSMutableArray array];
    _page = 1;

    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _conTabView.delegate = self;
    _conTabView.canDelete = NO;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
//    _conTabView.canDelete = NO;
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];

    [self reqBuyList];

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
    [self reqBuyList];

}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqBuyList];

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
    MyTaskAnyCellNode *mnode =  [_listDataArr objectAtIndex:indexPath.section];

    MyTasksDetailViewController *myTasksDetailViewController = [[MyTasksDetailViewController alloc] init];
    myTasksDetailViewController.node = mnode;
    [self.navigationController pushViewController:myTasksDetailViewController animated:YES];
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

    static NSString *identifier = @"MyTaskAnyCell";
    MyTaskAnyCell *cell = (MyTaskAnyCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[MyTaskAnyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    MyTaskAnyCellNode *node =  [_listDataArr objectAtIndex:indexPath.section];
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
//        rowS = indexPath.row;
//        MyTaskAnyCellNode *node =  [_listDataArr objectAtIndex:rowS];
//        if ([node.mission_status integerValue] == 0) {
//            [self showProgressWithString:@"此任务已完成，暂不能终止" hiddenAfterDelay:1];
//            [_conTabView.table reloadData];
//            return;
//        }
//        [self reqDeleteList];
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
    switch (index) {
        case 0:
            nowSel = 1  ;

            break;
        case 1:
            nowSel = 2  ;
            
            break;
        case 2:
            nowSel = 0  ;
            
            break;
        default:
            break;
    }
    _page = 1;
    [self reqBuyList];

    
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 网络请求
//TODO:获取随时赚列表
- (void)reqBuyList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYTASKS_BUY_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)nowSel] forKey:@"status"];

    [dict setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"p"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}
//TODO:我的任务完成
- (void)doMytaskSuccess{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYTASKS_BUY_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)nowSel] forKey:@"status"];
    _page = 1;

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
            // 随时赚列表
        case REQ_MYTASKS_BUY_LIST:
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
          // 删除任务
        case REQ_MYTASKS_BUY_DELETE:{
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
            // 随时赚列表
        case REQ_MYTASKS_BUY_LIST:
            // 删除任务
        case REQ_MYTASKS_BUY_DELETE:
            // 终止任务
        case REQ_MYTASKS_BUY_END:{
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DOMYTASK_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ISSHOW_SCORE_SUCCESS object:nil];

}
//TODO:评分
- (void)showScoreSuccess{
    BOOL isshow = [[NSUserDefaults standardUserDefaults] boolForKey:ISSHOW_SCORE];
    if (isshow) {
        UIAlertView *scoreAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"亲，给个好评呗!爱葫芦，新生代的赚钱神器！" delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"残忍的拒绝",@"赏你5分", nil];
        [scoreAlertView show];
        
    }
    
    
}

#pragma mark -
#pragma mark ============ UIAlertViewDelegate ============
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([str isEqualToString:@"下次再说"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISSHOW_SCORE];
        
    }
    
    if ([str isEqualToString:@"残忍的拒绝"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISSHOW_SCORE];
        
    }
    
    if ([str isEqualToString:@"赏你5分"]) {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:APPSTOREURL]];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ISSHOW_SCORE];
        
    }
    
}
@end
