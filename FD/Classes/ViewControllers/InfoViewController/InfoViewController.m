//
//  InfoViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "InfoViewController.h"
#import "LoginViewController.h"
#import "PropertyListViewController.h"
#import "MyTasksViewController.h"
#import "SetViewController.h"
#import "MyNewsListViewController.h"
#import "MyConsListViewController.h"
#import "MyExchangeViewController.h"
#import "BankListViewController.h"
#import "AppDelegate.h"
#import "MySnatchViewController.h"



@interface InfoViewController ()


@end

@implementation InfoViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.text = [UserDataManager sharedUserDataManager].userData.UPhone;
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);

    //设置
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(0, 0, 50, 50);
    [setBtn setImage:[UIImage imageNamed:@"My_Set.png"] forState:UIControlStateNormal];
    setBtn.backgroundColor = [UIColor clearColor];
    [setBtn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = setBtn;
    
    //消息
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame = CGRectMake(0, 0, 50, 50);
    [msgBtn setImage:[UIImage imageNamed:@"My_News.png"] forState:UIControlStateNormal];
    msgBtn.backgroundColor = [UIColor clearColor];
    [msgBtn addTarget:self action:@selector(msgAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = msgBtn;

    
}
//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_DID_LOG_OUT object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = UIColorWithRGB(239, 239, 239, 1);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutFinished) name:USER_DID_LOG_OUT object:nil];

   

    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight-1, iPhoneWidth, iPhoneHeight - setHeight - TARBAR_HIGHT)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 是否支持滑动最顶端
    _mainScrollView.delegate = self;
    // 是否滚动
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    // 设置indicator风格
//    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
  
    [self.view addSubview:_mainScrollView];
    

    
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _mainScrollView.bounds.size.height, self.view.frame.size.width, _mainScrollView.bounds.size.height)];
        view.delegate = self;
        [_mainScrollView addSubview:view];
        _refreshHeaderView = view;
        
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    setHeight = 0;
    [self setMainViewInit];
    // 设置内容大小
    _mainScrollView.contentSize = CGSizeMake(iPhoneWidth, setHeight);
    
   


    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

//TODO:设置界面
- (void)setMainViewInit{
    // 头背景
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 150) imgStr:@"" bgColor:UIColorWithRGB(25, 125, 218, 0.8)];
    
    setHeight = setHeight + 20;
    
//    // 今日收益
//    [self setTheLab:CGRectMake(0, setHeight, iPhoneWidth , 20) textColor:[UIColor whiteColor] labText:@"今日收益（葫芦币）" setFont:12 setCen:YES];
    
    setScHeight = setHeight;
    [self setTopScrollViewInit];
    
    setHeight = setHeight + 20;
    
//    _todayEarningsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , 100)];
//    _todayEarningsLab.backgroundColor = [UIColor clearColor];
//    _todayEarningsLab.text = [UserDataManager sharedUserDataManager].userData.UtodayIn;
//    _todayEarningsLab.textColor = [UIColor whiteColor];
//    _todayEarningsLab.textAlignment = NSTextAlignmentCenter;
//    _todayEarningsLab.font = [UIFont systemFontOfSize:27];
//    [_topScrollView addSubview:_todayEarningsLab];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, setHeight+100, iPhoneWidth, 280)];
    image.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:image];

    
    setHeight = setHeight + 120;
    
    //    // 总资产
    [self setTheLab:CGRectMake(15, setHeight+20, iPhoneWidth/2, 20) textColor:UIColorWithRGB(122, 123, 123, 1) labText:@"总资产（葫芦币）" setFont:12 setCen:NO];
    

    setHeight = setHeight + 20;
    
    _allMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(19, setHeight+26, iPhoneWidth, 50)];
    _allMoneyLab.backgroundColor = [UIColor whiteColor];
    _allMoneyLab.text = [UserDataManager sharedUserDataManager].userData.Utotal;
    _allMoneyLab.textColor = UIColorWithRGB(237, 96, 85, 1);
    _allMoneyLab.textAlignment = NSTextAlignmentLeft;
    _allMoneyLab.font = [UIFont systemFontOfSize:50];
    [_mainScrollView addSubview:_allMoneyLab];
    
    setHeight = setHeight+100;
    
    UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 1)];
    imageLine.backgroundColor = UIColorWithRGB(212, 212, 212, 0.4);
    [_mainScrollView addSubview:imageLine];
    
    setHeight = setHeight+10;
    
    [self setTheLab:CGRectMake(5, setHeight, iPhoneWidth/2, 30) textColor:UIColorWithRGB(115, 115, 114, 1) labText:@"可提现金额（葫芦币）" setFont:12 setCen:YES];
    
   _outLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight+15, iPhoneWidth/2, 50)];
    _outLab.backgroundColor = [UIColor clearColor];
    _outLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_Free;
    _outLab.textColor = UIColorWithRGB(53, 53, 53, 1);
    _outLab.textAlignment = NSTextAlignmentCenter;
    _outLab.font = [UIFont systemFontOfSize:16];
    [_mainScrollView addSubview:_outLab];

    
    UIImageView *imageLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(iPhoneWidth/2, setHeight-10, 1, 140)];
    imageLine1.backgroundColor = UIColorWithRGB(212, 212, 212, 0.4);
    [_mainScrollView addSubview:imageLine1];

    
    [self setTheLab:CGRectMake(iPhoneWidth/2+5, setHeight, iPhoneWidth/2, 30) textColor:UIColorWithRGB(115, 115, 114, 1) labText:@"任务体验金（葫芦币）" setFont:12 setCen:YES];
    
    _freezeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth/2, setHeight+15, iPhoneWidth/2, 50)];
    _freezeLab.backgroundColor = [UIColor clearColor];
     _freezeLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_Freeze;
     _freezeLab.textColor = UIColorWithRGB(53, 53, 53, 1);
     _freezeLab.textAlignment = NSTextAlignmentCenter;
     _freezeLab.font = [UIFont systemFontOfSize:16];
    [_mainScrollView addSubview: _freezeLab];
    
    UIImageView *imageLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, setHeight+60, iPhoneWidth, 1)];
    imageLine2.backgroundColor = UIColorWithRGB(212, 212, 212, 0.4);
    [_mainScrollView addSubview:imageLine2];
    
     [self setTheLab:CGRectMake(5, setHeight+70, iPhoneWidth/2, 30) textColor:UIColorWithRGB(115, 115, 114, 1) labText:@"任务保证金（葫芦币）" setFont:12 setCen:YES];
    
    
    _taskLab= [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight+85, iPhoneWidth/2, 50)];
    _taskLab.backgroundColor = [UIColor clearColor];
    _taskLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_Bail;
    _taskLab.textColor = UIColorWithRGB(53, 53, 53, 1);
    _taskLab.textAlignment = NSTextAlignmentCenter;
    _taskLab.font = [UIFont systemFontOfSize:16];
    [_mainScrollView addSubview: _taskLab];

    [self setTheLab:CGRectMake(iPhoneWidth/2+5, setHeight+70, iPhoneWidth/2, 30) textColor:UIColorWithRGB(115, 115, 114, 1) labText:@"可用保证金（葫芦币）" setFont:12 setCen:YES];
    
    _usableLab= [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth/2, setHeight+85, iPhoneWidth/2, 50)];
    _usableLab.backgroundColor = [UIColor clearColor];
    _usableLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_FreeBail;
    _usableLab.textColor = UIColorWithRGB(53, 53, 53, 1);
    _usableLab.textAlignment = NSTextAlignmentCenter;
    _usableLab.font = [UIFont systemFontOfSize:16];
    [_mainScrollView addSubview: _usableLab];

    UIImageView *imageLine3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, setHeight+130, iPhoneWidth, 1)];
    imageLine3.backgroundColor = UIColorWithRGB(212, 212, 212, 0.4);
    [_mainScrollView addSubview:imageLine3];
    
    setHeight = setHeight + 130;

    
    [self setBtnViewInit];// 功能界面
}
//TODO:设置头部滚动界面
- (void)setTopScrollViewInit{
    _pageCount=4;
    if (_topScrollView) {
        [_topScrollView removeFromSuperview];
        
    }
    _topScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,90)];
    _topScrollView.contentSize=CGSizeMake(self.view.frame.size.width*_pageCount, 0);
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.showsHorizontalScrollIndicator=FALSE;
    _topScrollView.showsVerticalScrollIndicator=FALSE;
    _topScrollView.delegate = self;
    _topScrollView.pagingEnabled = YES;
    _topScrollView.bounces=NO;
    _topScrollView.userInteractionEnabled = YES;
    
    [_mainScrollView addSubview:_topScrollView];
    
    for (int j=0; j<_pageCount; j++) {
        UIImageView *image2=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*j,0 , self.view.frame.size.width, _topScrollView.frame.size.height)];
        
        [_topScrollView addSubview:image2];
        
        //shouyiArr元素个数必须和 _pageCount 保持一致
        NSArray *shouyiArr = [NSArray arrayWithObjects:@"今日收益（葫芦币）",@"本周收益（葫芦币）",@"本月收益（葫芦币）",@"累计收益（葫芦币）", nil];
        UILabel *shouyiLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*j, setScHeight, iPhoneWidth , 20)];
        shouyiLabel.text = @"今日收益（葫芦币）";
        shouyiLabel.text = [shouyiArr objectAtIndex:j];
        shouyiLabel.textColor = [UIColor whiteColor];
        shouyiLabel.textAlignment = NSTextAlignmentCenter;
        shouyiLabel.font = [UIFont systemFontOfSize:17.0];
        [_topScrollView addSubview:shouyiLabel];
        
        NSString *moneyStr1 = [UserDataManager sharedUserDataManager].userData.UtodayIn;
        NSString *moneyStr2 = [UserDataManager sharedUserDataManager].userData.UweekIn;
        NSString *moneyStr3 = [UserDataManager sharedUserDataManager].userData.UmouthIn;
        NSString *moneyStr4 = [UserDataManager sharedUserDataManager].userData.UtotalIn;
        
        UILabel *moneyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*j, setScHeight, iPhoneWidth, 100)];
        moneyLabel1.backgroundColor  = [UIColor clearColor];
        moneyLabel1.font = [UIFont systemFontOfSize:27.0];
        moneyLabel1.textAlignment = NSTextAlignmentCenter;
        NSArray *moneyArr = [NSArray arrayWithObjects:moneyStr1,moneyStr2,moneyStr3,moneyStr4, nil];
        
        NSMutableAttributedString *mutibleStr1 = [[NSMutableAttributedString alloc] initWithString:[moneyArr objectAtIndex:j]];
        [mutibleStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(mutibleStr1.length-1, 1)];
        moneyLabel1.attributedText = mutibleStr1;
        moneyLabel1.textColor = [UIColor whiteColor];
        [_topScrollView addSubview:moneyLabel1];
    }
    
    if (_headPangeControl) {
        [_headPangeControl removeFromSuperview];
    }
    _headPangeControl = [[UIPageControl alloc]initWithFrame:CGRectMake(iPhoneWidth/2-80, 100, 160, 20)];
    _headPangeControl.numberOfPages = 4;
    _headPangeControl.currentPage = 0;
    _headPangeControl.userInteractionEnabled = NO;
    [_mainScrollView addSubview:_headPangeControl];
    
    if (_timermao) {
        [_timermao invalidate];
        
    }
    _timermao=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(speed) userInfo:nil repeats:YES];
}
//TODO:功能界面
- (void)setBtnViewInit{
    setHeight = setHeight + 10;

    for (int i = 0 ; i< 5;  i++) {
        [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 55) textColor:[UIColor clearColor] btnText:nil setFont:0 btnTag:1000+i imgStr:@""];
        [self setTheImg:CGRectMake(20, setHeight + 17, 20, 20) imgStr:[NSString stringWithFormat:@"My_Icon%d.png",i+1] bgColor:[UIColor clearColor]];
        NSString *str;
        switch (i) {
            case 0:
                str = @"账户明细";
                break;
            case 1:
                str = @"我的任务";
                break;
            case 2:
                str = @"我的兑换";
                break;
            case 3:
                str = @"我的关注";
                break;
            case 4:
                str = @"我的抽疯";
                break;
                
                
            default:
                break;
        }
        [self setTheLab:CGRectMake(60, setHeight, iPhoneWidth - 80, 55) textColor:UIColorWithRGB(29, 64, 85, 1) labText:str setFont:15 setCen:NO];
        [self setTheImg:CGRectMake(iPhoneWidth - 40, setHeight + 20, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
        setHeight = setHeight + 56;
    }

    setHeight = setHeight + 10;

    for (int i = 5 ; i< 6;  i++) {
        [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 55) textColor:[UIColor clearColor] btnText:nil setFont:0 btnTag:1000+i imgStr:@""];
        [self setTheImg:CGRectMake(20, setHeight + 17, 20, 20) imgStr:[NSString stringWithFormat:@"My_Icon%d.png",i+1] bgColor:[UIColor clearColor]];
        NSString *str;
        switch (i) {
            case 5:
                str = @"银行卡";
                break;
            case 6:
                str = @"抽奖券";
                break;
                
            default:
                break;
        }
        [self setTheLab:CGRectMake(60, setHeight, iPhoneWidth - 80, 55) textColor:UIColorWithRGB(29, 64, 85, 1) labText:str setFont:15 setCen:NO];
        [self setTheImg:CGRectMake(iPhoneWidth - 40, setHeight + 20, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
        setHeight = setHeight + 56;
    }
    

    
}


//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect textColor:(UIColor *)color btnText:(NSString *)text setFont:(float )font btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    UIImageView *yqbtnImage  = [[UIImageView alloc] initWithFrame:rect];
    yqbtnImage.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:yqbtnImage];
    [yqbtnImage setImage:[UIImage imageNamed:@"Public_WBg"]];
//    [btn setBackgroundImage:[UIImage imageNamed:@"Public_WBg"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"Public_Yinying.png"] forState:UIControlStateHighlighted ];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
//    btn.exclusiveTouch = YES;

    [_mainScrollView addSubview:btn];
}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [_mainScrollView addSubview:imgView];
}

//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setCen:(BOOL )cen{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (cen) {
        lab.textAlignment = NSTextAlignmentCenter;

    }else{
        lab.textAlignment = NSTextAlignmentLeft;

    }
    lab.font = [UIFont systemFontOfSize:font];
    [_mainScrollView addSubview:lab];
}

//TODO: 获取网络数据
- (void)getHttpData{
//    _page = 1;
//    [self reqShopList:_page];
    
}

//TODO:获取余额
- (void)reqGetBalance{
    [self reqGetAlltotal];
////    // 获取余额
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInt:REQ_GETBALANCE] forKey:REQ_CODE];
//    
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
//    [self.httpManager sendReqWithDict:dict];
//    [self.progressView show:YES];
}

//TODO:获取总资产
- (void)reqGetAlltotal{
    //
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_INFO_ALLTOTAL] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [self.httpManager sendReqWithDict:dict];
//    [self.progressView show:YES];
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainScrollView];
    
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    if (scrollView == _topScrollView){
        _headPangeControl.currentPage = scrollView.contentOffset.x/self.view.frame.size.width;
        
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    [self reqGetBalance];

    return [NSDate date]; // should return date data source was last changed
    
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:设置界面
- (void)setAction{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    SetViewController *setViewController = [[SetViewController alloc] init];
    [self.navigationController pushViewController:setViewController animated:YES];
}

//TODO:消息界面
- (void)msgAction{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    MyNewsListViewController *myNewsListViewController = [[MyNewsListViewController alloc] init];
    [self.navigationController pushViewController:myNewsListViewController animated:YES];

}


//TODO:点击按钮
- (void)toBtnPressed:(id)sender{

    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 账户明细
        case 1000:
        {
            PropertyListViewController *propertyListViewController = [[PropertyListViewController alloc] init];
            [self.navigationController pushViewController:propertyListViewController animated:YES];
        }
            break;
            // 我的任务
        case 1001:
        {
            MyTasksViewController *myTasksViewController = [[MyTasksViewController alloc] init];
            [self.navigationController pushViewController:myTasksViewController animated:YES];
        }
            break;
            // 我的兑换
        case 1002:
        {
            [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
            
            MyExchangeViewController *myExchangeViewController = [[MyExchangeViewController alloc] init];
            [self.navigationController pushViewController:myExchangeViewController animated:YES];
        }
            break;
            // 我的关注
        case 1003:
        {
            MyConsListViewController *myConsListViewController = [[MyConsListViewController alloc] init];
            [self.navigationController pushViewController:myConsListViewController animated:YES];
 
        }
            break;
            // 我的抢宝
        case 1004:
        {
            MySnatchViewController *controller = [[MySnatchViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            // 银行卡
        case 1005:
        {
            [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
            BankListViewController *controller = [[BankListViewController alloc] init];
            controller.bankStyle = BankWithAdd;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            // 抽奖券
        case 1006:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"即将开通,敬请期待!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];

        }
            break;
            
        default:
            break;
    }
}

//TODO:登出完成
- (void)logoutFinished{
    if (!app.isModifyPoint) {
        [[self rdv_tabBarController] setTheViewController:0];

    }
    
    app.isModifyPoint = NO;

    
}

#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reqGetBalance];

    _allMoneyLab.text = [UserDataManager sharedUserDataManager].userData.Utotal;
    _todayEarningsLab.text = [UserDataManager sharedUserDataManager].userData.UtodayIn;
    _allEarningsLab.text = [UserDataManager sharedUserDataManager].userData.UtotalIn;
    self.titleLable.text = [UserDataManager sharedUserDataManager].userData.UPhone;

    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 获取余额
        case REQ_GETBALANCE:{
            [self.progressView hide:YES];

            NSInteger ttt =[[resultDict objectForKey:RESP_CONTENT] integerValue];
            if (ttt == 0) {
                [UserDataManager sharedUserDataManager].userData.Utotal_Free  = @"0";
            }else{
               [UserDataManager sharedUserDataManager].userData.Utotal_Free  = [resultDict objectForKey:RESP_CONTENT];
            }
//            [UserDataManager sharedUserDataManager].userData.Utotal  = [resultDict objectForKey:RESP_CONTENT];
            _allMoneyLab.text = [UserDataManager sharedUserDataManager].userData.Utotal;
          
          

        }
            break;
            // 获取总资产
        case REQ_INFO_ALLTOTAL:{
            
            _allMoneyLab.text = [UserDataManager sharedUserDataManager].userData.Utotal;
            _outLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_Free;
            _freezeLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_Freeze;
            _taskLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_Bail;
            _usableLab.text = [UserDataManager sharedUserDataManager].userData.Utotal_FreeBail;
            [self setTopScrollViewInit];
        }
            break;
        default:
            break;
    }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
            // 余额
        case REQ_GETBALANCE:{
            [self.progressView hide:YES];

        }
            break;
            // 获取总资产
        case REQ_INFO_ALLTOTAL:{
            
        }
            break;
         
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}


-(void)speed{
    int  width = self.view.frame.size.width;

    if (_topScrollView.contentOffset.x>=width*3) {
        [_topScrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    }else{
        _speed=width;
        [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentOffset.x+_speed, 0) animated:YES];

    }
}




@end
