//
//  WinningAffirmViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "WinningAffirmViewController.h"
#import "AddressViewController.h"



@interface WinningAffirmViewController ()


@end

@implementation WinningAffirmViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"中奖确认";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}


//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SETADDRSSS_WINNER_DETAIL object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSureAddress) name:SETADDRSSS_WINNER_DETAIL object:nil];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];
    setHeight = 0;
    
    
   [self reqGetWiningAffirm];

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

// 初始化界面
- (void)setTheMainView{
    // 奖品状态
    if (_statusCell) {
        [_statusCell removeFromSuperview];
        _statusCell = nil;
    }
    _statusCell = [[WAStatusCell alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 270)];
    _statusCell.backgroundColor = [UIColor clearColor];
    _statusCell.delegate = self;
    _statusCell.node = _affirmNode;
    [_mainScrollView addSubview:_statusCell];
    
    setHeight = setHeight + 280;
    
    if (_affirmNode.status > 1){
        // 物流信息
        if (_logisticsCell) {
            [_logisticsCell removeFromSuperview];
            _logisticsCell = nil;
        }
        _logisticsCell = [[WALogisticsCell alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 150)];
        _logisticsCell.backgroundColor = [UIColor clearColor];
        _logisticsCell.node = _affirmNode;
        
        
        [_mainScrollView addSubview:_logisticsCell];
        
        setHeight = setHeight + 160;

    }
    
    
    if (_affirmNode.status >0){
        // 地址信息
        if (_addressCell) {
            [_addressCell removeFromSuperview];
            _addressCell = nil;
        }
        _addressCell = [[WAAddressCell alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 150)];
        _addressCell.backgroundColor = [UIColor clearColor];
        _addressCell.node = _affirmNode;
        [_mainScrollView addSubview:_addressCell];
        
        setHeight = setHeight + 160;

    }
    
    
    // 奖品信息
    if (_goodsCell) {
        [_goodsCell removeFromSuperview];
        _goodsCell = nil;
    }
    _goodsCell = [[WAGoodsCell alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 270)];
    _goodsCell.backgroundColor = [UIColor clearColor];
   _goodsCell.node = _affirmNode;
    [_mainScrollView addSubview:_goodsCell];
    
    setHeight = setHeight + 280;
    
    _mainScrollView.contentSize = CGSizeMake(iPhoneWidth, setHeight);
}

//TODO:获取中奖商品id
- (void)setWinGoods:(NSString *)winGoods{
    if (_winGoods == winGoods) {
        return;
    }
    
    _winGoods = winGoods;
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:设置地址
- (void)toSetAddress{
    
    AddressViewController *addressViewController = [[AddressViewController alloc] init];
    addressViewController.addressStyle = winnerAddress;
    addressViewController.winnerGoodsID = _winGoods;
    addressViewController.isBuyIn = NO;
    [self.navigationController pushViewController:addressViewController animated:YES];
}

//TODO:选择送货地址成功
- (void)setSureAddress{
    [self reqGetWiningAffirm];
}

//TODO:确认收货
- (void)sureGetGood{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_MYWINNER_SURE] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_affirmNode.wid forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}
//TODO:我要晒单
- (void)showGood{
    
}

//TODO:获得cell位置
- (void)doAnyPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    if (tag == 100001){
        [self toSetAddress];// 选择地址
    }
    if (tag == 100002){
        [self sureGetGood];// 确认收货
    }
    if (tag == 100003){
        [self showGood];// 我要晒单
    }

}
    
#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetWiningAffirm{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_MYWINNER_DETAILS] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_winGoods forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


//#pragma mark -
//#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 详情
        case REQ_SNATCH_MYWINNER_DETAILS:
        {
            NSDictionary *infoDict = [resultDict objectForKey:RESP_CONTENT];
            if (_affirmNode) {
                _affirmNode = nil;
                
            }
            _affirmNode = [[WinningAffirmNode alloc] initWithDict:infoDict];
            setHeight = 0;

            [self setTheMainView];
            
        }
            break;
            // 确认收货
        case REQ_SNATCH_MYWINNER_SURE:{
            [self showProgressWithString:@"确认成功" hiddenAfterDelay:1];
            [self reqGetWiningAffirm];
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
        case REQ_SNATCH_MYWINNER_DETAILS:
            // 确认收货
        case REQ_SNATCH_MYWINNER_SURE:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

    
}
//
//


@end
