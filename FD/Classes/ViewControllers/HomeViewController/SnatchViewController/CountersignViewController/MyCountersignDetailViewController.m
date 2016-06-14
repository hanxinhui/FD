//
//  MyCountersignDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MyCountersignDetailViewController.h"
#import "MyBagDetailListNode.h"
#import "AppDelegate.h"
#import "KLCreateViewController.h"
#import "PublicWebViewController.h"
#import "SnatchPayViewController.h"
#import "SnatchDetailsViewController.h"
#import "ShowMyCodeDetailViewController.h"
#import "AddBankViewController.h"

#define CELL_HIGHT         70  // Cell高度

@interface MyCountersignDetailViewController ()


@end

@implementation MyCountersignDetailViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"暗号抽疯";
    
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.dlineImgView.hidden = YES;
    self.view.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    
    
    
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
    //    setHeight = setHeight + NVARBAR_HIGHT + 20;
    setHeight = setHeight + NVARBAR_HIGHT;
    
    _listDataArr = [NSMutableArray array];
    _coderesultDic = [NSDictionary dictionary];
    
    isLoading = NO;
   

    _shareWXBtn = [[UIButton alloc] initWithFrame:CGRectMake((iPhoneWidth - 262) /2, iPhoneHeight - 55, 262, 50)];
    _shareWXBtn.frame =CGRectMake(20  , iPhoneHeight - 50, iPhoneWidth - 40, 45);
    _shareWXBtn.backgroundColor = [UIColor clearColor];
    [_shareWXBtn addTarget:self action:@selector(shareWXPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareWXBtn];
    [_shareWXBtn setImage:[UIImage imageNamed:@"share_to_weixin.png"] forState:UIControlStateNormal];
//    _shareWXBtn.backgroundColor = UIColorWithRGB(253, 204, 57, 1);
//    [_shareWXBtn setTitle:@"可分享到微信" forState:UIControlStateNormal];
//    [_shareWXBtn setTitleColor:UIColorWithRGB(228, 47, 24, 1) forState:UIControlStateNormal];
//    _shareWXBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
       _shareWXBtn.hidden = YES;
    
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight-setHeight)];
    _conTabView.delegate = self;
    _conTabView.isMyCountersign = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
//    _conTabView.table.tableFooterView = _noImgView;
    
    
    // 隐藏
    _bgHiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    _bgHiddenBtn.backgroundColor = [UIColor blackColor];
    [_bgHiddenBtn addTarget:self action:@selector(cancelAddView) forControlEvents:UIControlEventTouchUpInside];
//    _bgHiddenBtn.tag = 10001;
    [self.view addSubview:_bgHiddenBtn];
    _bgHiddenBtn.hidden = YES;
    _bgHiddenBtn.alpha = 0.3;
    
    _page = 1;
    
    [self reqGetDetilsList:_page];
    
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
    
    [self reqGetDetilsList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqGetDetilsList:_page];
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
    static NSString *identifier = @"MyBagDetailCell";
    MyBagDetailCell *cell = (MyBagDetailCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[MyBagDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.delegate  = self;
    if (nowStatus == 2&& indexPath.section == 0) {
        cell.luckImgView.hidden = NO;
    }
    
    cell.isJoinGroup = _isGroupjoin;
    cell.detailTag = indexPath.section;
    switch (_countersignStyle) {
        case WelfareCountersign:
            cell.cellStyle = WelfareCell;
            
            break;
        case GroupCountersign:
           cell.cellStyle = GroupCell;
            
           
            
            break;
        default:
            break;
    }
    

    MyBagDetailListNode *lnode = [_listDataArr objectAtIndex:indexPath.section];
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.node = lnode;
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
    NSLog(@"surpassOriginY == %f",surpassOriginY);
}

//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
    
}



#pragma mark -
#pragma mark ============ 点击事件 ============

//TODO:返回
- (void)backPressed{
    if (_publishHeadView.timer){
        [_publishHeadView.timer invalidate];
    }
    if (_isKLjoin){
        // 返回
        NSArray *ctrlArray = self.navigationController.viewControllers;
        
        [self.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:MYCOUNTERSIGN_RELOAD object:nil];

        [self.navigationController popViewControllerAnimated:YES];

    }
}

//TODO:显示详情
- (void)showGoodsDetailPressed{
    SnatchDetailsViewController *detailsViewController = [[SnatchDetailsViewController alloc] init];
    detailsViewController.goodID = _detailID;
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

//TODO:显示号码详情
- (void)showDetailPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    MyBagDetailListNode *lnode = [_listDataArr objectAtIndex:tag];
    ShowMyCodeDetailViewController *showMyCodeDetailViewController = [[ShowMyCodeDetailViewController alloc] init];
    showMyCodeDetailViewController.allNum = [_coderesultDic objectForKey:@"price"];;
    showMyCodeDetailViewController.cellNode = lnode;
    
    [self.navigationController pushViewController:showMyCodeDetailViewController animated:YES];

    
}

//TODO:显示中奖计算详情
- (void)showCountDetails{
    PublicWebViewController *webController = [[PublicWebViewController alloc] init];
    webController.webStyle = WebWithShare;
    webController.isSnatch = YES;
    // leoxu 测试用
    NSString *webs = [NSString stringWithFormat:@"http://m-test.ihuluu.com/indiana/compute/gid/%@",_detailID];
    webController.webUrl = webs;
    webController.webName = @"中奖计算详情";
    [self.navigationController pushViewController:webController animated:YES];
}

//TODO:揭晓抽奖
- (void)publishDraw{
    _page = 1;
    [self reqGetDetilsList:_page];
}

//TODO:进行购买
- (void)joinPayPressed{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CANADD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)goodID] forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];

    
}

//TODO:立即参加
- (void)payNowPressed{
    // 判断是否实名
    [self judgementRealName];
}
//TODO:判断是否实名
- (void)judgementRealName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_ISREALNAME] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
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
    _addCountersignView.canNum =  _detaiNode.less ;
    [_addCountersignView showInView:self.view];
}

//TODO:增加数目
- (void)addNumSnatch{
    NSInteger aNum = [_addCountersignView.numTextField.text integerValue] + [_detaiNode.step integerValue];
    if (aNum > _detaiNode.less) {
        [self showProgressWithString:@"已经是最大可选数量" hiddenAfterDelay:1];
        return;
    }
    
    _addCountersignView.numTextField.text = [NSString stringWithFormat:@"%ld",(long)aNum];
}

//TODO:减少数目
- (void)lessNumSnatch{
    NSInteger aNum = [_addCountersignView.numTextField.text integerValue] - [_detaiNode.step integerValue];
    if (aNum < [_detaiNode.start integerValue]) {
        [self showProgressWithString:@"已经是最小可选数量" hiddenAfterDelay:1];
        return;
    }
    _addCountersignView.numTextField.text = [NSString stringWithFormat:@"%ld",(long)aNum];
    
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
    snatchPayViewController.payStyle = groupPayStyle;
    snatchPayViewController.payDict = goodDict;
    [self.navigationController pushViewController:snatchPayViewController animated:YES];
    
    
}
//TODO:取消参加
- (void)cancelAddView{
    _bgHiddenBtn.hidden = YES;
    [_addCountersignView cancelPicker];
    
}

//TODO:弹出提示
- (void)showAlertMsgPressed:(NSString *)msg{
    [self showProgressWithString:msg hiddenAfterDelay:1];
}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetDetilsList:(NSInteger )page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYBAG_DETAIL] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_detailID forKey:@"gid"];
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
                // 详情
            case REQ_MYBAG_DETAIL:
            {
                NSInteger next = [[resultDict objectForKey:RESP_NEXT] integerValue];//获得页数
                NSDictionary *headDic = [NSDictionary dictionary];
                _coderesultDic = [resultDict objectForKey:@"detail"];
                

                if (_page == 1) {
                    headDic = [resultDict objectForKey:@"detail"];
                    NSInteger status = [[headDic objectForKey:@"status"] integerValue];
//                    status = 1;
                    nowStatus = status;
                    _shareWXBtn.hidden = YES;

                    switch (status) {
                        case -1:{
                            if (_detailHeadView) {
                                [_detailHeadView removeFromSuperview];
                                _detailHeadView = nil;
                            }
                            
                            // 列表头部内容
                            _detailHeadView = [[MyBagDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 375)];
                            _detailHeadView.backgroundColor = [UIColor whiteColor];
                            _detailHeadView.delegate = self;
                            switch (_countersignStyle) {
                                case WelfareCountersign:
                                    _detailHeadView.counStyle = WelfareCountersign;
                                    
                                    break;
                                case GroupCountersign:
                                {
                                    
                                    _detailHeadView.counStyle = GroupCountersign;
                                    
                                }
                                    
                                    break;
                                default:
                                    break;
                            }

                            _detailHeadView.isCancel = YES;
                            _detailHeadView.isJoin = _isMyJoin;
                            
                            if (_isMyJoin) {
                                _detailHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 395);
                                
                            }else{
                                _detailHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 325);
                                _conTabView.frame = CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight-setHeight);
                            }
 
                            _detailHeadView.dataDic = headDic;

                            _conTabView.table.tableHeaderView =  _detailHeadView;
                        }
                            break;
                             // 进行中
                        case 1:
                        {
                            if (_detailHeadView) {
                                [_detailHeadView removeFromSuperview];
                                _detailHeadView = nil;
    
                            }

                            // 列表头部内容
                            _detailHeadView = [[MyBagDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 375)];
                            _detailHeadView.backgroundColor = [UIColor whiteColor];
                            _detailHeadView.delegate = self;
                            switch (_countersignStyle) {
                                case WelfareCountersign:
                                    _detailHeadView.counStyle = WelfareCountersign;

                                    break;
                                   case GroupCountersign:
                                {
                                 
                                    _detailHeadView.counStyle = GroupCountersign;

                                }

                                    break;
                                default:
                                    break;
                            }

                            _detailHeadView.isCancel = NO;
                            
                            _detailHeadView.isJoin = _isMyJoin;
                            if (_isMyJoin) {
                                _detailHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 375);
                                
                            }else{
                                _detailHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 300);

                            }
                            if (_countersignStyle == GroupCountersign) {
//                                    _detailHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 350);
                                
                                _conTabView.frame = CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight-setHeight - 55);
                                NSInteger exist = [[headDic objectForKey:@"exist"] integerValue];
                                if (exist == 1) {
                                    _shareWXBtn.hidden = NO;

                                }else{
                                    _shareWXBtn.hidden = YES;

                                }
                                goodID = [[headDic objectForKey:@"id"] integerValue];
                            }
 
                            
                            _detailHeadView.dataDic = headDic;
                            _conTabView.table.tableHeaderView =  _detailHeadView;
                            
                        }
                            break;
                            // 已揭晓
                        case 2:
                        {
                            if (_publishHeadView) {
                                [_publishHeadView removeFromSuperview];
                                _publishHeadView = nil;
                            }
                            if (_openHeadView) {
                                [_openHeadView removeFromSuperview];
                                _openHeadView = nil;
                            }
                            
                            // 列表头部内容
                            _openHeadView = [[MyBagOpenHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 370)];
                            if (_isMyJoin) {
                                _openHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 370);
                            }else{
                                _openHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 260);
                            }
                            _openHeadView.backgroundColor = [UIColor whiteColor];
                            _openHeadView.delegate = self;
                            _openHeadView.isJoin = _isMyJoin;

                            _conTabView.table.tableHeaderView =  _openHeadView;

                            _openHeadView.dataDic = headDic;
                        }
                            break;
                            // 揭晓中
                        case 3:
                        {
                            if (_publishHeadView) {
                                [_publishHeadView removeFromSuperview];
                                _publishHeadView = nil;
                            }
                            
                            // 列表头部内容
                            _publishHeadView = [[MyBagPublishHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 350)];
                            if (_isMyJoin) {
//                                _openHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 350);
                                _publishHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 350);
                            }else{
//                                _openHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 300);
                                 _publishHeadView.frame = CGRectMake(0, 0, iPhoneWidth, 300);
                            }
                            _publishHeadView.backgroundColor = [UIColor clearColor];
                            _publishHeadView.delegate = self;
                            _publishHeadView.isJoin = _isMyJoin;
                            _publishHeadView.dataDic = headDic;
                            _conTabView.table.tableHeaderView =  _publishHeadView;
                            
                        }
                            break;
                        default:
                            break;
                    }
                   
                }
                
                
                NSArray *arr = [resultDict objectForKey:RESP_LIST];
//                if (arr.count == 0){
//                    _noImgView.hidden = NO;
//                }else{
//                    _noImgView.hidden = YES;
//                }
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
                // 获取参与信息
            case REQ_SNATCH_CANADD:{
                NSDictionary *dict = [resultDict objectForKey:RESP_CONTENT];
                _detaiNode = [[SnatchDetailNode alloc] initWithDict:dict];
                [self showAddContersignView];
                
            }
                break;
                // 是否实名
            case REQ_ISREALNAME:{
                NSDictionary *infoDict =[resultDict objectForKey:RESP_CONTENT];
                NSInteger realy = [[infoDict objectForKey:@"realy"] integerValue];
                if (realy == 1) {
                    // 可以兑换
                    [self joinPayPressed];
                }else{
                    AddBankViewController *bankV = [[AddBankViewController alloc] init];
                    [self.navigationController pushViewController:bankV animated:YES];
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
            case REQ_MYBAG_DETAIL:{
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

//TODO:打开微信
- (void)shareWXPressed{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:OPEN_WEIXIN]];
    KLCreateViewController *createViewController = [[KLCreateViewController alloc] init];
    createViewController.codeDict = _coderesultDic;
    [self.navigationController pushViewController:createViewController animated:YES];
}

@end
