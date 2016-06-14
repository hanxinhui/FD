//
//  SnatchViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SnatchViewController.h"
#import "SnatchHomeCell.h"
#import "HomeNode.h"
#import "SnatchAdsNode.h"
#import "SnatchClassifyViewController.h"
#import "SnatchQuestionViewController.h"
#import "LoginViewController.h"
#import "SnatchDetailsViewController.h"
#import "ShoppingCartViewController.h"
#import "SnatchSearchViewController.h"
#import "CountersignViewController.h"
#import "ShowMyViewController.h"

#define CELL_HIGHT     235

#define TAG_CLASSIFY    100001  // 分类
#define TAG_COMMAND     100002  // 口令夺宝
#define TAG_SHOW        100003  // 晒单
#define TAG_QUESTION    100004  // 常见问题


@interface SnatchViewController ()<HYSegmentedControlDelegate>

@property (strong, nonatomic)HYSegmentedControl *segmentedControl;



@end

@implementation SnatchViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"抽疯";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    //搜索
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 50, 50);
    [searchBtn setImage:[UIImage imageNamed:@"Public_Search.png"] forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = searchBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    _adsDataArr = [NSMutableArray array];
    _listDataArr = [NSMutableArray array];
    
    isFirstIn = YES;
    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
//    _conTabView.canMove = YES;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
    setHeight = 0;
    
    isLoading = NO;

    // 头部View
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 100)];
    _headView.backgroundColor = [UIColor clearColor];
    
    setHeight = self.view.frame.size.width/16 * 6 + setHeight + 10;

    _page = 1;
    nowSel = 1;

    [self setTheAdViews];// 设置开机广告
    float setW = iPhoneWidth / 4;
    // 分类
    [self setTheImg:CGRectMake((iPhoneWidth / 4 - 50)/ 2, setHeight, 50, 50) imgStr:@"Snatch_Home_Classify.png" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(0, setHeight + 50, setW, 25) textColor:[UIColor blackColor] labText:@"分类" setFont:14 setCen:YES];
    [self setTheBtn:CGRectMake(0, setHeight, setW, 75) btnTag:TAG_CLASSIFY imgStr:nil];
    
    // 口令夺宝
    [self setTheImg:CGRectMake((iPhoneWidth / 4 - 50)/ 2 + setW, setHeight, 50, 50) imgStr:@"Snatch_Home_Command.png" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(setW, setHeight + 50, setW, 25) textColor:[UIColor blackColor] labText:@"暗号抽疯" setFont:14 setCen:YES];
    [self setTheBtn:CGRectMake(setW, setHeight, setW, 75) btnTag:TAG_COMMAND imgStr:nil];

    // 晒单
    [self setTheImg:CGRectMake((iPhoneWidth / 4 - 50)/ 2 + setW*2, setHeight, 50, 50) imgStr:@"Snatch_Home_Show.png" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(setW*2, setHeight + 50, setW, 25) textColor:[UIColor blackColor] labText:@"晒单" setFont:14 setCen:YES];
    [self setTheBtn:CGRectMake(setW*2, setHeight, setW, 75) btnTag:TAG_SHOW imgStr:nil];
    
    // 常见问题
    [self setTheImg:CGRectMake((iPhoneWidth / 4 - 50)/ 2 + setW*3, setHeight, 50, 50) imgStr:@"Snatch_Home_Question.png" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(setW*3, setHeight + 50, setW, 25) textColor:[UIColor blackColor] labText:@"常见问题" setFont:14 setCen:YES];
    [self setTheBtn:CGRectMake(setW*3, setHeight, setW, 75) btnTag:TAG_QUESTION imgStr:nil];
    
    setHeight = setHeight + 90;
    
    // 选择
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:20 Titles:@[@"人气",@"最新",@"进度",@"人次"] delegate:self];
    self.segmentedControl.frame = CGRectMake(0, setHeight, iPhoneWidth, 40);
    [_headView addSubview:_segmentedControl];
    setHeight = setHeight + 42;
    _headView.frame = CGRectMake(0, 0, iPhoneWidth, setHeight);
    _conTabView.table.tableHeaderView = _headView;
    
    [self setTheAdViews];
  
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
    _cartBtn.backgroundColor = [UIColor clearColor];
    [_cartBtn setTapBlock:^(RCDraggableButton *avatar) {
    [self toshop];

       
    }];


    [_cartBtn setDragDoneBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === DragDone!!! ===");
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


//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [_headView addSubview:btn];
    
    
}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [_headView addSubview:imgView];
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
    [_headView addSubview:lab];
}

#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    
    [self reqHttpList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqHttpList:_page];
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
    NSInteger count;
    count = _listDataArr.count / 2;
    NSInteger yu = _listDataArr.count % 2;
    if (yu == 0) {
        count = count;
    }else{
        count = count + 1;
    }
    return count;

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
    static NSString *identifier = @"SnatchHomeCell";
    SnatchHomeCell *cell = (SnatchHomeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[SnatchHomeCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    SnatchHomeListNode *fnode =  [_listDataArr objectAtIndex:indexPath.section *2];
    cell.delegate = self;
    

    cell.firstGoodsView.node = fnode;
    NSInteger yu = _listDataArr.count % 2;

    if (indexPath.section == _listDataArr.count / 2 && yu == 1) {
        cell.secondGoodsView.hidden = YES;
    }else{
        cell.secondGoodsView.hidden = NO;
        SnatchHomeListNode *snode =  [_listDataArr objectAtIndex:indexPath.section *2 + 1];
        cell.secondGoodsView.node = snode;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor clearColor];
    

    return cell;
}


//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
}
//TODO:滑动高度
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{
    
}

//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
}

#pragma mark -
#pragma mark ============ 响应事件 ============
//TODO:筛选
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    NSLog(@"当前选择  =========   %ld",(long)index);
    nowSel = index ;
    _page = 1;
    [self reqHttpList:_page];
    
    
}

//TODO:选择广告
- (void)loopViewDidSelectedImage:(SnatchAdView *)snatchAdView index:(int)index{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
}

//TODO:加入购物车回调
- (void)addCart:(id)sender{

    [self addCartReq:sender];
}

//TODO:详情
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
    [_cartBtn removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:搜索
- (void)searchPressed{
    SnatchSearchViewController *snatchSearchViewController = [[SnatchSearchViewController alloc] init];
    [self.navigationController pushViewController:snatchSearchViewController animated:YES];
}


//TODO:点击事件
- (void)toBtnPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 分类
        case TAG_CLASSIFY:
        {
            SnatchClassifyViewController *snatchClassifyViewController = [[SnatchClassifyViewController alloc] init];
            snatchClassifyViewController.classifyStyle = ClassifySnatch;

            [self.navigationController pushViewController:snatchClassifyViewController animated:YES];
        }
            break;
            
            // 口令夺宝
        case TAG_COMMAND:{
            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                LoginViewController *loginv = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginv animated:YES];
                return;
            }
            
            CountersignViewController *countersignViewController = [[CountersignViewController alloc] init];
            
            [self.navigationController pushViewController:countersignViewController animated:YES];
        }
            break;
            // 晒单
        case TAG_SHOW:{
            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                LoginViewController *loginv = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginv animated:YES];
                return;
            }
            ShowMyViewController *showMyViewController = [[ShowMyViewController  alloc] init];
            showMyViewController.goodsid = @"0";
            [self.navigationController pushViewController:showMyViewController animated:YES];
            
        }
            break;
            // 常见问题
        case TAG_QUESTION:{
            
            SnatchQuestionViewController *questionViewController = [[SnatchQuestionViewController alloc] init];
            [self.navigationController pushViewController:questionViewController animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark 网络请求
//TODO:获取广告数据
- (void)setTheAdViews{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_HOME_ADS] forKey:REQ_CODE];
    [dict setObject:@"7" forKey:@"pid"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:网络请求 分类列表数据
- (void)reqHttpList:(NSInteger )page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_HOME_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)nowSel] forKey:@"nowSel"];
    [dict setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"p"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:加入购物车请求
- (void)addCartReq:(id)sender{
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
            // 广告
        case REQ_SNATCH_HOME_ADS:
        {
            _adsDataArr = [resultDict objectForKey:RESP_CONTENT];
            if (_adsDataArr.count == 0) {
                [self reqHttpList:_page];

                return;
            }
            float seth = self.view.frame.size.width/16 * 6;
            SnatchAdView *snatchAdView = [[SnatchAdView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, seth) images:_adsDataArr autoPlay:YES delay:3.0];
            snatchAdView.delegate = self;
            [_headView addSubview:snatchAdView];
  
            [self reqHttpList:_page];
        }
            break;
            // 首页列表
        case REQ_SNATCH_HOME_LIST:{
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
            NSString *countS = [infoD objectForKey:@"count"];            [self loadAvatarInKeyWindow:countS];
            
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
            // 广告
        case REQ_SNATCH_HOME_ADS:
        {
            [self reqHttpList:_page];

        }
            break;
            // 首页列表
        case REQ_SNATCH_HOME_LIST:           // 添加成功
        case REQ_SNATCH_CART_ADD:
        {
        
        }
            break;
            // 获得购物车数量失败
        case REQ_SNATCH_CART_COUNT:
        {
            isFirstIn = NO;
            [self loadAvatarInKeyWindow:@"0"];

        }
            break;
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

//TODO:进入界面隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
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

//TODO:
- (void)viewDidDisappear:(BOOL)animated{
    _cartBtn.hidden = YES;
    [super viewDidDisappear:animated];
}


@end
