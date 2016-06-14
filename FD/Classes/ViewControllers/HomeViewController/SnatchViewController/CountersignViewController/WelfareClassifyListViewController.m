//
//  WelfareClassifyListViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "WelfareClassifyListViewController.h"
#import "WelFareGetSearchListCell.h"
#import "SnatchHomeListNode.h"


#define CELL_HIGHT         235 // 底部高度

@interface WelfareClassifyListViewController ()<WelFareGetSearchListCellDelegate>


@end

@implementation WelfareClassifyListViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
   self.titleLable.text = @"分类预览";
    self.dlineImgView.hidden = YES;

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
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
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
    
    if (_listStyle == ClassifyListSearch) {
        self.titleLable.text = _getClassifyId;
    }
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
    //    return _listDataArr.count;
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    SnatchHomeListNode *fnode =  [_listDataArr objectAtIndex:indexPath.section *2];
    cell.delegate = self;
    cell.firstGoodsView.node = fnode;
    cell.firstGoodsView.chooseBtn.tag = indexPath.section *2;
    NSInteger yu = _listDataArr.count % 2;
    
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



#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:选择产品
- (void)chooseGoodsPreesd:(NSInteger )tag{
    SnatchHomeListNode *node = [_listDataArr objectAtIndex:tag];
    [[NSUserDefaults standardUserDefaults] setObject:node forKey:SAVE_SELECTGOODS_NODE];
    [[NSNotificationCenter defaultCenter] postNotificationName:SELECTGOODS_SUCCESS object:nil];

    // 返回
    NSArray *ctrlArray = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 4] animated:YES];
}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqHttpList:(NSInteger )page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_HOME_LIST] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    if (_listStyle == ClassifyListSearch) {
        [dict setObject:_getClassifyId forKey:@"keywords"];

    }
    if (_listStyle == ClassifyListWelfare) {
        [dict setObject:_getClassifyId forKey:@"cid"];

    }

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
            // 列表
        case REQ_SNATCH_HOME_LIST:
        {
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
            // 列表
        case REQ_SNATCH_HOME_LIST:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
}

@end
