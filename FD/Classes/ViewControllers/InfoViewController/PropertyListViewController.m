//
//  PropertyListViewController.m
//  FD
//
//  Created by Leo on 15-7-10.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "PropertyListViewController.h"
#import "MonthGroup.h"
#import "Mission.h"
#import "MissionHeadView.h"
#import "ViewController.h"
#import "PropertyDetailViewController.h"
#import "PropertyNode.h"
#import "PropertyListNode.h"
#import "PropertyListCell.h"
#import "BankListViewController.h"
#import "RechargeableViewController.h"


@interface PropertyListViewController () <MissionHeadViewDelegate>

@end

@implementation PropertyListViewController

//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"资产明细";
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"资产明细";
    
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    _listDataArr = [NSMutableArray array];
    isFirstIn = YES;
    nowSel = 0;
    float setDownH  = 60;
    if (iPhoneWidth > 320) {
        setDownH = 60;
    }else{
        setDownH = 50;
    }
    // 主列表
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - 50)];
    _mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.sectionHeaderHeight = 60;
    self.mainTableView.rowHeight = 70;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_mainTableView setTableFooterView:view];
    _mainTableView.showsVerticalScrollIndicator = NO;

    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];

    
    
    // 充值
    UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, iPhoneHeight - setDownH , iPhoneWidth / 2 , setDownH)];
    payBtn.backgroundColor = UIColorWithRGB(25, 125, 218, 0.8);
    [payBtn addTarget:self action:@selector(payPressed) forControlEvents:UIControlEventTouchUpInside];
    //    [_addBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    payBtn.titleLabel.font = defaultFontSize(13);
    [payBtn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    payBtn.frame = CGRectMake(0, iPhoneHeight - setDownH , iPhoneWidth / 2 , setDownH);

    [self.view addSubview:payBtn];
    UILabel *alab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/2, setDownH)];
    alab.backgroundColor = [UIColor clearColor];
    alab.textAlignment = NSTextAlignmentCenter;
    alab.textColor =  UIColorWithRGB(255, 255, 255, 1);
    [payBtn addSubview:alab];
    alab.font = [UIFont systemFontOfSize:17];
    alab.text = @"充值";
    
    // 提现
    UIButton *getBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 2, iPhoneHeight - setDownH , iPhoneWidth / 2 , setDownH)];
    getBtn.backgroundColor = UIColorWithRGB(250, 131, 50, 1);
    [getBtn addTarget:self action:@selector(getPressed) forControlEvents:UIControlEventTouchUpInside];
    //    [_addBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    getBtn.titleLabel.font = defaultFontSize(13);
    [getBtn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    getBtn.frame = CGRectMake(iPhoneWidth / 2, iPhoneHeight - setDownH , iPhoneWidth / 2 , setDownH);
    
    [self.view addSubview:getBtn];
    UILabel *getlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/2, setDownH)];
    getlab.backgroundColor = [UIColor clearColor];
    getlab.textAlignment = NSTextAlignmentCenter;
    getlab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [getBtn addSubview:getlab];
    getlab.font = [UIFont systemFontOfSize:17];
    getlab.text = @"提现";

    
    UIImageView *sLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 2, iPhoneHeight - setDownH + 13, 1, setDownH- 26)];
    sLineImgView.backgroundColor = UIColorWithRGB(177, 177, 177, 0.3);
    [self.view addSubview:sLineImgView];
    
    [self reqHttpPropertyList];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

#pragma mark 加载数据
- (void)loadData
{

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PropertyNode*monthGroup = _listDataArr[section];
    NSInteger count ;
    count = 0;
    if (nowSel == section) {
        if (isFirstIn && nowSel == 0) {
            isFirstIn = NO;
            count = monthGroup.prolist.count;

        }else{
            count = monthGroup.isOpened ? monthGroup.prolist.count : 0;

        }

    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PropertyListCell";
    
    PropertyListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PropertyListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    PropertyNode *monthGroup = _listDataArr[indexPath.section];
    PropertyListNode *mission = monthGroup.prolist[indexPath.row];
    cell.node = mission;
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MissionHeadView *headView = [MissionHeadView headViewWithTableView:tableView getRow:section];
    headView.delegate = self;
    headView.propertyNode = _listDataArr[section];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyDetailViewController *viewController = [[PropertyDetailViewController alloc] init];
    PropertyNode *monthGroup = _listDataArr[indexPath.section];
    PropertyListNode *mission = monthGroup.prolist[indexPath.row];
    viewController.pnode = mission;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)clickHeadView:(NSInteger )row
{
    nowSel = row;
    [self.mainTableView reloadData];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//TODO:提现
- (void)getPressed{
    BankListViewController *controller = [[BankListViewController alloc] init];
    controller.bankStyle = BankWithGet;
    [self.navigationController pushViewController:controller animated:YES];
}

//TODO:充值
- (void)payPressed{
    RechargeableViewController *controller = [[RechargeableViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =============== 网络请求 ================

//TODO:网络请求 列表数据
- (void)reqHttpPropertyList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYINFO_PROPERTY_LIST] forKey:REQ_CODE];
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
            // 列表
        case REQ_MYINFO_PROPERTY_LIST:
        {
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            if (arr.count == 0){
                _noImgView.hidden = NO;
            }else{
                _noImgView.hidden = YES;
                
            }
            self.listDataArr = [NSMutableArray arrayWithArray:arr];
            
            [_mainTableView reloadData];
            
            
            
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
        case REQ_MYINFO_PROPERTY_LIST:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

@end
