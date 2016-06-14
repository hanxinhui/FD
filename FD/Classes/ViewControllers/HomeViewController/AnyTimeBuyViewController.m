//
//  AnyTimeBuyViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "AnyTimeBuyViewController.h"
#import "HTHorizontalSelectionList.h"
#import "BuyListCell.h"
#import "BuylistNode.h"
#import "BuyDetailViewController.h"
#import "AnyTimeBuySearchViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

#import "AnyBuyView.h"

#define CELL_HIGHT     120

@interface AnyTimeBuyViewController ()



@end

@implementation AnyTimeBuyViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"随时赚";
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 50);
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);
    CGSize detailSize = [self labelAutoCalculateRectWith:self.titleLable.text FontSize:21 MaxSize:CGSizeMake(MAXFLOAT, 50)];

    // 说明
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 2 + detailSize.width / 2 + 10, setHeight+ 18 , 14, 14)];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView setImage:[UIImage imageNamed:@"Public_Con.png"]];
    [self.view addSubview:imageView];

    UIButton *comBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comBtn.frame = CGRectMake(iPhoneWidth / 2 -  detailSize.width / 2, setHeight, 50 + detailSize.width, 50);
//    [comBtn setImage:[UIImage imageNamed:@"Public_Con.png"] forState:UIControlStateNormal];
    comBtn.backgroundColor = [UIColor clearColor];
    [comBtn addTarget:self action:@selector(comAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:comBtn];
    
    // 搜索
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(iPhoneWidth- 95, setHeight, 50, 50);
    [searchBtn setImage:[UIImage imageNamed:@"Public_Search.png"] forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    // 筛选
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    screenBtn.frame = CGRectMake(0, 0, 50, 50);
    
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    screenBtn.backgroundColor = [UIColor clearColor];
    [screenBtn addTarget:self action:@selector(screenAction) forControlEvents:UIControlEventTouchUpInside];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    self.rightBtn = screenBtn;
    
}

//TODO:计算字符串高度
- (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize

{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
//    [paragraphStyle release];
    
    labelSize.height=ceil(labelSize.height);
    
    labelSize.width=ceil(labelSize.width);
    
    return labelSize;
    
}
//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SEARCH_TASK_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ANYTIMEDO_SCREEN_CANCEL object:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    isSarch = NO;
    isHaveData = YES;
    isUsedYE = NO;
    nowCurrentIndex = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFinished) name:SEARCH_TASK_SUCCESS object:nil];
    // 取消筛选界面通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screebCancelPressed) name:ANYTIMEDO_SCREEN_CANCEL object:nil];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
    setChangeH = 0;
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    UIImageView *hhImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 45)];
    hhImgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hhImgView];
   
    
    _buyTabarView = [[BuyTabarView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth -  22 , 44)];
    _buyTabarView.backgroundColor = [UIColor clearColor];
    _buyTabarView.delegate = self;
    [self.view addSubview:_buyTabarView];

    float setDownH = 50;
    if (iPhoneWidth > 320) {
        setDownH = 50;
    }else{
        setDownH = 45;
    }
   
    
    UIImageView *ddImgView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, setHeight+ 44, iPhoneWidth, 1)];
    ddImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ddImgView];
    ddImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);

    setHeight = setHeight + 45;
    
    noSelect = 0;

    _listDataArr = [NSMutableArray array];
    
    phoneH = setDownH;
    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _conTabView.delegate = self;
    _conTabView.canMove = YES;
    _conTabView.hasReloadView = YES;
    _conTabView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    tableh = iPhoneHeight - setHeight - phoneH;
    _conTabView.table.scrollsToTop = YES;

    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    
    isLoading = NO;
    
    headNum = 0;
    footNum = 0;
    _page = 1;
    _profitStr = @"";
    _cycleStr = @"0";
    
    [self reqHttpBuyList];
    
    // 向左滑动
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGestureRecognizer.delegate = self;
    
    
    
    // 向右滑动
    UISwipeGestureRecognizer *dswipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [self.view addGestureRecognizer:dswipeGestureRecognizer];
    dswipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    dswipeGestureRecognizer.delegate = self;
    
    
    // 隐藏
    _bgHiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    _bgHiddenBtn.backgroundColor = [UIColor blackColor];
    [_bgHiddenBtn addTarget:self action:@selector(toHiddenPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bgHiddenBtn];
  
    _bgHiddenBtn.hidden = YES;
    _bgHiddenBtn.alpha = 0.3;
    
    // 隐藏
    _screenbgHiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    _screenbgHiddenBtn.backgroundColor = [UIColor blackColor];
    [_screenbgHiddenBtn addTarget:self action:@selector(cancelBuyView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_screenbgHiddenBtn];
    _screenbgHiddenBtn.hidden = YES;
    _screenbgHiddenBtn.alpha = 0.3;
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    
    
    
}


//TODO:网络请求 列表数据
- (void)reqHttpBuyList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)headNum] forKey:@"cid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)headNum] forKey:@"cid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"p"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)footNum] forKey:@"sort"];
    [dict setObject:_profitStr forKey:@"profit"];
    [dict setObject:_cycleStr forKey:@"cycle"];
    if (isSarch) {
        NSString *keyword = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_TASK_KEY];
        [dict setObject:keyword forKey:@"search"];

    }
    if (isUsedYE) {
        // 使用余额
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
        [dict setObject:@"1" forKey:@"can"];

    }else{
        [dict setObject:@"0" forKey:@"can"];

    }

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    [self reqHttpBuyList];
    
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqHttpBuyList];
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
    BuylistNode *lnode =  [_listDataArr objectAtIndex:indexPath.section];
    
    BuyDetailViewController *detailViewController = [[BuyDetailViewController alloc] init];
    detailViewController.goodID = lnode.Bid;
    [self.navigationController pushViewController:detailViewController animated:YES];
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
    static NSString *identifier = @"BuyListCell";
    BuyListCell *cell = (BuyListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[BuyListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (_listDataArr.count == 0) {
        return cell;
        
    }
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
    BuylistNode *node;
    if (indexPath.section > _listDataArr.count){
        node =  [_listDataArr objectAtIndex:0];
    }else{
        node =  [_listDataArr objectAtIndex:indexPath.section];

    }
    
    cell.node = node;
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)isBeginMove:(BOOL)isMove{

}

//TODO:是否超过滑动高度 隐藏
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{

   
}

//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
}


#pragma mark ============ 滑动手势 ============
- (void)swipeAction:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        //        NSLog(@"向左滑动====");
        if (noSelect <_selectBtnScrollView.nameArray.count-1 ) {
            noSelect ++;
        }else{
            
            return;
        }
    }
    else {
        //        NSLog(@"向右滑动====");
        if (noSelect > 0 ) {
            noSelect --;
        }else{
            return;
        }
    }
    
    //    NSLog(@"noSelect ==== %ld",noSelect);
    for (UIButton *btn in _selectBtnScrollView.subviews) {
        if (btn.tag - 1 == noSelect) {
            [_selectBtnScrollView selectNameButton:btn];
        }
        
    }
//    [self reqHttpBuyList];
}




#pragma mark ============ 筛选 ============
//TOOD:选择按钮
- (void)selectBtnTag:(id)sender{
    UIButton *btn =  (UIButton *)sender;
    headNum = btn.tag - 1;
    if (noSelect != btn.tag - 1) {
        noSelect = btn.tag - 1;
    }
    _page = 1;
    [self reqHttpBuyList];

    
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
    if (_buyView) {
        [_buyView removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:隐藏
- (void)toHiddenPressed{
    [self cancelInsView];
}

//TODO:隐藏
- (void)cancelInsView{
    _bgHiddenBtn.hidden = YES;
    [_instructionsView cancelPicker];
}

#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

    [super viewWillAppear:animated];
    
}

//TODO:综合排序
- (void)allAction:(UIButton *)Btn{
    footNum = 0;
    _page = 1;
    
    [self click:Btn];
//    [self reqHttpBuyList];
}

-(void)click:(UIButton *)newbtn{
    if (_buyView) {
        [_buyView removeFromSuperview];
    }
    _buyView = [[AnyBuyView alloc]init];
    _buyView.delegate = self;
    _buyView.currentIndex = nowCurrentIndex;
    _buyView.block = ^(AnyBuyView *view,BuylistNode *buylistNode){
        
//        [self reqHttpBuyList];
        NSString *name = [NSString stringWithFormat:@"%@",buylistNode.Mylab];
        name = [name substringToIndex:2];
        [newbtn setTitle:name forState:UIControlStateNormal];

        
        newbtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
       
        
         };
    
    
   [self.view addSubview:_buyView];
}

//TODO:点击综合事件
- (void)selectNowPressed:(NSInteger )nowTag{
    nowCurrentIndex = nowTag;
    footNum = nowTag;
    _page = 1;

    [self reqHttpBuyList];

}

//TODO:保证金
- (void)newlAction:(NSInteger)setTag{
    footNum = setTag;
    _page = 1;
    [self reqHttpBuyList];
}

//TODO:奖励
- (void)awardAction:(NSInteger)setTag{
    footNum = setTag;

    _page = 1;
    [self reqHttpBuyList];
}

//TODO:周期
- (void)timeAction:(NSInteger)setTag{
    footNum = setTag;

    _page = 1;
    [self reqHttpBuyList];
}

//TODO:说明
- (void)comAction{
    _bgHiddenBtn.hidden = NO;


    if (_instructionsView) {
        [_instructionsView removeFromSuperview];
        _instructionsView = nil;
    }
    _instructionsView = [[InstructionsView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    
    _instructionsView.delegate = self;
    _instructionsView.insInt = 0;
    _instructionsView.backgroundColor = [UIColor clearColor];
    [_instructionsView showInView:self.view];

}

//TODO:搜索
- (void)searchAction{
    AnyTimeBuySearchViewController *searchViewController = [[AnyTimeBuySearchViewController alloc] init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

//TODO:筛选
- (void)screenAction{
    _screenbgHiddenBtn.hidden = NO;

    if (_screenBuyBgView) {
        [_screenBuyBgView removeFromSuperview];
        _screenBuyBgView = nil;
    }
    _screenBuyBgView = [[ScreenBuyBgView alloc]  initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    _screenBuyBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_screenBuyBgView];
    
    if (_screenBuyView) {
        [_screenBuyView removeFromSuperview];
        _screenBuyView = nil;
    }
    _screenBuyView = [[ScreenBuyView alloc]  initWithFrame:CGRectMake(0, 70, iPhoneWidth, iPhoneHeight)];
    _screenBuyView.backgroundColor = [UIColor clearColor];
    _screenBuyView.delegate = self;
    
    [_screenBuyView showInView:self.view];


}
//TODO:取消筛选
- (void)cancelBuyView{
    _screenbgHiddenBtn.hidden = YES;

    isUsedYE = NO;
    [_screenBuyView cancelPicker];
 
    [self reqHttpBuyList];

}

//TODO:取消筛选
- (void)screebCancelPressed{
    _screenBuyBgView.hidden = YES;

}
//TODO:判读是否登陆
- (void)isCanpayYue{
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        app.isInfo = NO;
        [_screenBuyView.delSwitch setOn:NO];
        _screenBuyView.isOpen = NO;
        LoginViewController *loginview = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginview animated:YES];
        return;
    }
    [_screenBuyView.delSwitch setOn:YES];
    _screenBuyView.isOpen = YES;
}

//TODO:确定筛选
- (void)sureBuyView:(NSString *)profit cycle:(NSString *)cycle isPayYE:(BOOL)ispay {
    _profitStr = profit;
    _cycleStr = cycle;
    
    isUsedYE = ispay;
        
    [_screenBuyView cancelPicker];
    _screenbgHiddenBtn.hidden = YES;

    [self reqHttpBuyList];
}

#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 列表
        case REQ_ANYTIMEBUY_LIST:
        {
            
            NSInteger next = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            if (arr.count == 0){
                _noImgView.hidden = NO;
                isHaveData = NO;
            }else{
                _noImgView.hidden = YES;
                isHaveData = YES;

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
        case REQ_ANYTIMEBUY_LIST:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}


//TODO:开始搜索
- (void)searchFinished{
    _page = 1;
    isSarch = YES;
    [self reqHttpBuyList];
}
@end
