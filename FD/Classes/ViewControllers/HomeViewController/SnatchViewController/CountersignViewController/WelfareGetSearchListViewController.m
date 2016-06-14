//
//  WelfareGetSearchListViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "WelfareGetSearchListViewController.h"
#import "SnatchClassifyViewController.h"
#import "WelFareGetSearchListCell.h"
#import "WelfareClassifyListViewController.h"
#import "WelFareSearchViewController.h"
#import "SnatchHomeListNode.h"

#define CELL_HIGHT     235

@interface WelfareGetSearchListViewController ()<WelFareGetSearchListCellDelegate>


@end


@implementation WelfareGetSearchListViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    self.dlineImgView.hidden = YES;

    self.titleLable.text = @"选择商品";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    //分类
    UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classBtn.frame = CGRectMake(0, 0, 50, 50);
    classBtn.backgroundColor = [UIColor clearColor];
    [classBtn setTitle:@"分类" forState:UIControlStateNormal];
    [classBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [classBtn addTarget:self action:@selector(classPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = classBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    _listDataArr = [NSMutableArray array];

  //搜索
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(10, setHeight, iPhoneWidth - 20, 40);
    [searchBtn setImage:[UIImage imageNamed:@"Home_search_left.png"] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"Home_Search.png"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:UIColorWithRGB(155, 155, 155, 1) forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];

    
    
    setHeight = setHeight + 45;
    
    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
//    _conTabView.canMove = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    _conTabView.backgroundColor = [UIColor clearColor];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    setHeight = 0;
    

    isLoading = NO;
    _page = 1;

    [self reqHttpList:_page];

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
//    return ;
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
    static NSString *identifier = @"WelFareGetSearchListCell";
   WelFareGetSearchListCell *cell = (WelFareGetSearchListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[WelFareGetSearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    SnatchHomeListNode *fnode =  [_listDataArr objectAtIndex:indexPath.section *2];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.firstGoodsView.node = fnode;
    NSInteger yu = _listDataArr.count % 2;
    cell.firstGoodsView.chooseBtn.tag = indexPath.section *2;
    cell.delegate = self;
    if (indexPath.section == _listDataArr.count / 2 && yu == 1) {
        cell.secondGoodsView.hidden = YES;
    }else{
        cell.secondGoodsView.hidden = NO;
        cell.secondGoodsView.chooseBtn.tag = indexPath.section *2 + 1;

        SnatchHomeListNode *snode =  [_listDataArr objectAtIndex:indexPath.section *2 + 1];
        cell.secondGoodsView.node = snode;
        
    }

    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor clearColor];
    
    //    cell.homeNode = node;
    cell.backgroundColor = [UIColor whiteColor];
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

//TODO:搜索
-(void)searchAction{
    
    WelFareSearchViewController *searchViewController = [[WelFareSearchViewController alloc]init];
     [self.navigationController pushViewController:searchViewController animated:YES];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

//TODO:选择产品
- (void)chooseGoodsPreesd:(NSInteger )tag{
    SnatchHomeListNode *node = [_listDataArr objectAtIndex:tag];
    if (_delegate && [_delegate respondsToSelector:@selector(getGoodsNode:)]){
        [_delegate getGoodsNode:node];
    }
    [self backPressed];
}


//TODO:分类
- (void)classPressed{
    SnatchClassifyViewController *snatchClassifyViewController = [[SnatchClassifyViewController alloc] init];
    snatchClassifyViewController.classifyStyle = ClassifyCountersign;

    [self.navigationController pushViewController:snatchClassifyViewController animated:YES];
}

#pragma mark 网络请求
//TODO:网络请求 分类列表数据
- (void)reqHttpList:(NSInteger )page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_HOME_LIST] forKey:REQ_CODE];
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)nowSel] forKey:@"nowSel"];
    [dict setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"p"];
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
            // 首页列表
        case REQ_SNATCH_HOME_LIST:{
            NSInteger next = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
//            if (arr.count == 0){
//                _noImgView.hidden = NO;
//            }else{
//                _noImgView.hidden = YES;
//                
//            }
            
            
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
            // 详情
        case REQ_SNATCH_HOME_LIST:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}
//
@end
