//
//  ShopViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ShopViewController.h"
#import "HTHorizontalSelectionList.h"
#import "GoodsListCell.h"
#import "GoodsListNode.h"
#import "GoodsDetailViewController.h"
#import "ShopSearchViewController.h"
#import "CateNode.h"

#define CELL_HIGHT     120

@interface ShopViewController ()

@end

@implementation ShopViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"随心兑";
  
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 50);
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor redColor];
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
    //    [comBtn setImage:[UIImage imageNamed:@"Public_Con.png"] forState:UIControlStateNormal];    comBtn.backgroundColor = [UIColor clearColor];
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
//    [screenBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    screenBtn.backgroundColor = [UIColor clearColor];
    [screenBtn addTarget:self action:@selector(screenAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = screenBtn;
    
}
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
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    isSarch = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFinished) name:SEARCH_GOODS_SUCCESS object:nil];

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    isFirstL = YES;
    UIImageView *hhImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 45)];
    hhImgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hhImgView];
    
 
    _selectBtnScrollView = [[GoodsBtnScrollView alloc] init];
    _selectBtnScrollView.frame = CGRectMake(0, setHeight, iPhoneWidth -  22 , 44);
    _selectBtnScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_selectBtnScrollView];
    _selectBtnScrollView.btnDelegate = self;
    
    UIImageView *ddImgView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, setHeight+ 44, iPhoneWidth, 1)];
    ddImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ddImgView];
    ddImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    
    UIImageView *yyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth - 30, setHeight, 23, 45)];
    yyImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:yyImgView];
    [yyImgView setImage:[UIImage imageNamed:@"Public_Rightyy.png"]];
    
    setHeight = setHeight + 45;

    noSelect = 0;
    noSelecttag = 0;
    _listDataArr = [NSMutableArray array];
    _cateDataArr = [NSMutableArray array];
    
    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canMove = YES;
    _conTabView.canDelete = NO;
    _conTabView.backgroundColor = [UIColor clearColor];
    _conTabView.table.showsVerticalScrollIndicator = NO;

    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
//    // 底部选择bar
//    _shopTabarView = [[ShopTabarView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - 60 , iPhoneWidth, 60)];
//    _shopTabarView.backgroundColor = [UIColor clearColor];
//    _shopTabarView.delegate = self;
//    [self.view addSubview:_shopTabarView];
    
    isLoading = NO;
    
    headNum = 0;
    footNum = 0;
    _page = 1;
    _firstStr = @"";
    
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
    [dict setObject:[NSNumber numberWithInt:REQ_GOODSBUY_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)headNum] forKey:@"cid"];
//    [dict setObject:@"5" forKey:@"cid"];
    [dict setObject:_firstStr forKey:@"bond"];
    if (isSarch) {
        NSString *keyword = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_GOODS_KEY];
        [dict setObject:keyword forKey:@"search"];
        
    }
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"p"];
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
    //    [self reqShopList:_page];
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
    GoodsListNode *lnode =  [_listDataArr objectAtIndex:indexPath.section];

    GoodsDetailViewController *detailViewController = [[GoodsDetailViewController alloc] init];
    detailViewController.goodID = lnode.Gid;
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

    static NSString *identifier = @"GoodsListCell";
    GoodsListCell *cell = (GoodsListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[GoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
     
    GoodsListNode *node =  [_listDataArr objectAtIndex:indexPath.section];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    

    cell.node = node;
    
   
    return cell;
}

//TODO:是否超过滑动高度 隐藏
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{
    
}

//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
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
        if (noSelecttag <_selectBtnScrollView.nameArray.count-1 ) {
            noSelecttag ++;
            CateNode *node = [_selectBtnScrollView.nameArray objectAtIndex:noSelecttag];
            noSelect = [node.Cid integerValue];
        }else{
            return;
        }
    }
    else {
        //        NSLog(@"向右滑动====");
        if (noSelecttag > 0 ) {
            noSelecttag --;
            CateNode *node = [_selectBtnScrollView.nameArray objectAtIndex:noSelecttag];
            noSelect = [node.Cid integerValue];
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
    headNum = btn.tag - 1 ;
    if (noSelect != btn.tag - 1) {
        noSelect = btn.tag - 1;
    }
    _page = 1;
    [self reqHttpBuyList];
    
    
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


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

    [super viewWillAppear:animated];
    
}

//TODO:综合排序
- (void)allAction{
    footNum = 0;
    _page = 1;
    [self reqHttpBuyList];
}

//TODO:最新上线
- (void)newlAction{
    footNum = 1;
    _page = 1;
    [self reqHttpBuyList];
}

//TODO:奖励最多
- (void)awardAction{
    footNum = 2;
    _page = 1;
    [self reqHttpBuyList];
}
//TODO:时间最长
- (void)timeAction{
    footNum = 3;
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
    _instructionsView.insInt = 1;

    _instructionsView.backgroundColor = [UIColor clearColor];
    [_instructionsView showInView:self.view];
}

//TODO:搜索
- (void)searchAction{
    ShopSearchViewController *shopSearchViewController = [[ShopSearchViewController alloc] init];
    [self.navigationController pushViewController:shopSearchViewController animated:YES];
}

//TODO:筛选
- (void)screenAction{
    _screenbgHiddenBtn.hidden = NO;

    if (_screenGoodsView) {
        [_screenGoodsView removeFromSuperview];
        _screenGoodsView = nil;
    }
    _screenGoodsView = [[ScreenGoodsView alloc]  initWithFrame:CGRectMake(0, 70, iPhoneWidth, iPhoneHeight)];
    _screenGoodsView.backgroundColor = [UIColor clearColor];
    _screenGoodsView.delegate = self;
    [_screenGoodsView showInView:self.view];

}

//TODO:取消筛选
- (void)cancelBuyView{
    _screenbgHiddenBtn.hidden = YES;
    [_screenGoodsView cancelPicker];
    
}

//TODO:确定筛选
- (void)sureBuyView:(NSString *)firstStr{
    _firstStr = firstStr;
    [_screenGoodsView cancelPicker];
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
        case REQ_GOODSBUY_LIST:
        {
            NSInteger next = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            if (arr.count == 0){
                _noImgView.hidden = NO;
            }else{
                _noImgView.hidden = YES;
                
            }
            _cateDataArr = [resultDict objectForKey:RESP_CATE];
            if (isFirstL) {
                _selectBtnScrollView.nameArray = _cateDataArr;
                _selectBtnScrollView.varTag = 1;
                _selectBtnScrollView.nowSelectTag = 0;
                [_selectBtnScrollView initWithNameButtons];
                isFirstL = NO;
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
