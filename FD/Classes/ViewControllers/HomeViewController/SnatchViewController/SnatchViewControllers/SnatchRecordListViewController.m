//
//  SnatchRecordListViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SnatchRecordListViewController.h"
#import "SnatchDetailsViewController.h"
#include "HYSegmentedControl.h"

#import "SnatchRecordListNode.h"

#import "PassedSnatchNode.h"
#import "SnatchPayViewController.h"


#define CELL_HIGHT        252  // 已揭晓Cell高度
#define CELL_RECORDING_HIGHT  190  // 人未满Cell高度
#define CELL_UNRECORD_HIGHT  230  // 揭晓中Cell高度


@interface SnatchRecordListViewController ()<HYSegmentedControlDelegate>

@property (strong, nonatomic)HYSegmentedControl *segmentedControl;


@end

@implementation SnatchRecordListViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"夺宝记录";
  
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
    _listDataArr = [NSMutableArray array];

    seType = 0;
    // 选择
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:30 Titles:@[@"全部",@"进行中",@"已揭晓"] delegate:self];
    self.segmentedControl.frame = CGRectMake(0, setHeight, iPhoneWidth, 40);
    [self.view addSubview:_segmentedControl];
    setHeight = setHeight + 42;

    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
//    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = NO;
    [self.view addSubview:_conTabView];
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
//    _conTabView.table.tableFooterView = _noImgView;
    
    _page = 1;
    
    // 隐藏
    _bgHiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    _bgHiddenBtn.backgroundColor = [UIColor blackColor];
    [_bgHiddenBtn addTarget:self action:@selector(cancelAddView) forControlEvents:UIControlEventTouchUpInside];
    _bgHiddenBtn.tag = 10001;
    [self.view addSubview:_bgHiddenBtn];
    _bgHiddenBtn.hidden = YES;
    _bgHiddenBtn.alpha = 0.3;
    
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
    
    
        SnatchRecordListNode *lnode = [_listDataArr objectAtIndex:indexPath.section];
        SnatchDetailsViewController *detailsViewController = [[SnatchDetailsViewController alloc] init];
        detailsViewController.goodID = lnode.wid;
        [self.navigationController pushViewController:detailsViewController animated:YES];

    
}

-(CGFloat)fhtable:(FHTableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SnatchRecordListNode *lnode =  [_listDataArr objectAtIndex:indexPath.section];
      NSInteger status = lnode.status;
    if (status == 1){
        return CELL_RECORDING_HIGHT;

    }
    if (status == 2){
        return CELL_HIGHT;
        
    }
    else {
        return CELL_UNRECORD_HIGHT;
        
    }
 

}
-(NSInteger)fhtable:(FHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)fhtable:(FHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SnatchRecordListNode *lnode =  [_listDataArr objectAtIndex:indexPath.section];
  
 
     NSInteger status = lnode.status;
    //人未满
    if (status == 1) {
        
        static NSString *identifier = @"SnatchRecodingListCell";
        SnatchRecodingListCell *cell = (SnatchRecodingListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell = [[SnatchRecodingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.delegate = self;
        
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_RECORDING_HIGHT - 1, iPhoneWidth, 1)];
        lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
        [cell addSubview:lineImgView];
        
        
        cell.node = lnode;
        return cell;
    }
    // 已揭晓
    else if (status == 2){
        static NSString *identifier = @"SnatchRecodeListCell";
        SnatchRecodeListCell *cell = (SnatchRecodeListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell = [[SnatchRecodeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.delegate = self;

     
        
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
        lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
        [cell addSubview:lineImgView];
      
        
        cell.node = lnode;
        return cell;
        
    }
    // 揭晓中
    else {
        
        static NSString *identifier = @"SnatchUnRecodeListCell";
        SnatchUnRecodeListCell *cell = (SnatchUnRecodeListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell = [[SnatchUnRecodeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        cell.delegate = self;

    
        
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_UNRECORD_HIGHT - 1, iPhoneWidth, 1)];
        lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
        [cell addSubview:lineImgView];
               
         cell.node = lnode;
        
        return cell;
        
    }
    
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
//TODO:筛选
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    NSLog(@"当前选择  =========   %ld",(long)index);
    _page = 1;
    seType = index;
   

    [self reqGetList:_page];
    
    
}



#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:追加
- (void)addToPay:(id)sender{
    UIButton *btn  = (UIButton *)sender;
    NSInteger tag = btn.tag;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CANADD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)tag] forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];

}

//TODO:显示参与选择
- (void)showAddContersignView{
    if (_addCountersignView){
        [_addCountersignView removeFromSuperview];
        _addCountersignView = nil;
    }
    _bgHiddenBtn.hidden = NO;
    _addCountersignView = [[AddCountersignView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    _addCountersignView.delegate = self;
    _addCountersignView.dNode = _detaiNode;
    [_addCountersignView showInView:self.view];
}

//TODO:夺宝
- (void)addSnatch:(NSInteger )num{
    
    NSMutableDictionary *goodDict = [NSMutableDictionary dictionary];
    
    [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [goodDict setObject:_detaiNode.Sid forKey:@"gid"];
    //            [_goodDiC setObject:_moneyLab.text forKey:@"pice"];
    [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)num] forKey:@"count"];
    [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)num * 100] forKey:@"pice"];
    
    SnatchPayViewController *snatchPayViewController = [[SnatchPayViewController alloc] init];
    snatchPayViewController.payStyle = publicPayStyle;
    snatchPayViewController.payDict = goodDict;
    [self.navigationController pushViewController:snatchPayViewController animated:YES];
    
    
}

//TODO:取消参加
- (void)cancelAddView{
    _bgHiddenBtn.hidden = YES;
    [_addCountersignView cancelPicker];
    
}

//TODO:查看详情
- (void)lookDetail:(id)sender
{
    UIButton *btn  = (UIButton *)sender;
    NSInteger tag = btn.tag;
    SnatchDetailsViewController *detailsViewController = [[SnatchDetailsViewController alloc] init];
    detailsViewController.goodID = [NSString stringWithFormat:@"%ld",(long)tag];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

#pragma mark 网络请求
//TODO:获取夺宝记录列表
- (void)reqGetList:(NSInteger)page{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_RECORD_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)seType] forKey:@"status"];
    
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
                // 列表
            case REQ_SNATCH_RECORD_LIST:
            {
                
                NSInteger pages = [[resultDict objectForKey:RESP_PAGENUM] integerValue];//获得页数
                NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
                if (arr.count == 0){
                    
                    [self showProgressWithString:@"暂无数据" hiddenAfterDelay:1];
                    _noImgView.hidden = NO;
                    _conTabView.hidden = YES;
                    
                   
                }else{
                    _noImgView.hidden = YES;
                 
                    _conTabView.hidden = NO;
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
                
                if (pages > _page) {
                    _conTabView.hasMoreData  = YES;
                    [self doneLoadMoreTableViewData:_conTabView];
                    
                }else{
                    _conTabView.hasMoreData  = NO;
                    
                }
            }
                break;
                // 获取参与信息
            case REQ_SNATCH_CANADD:{
                NSDictionary *dict = [resultDict objectForKey:RESP_CONTENT];
                _detaiNode = [[SnatchDetailNode alloc] initWithDict:dict];
                [self showAddContersignView];
                
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
            case REQ_SNATCH_RECORD_LIST:        {
                [self.conTabView doneLoadingTableViewData];
                
            }
                break;
                // 获取参与信息
            case REQ_SNATCH_CANADD:{
                
            }
            default:
                break;
        }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    

}
@end
