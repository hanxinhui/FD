//
//  PassedSnatchViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "PassedSnatchViewController.h"
#import "SnatchPassedListCell.h"
#import "PassedSnatchNode.h"


#define CELL_HIGHT         185  // 底部高度

@interface PassedSnatchViewController ()


@end

@implementation PassedSnatchViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"往期揭晓";
  
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

    self.view.backgroundColor = UIColorWithRGB(240, 239, 236, 1);
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
   
    _listDataArr = [NSMutableArray array];
    _page = 1;
    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
    _conTabView.hasReloadView = YES;
//    _conTabView.canMove = YES;
    _conTabView.canDelete = NO;
    [self.view addSubview:_conTabView];
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    _page = 1;
    
    [self reqGetClassList:_page];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

//TODO:传人id
- (void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
}

#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    [self reqGetClassList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetClassList:_page];
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
//    //    HomeNode *lnode = [_listDataArr objectAtIndex:indexPath.row];
//    SnatchDetailsViewController *detailsViewController = [[SnatchDetailsViewController alloc] init];
//    //    detailsViewController.detailID = lnode.Hid;
//    [self.navigationController pushViewController:detailsViewController animated:YES];
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
    static NSString *identifier = @"SnatchPassedListCell";
    
    SnatchPassedListCell *cell = (SnatchPassedListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[SnatchPassedListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PassedSnatchNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(215, 213, 214, 1);
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
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 网络请求
//TODO:获取列表
- (void)reqGetClassList:(NSInteger)page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_PASSED_LIST] forKey:REQ_CODE];
    [dict setObject:_goodID forKey:@"id"];
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
        case REQ_SNATCH_PASSED_LIST:
        {
            
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
        case REQ_SNATCH_PASSED_LIST:        {
            [self.conTabView doneLoadingTableViewData];
            
        }
            break;
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}
@end
