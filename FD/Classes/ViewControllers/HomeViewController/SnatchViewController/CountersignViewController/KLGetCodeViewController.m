//
//  KLGetCodeViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "KLGetCodeViewController.h"
#import "KLGetCodeCell.h"
#import "KLGetCodeNode.h"
#import "MyCountersignViewController.h"
#import "MyCountersignDetailViewController.h"


#define CELL_HIGHT    60

@interface KLGetCodeViewController ()


@end

@implementation KLGetCodeViewController

//TODO:获取图片
- (void)setInfoDict:(NSDictionary *)infoDict{
    _infoDict = infoDict;
    
}
//TODO:是否已满
- (void)setIsFull:(BOOL)isFull{
    _isFull = isFull;
    
}

//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    selectCand  = [[_infoDict objectForKey:@"kind"] integerValue];
    switch (selectCand) {
        case 1:
            self.titleLable.text = @"参与抢宝";

            break;
           case 2:
            self.titleLable.text = @"参与群抢宝";

            break;
        default:
            break;
    }
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(199, 84, 70, 1);
    self.dlineImgView.hidden = YES;
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    //我的抢宝
    UIButton *myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(0, 0, 100, 50);
    myBtn.backgroundColor = [UIColor clearColor];
    [myBtn addTarget:self action:@selector(myPressed) forControlEvents:UIControlEventTouchUpInside];
    [myBtn setTitle:@"我的抢宝" forState:UIControlStateNormal];
    myBtn.titleLabel.textColor = [UIColor whiteColor];
    myBtn.titleLabel.font = defaultFontSize(14);
    self.rightBtn = myBtn;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    bgImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgImgView];
    
    setHeight = IOS7?20:0;
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    _codeinfoDict = [NSDictionary dictionary];
    
    
    // 背景图
    UIImageView *headbgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 150)];
    headbgImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headbgImgView];
    [headbgImgView setImage:[UIImage imageNamed:@"MyCounter_bgImage.png"]];
    
    // 4S
    if (iPhoneWidth==320 && iPhoneHeight <500) {
        
        headbgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
        headbgImgView.frame = CGRectMake(0, setHeight-10 ,320, 150);
        
        
    }
    // 5/5S
    if (iPhoneWidth == 320 && iPhoneHeight >500) {
        headbgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
        headbgImgView.frame = CGRectMake(0, setHeight-90 ,320, 221);
        
        
    }
    // 6/6s
    if (iPhoneWidth == 375) {
        headbgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_375.png"];
        headbgImgView.frame = CGRectMake(0, setHeight-110 , 375, 259);
        
    }
    // 6P/6SP
    
    if (iPhoneWidth == 414) {
        headbgImgView.frame = CGRectMake(0, setHeight-140 , 414, 286);
        headbgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_414.png"];
        
    }

    
    setHeight = setHeight + 80;
    
    // 口令发布者头像
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 90) / 2, setHeight, 90, 90)];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headImgView];
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:[_infoDict objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];
    _headImgView.layer.cornerRadius = 45;
    
    _headImgView.layer.masksToBounds = YES;
    
    
    setHeight = setHeight + 90;

    // 手机号
    _phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 30)];
    _phoneLab.backgroundColor = [UIColor clearColor];
    _phoneLab.text = [_infoDict objectForKey:@"mobile"];
    _phoneLab.textColor = [UIColor whiteColor];
    _phoneLab.font = defaultFontSize(19);
    _phoneLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneLab];

    setHeight = setHeight + 25;

    // 说明
    _conLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 50)];
    _conLab.backgroundColor = [UIColor clearColor];
    _conLab.text = [_infoDict objectForKey:@"remark"];
    _conLab.textColor = [UIColor lightGrayColor];
    _conLab.font = defaultFontSize(15);
    _conLab.numberOfLines = 0;
    _conLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_conLab];
    
    if (_isFull) {
        setHeight = setHeight + 80;

        //
        UILabel *fullLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 50)];
        fullLab.backgroundColor = [UIColor clearColor];
        fullLab.text = @"来晚了,参与人数已满";
        fullLab.textColor = [UIColor whiteColor];
        fullLab.font = defaultFontSize(19);
        fullLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:fullLab];
        
    }else{
        setHeight = iPhoneHeight - 190;
        
        //  商品
        UIImageView *footImgView= [[UIImageView alloc] initWithFrame:CGRectMake(20,  setHeight, iPhoneWidth - 40, 110)];
        footImgView.backgroundColor = UIColorWithRGB(252, 239, 202, 1);
        [self.view addSubview:footImgView];
        
        //  商品
        _goodsImgView= [[UIImageView alloc] initWithFrame:CGRectMake(30, setHeight + 10 , 90, 90)];
        _goodsImgView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_goodsImgView];
        [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:[_infoDict objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"Public_nogoods_bg.png"]];
        
        
        _goodsLab = [[UILabel alloc] initWithFrame:CGRectMake(125, setHeight + 10, iPhoneWidth - 150, 45)];
        _goodsLab.backgroundColor = [UIColor clearColor];
        _goodsLab.text = [_infoDict objectForKey:@"title"];
        _goodsLab.textColor = UIColorWithRGB(238, 0, 38, 1);
        _goodsLab.numberOfLines = 0;
        [self.view addSubview:_goodsLab];
        
        _goodsfLab = [[UILabel alloc] initWithFrame:CGRectMake(125, setHeight + 55, iPhoneWidth - 150, 45)];
        _goodsfLab.backgroundColor = [UIColor clearColor];
        _goodsfLab.text = [_infoDict objectForKey:@"sub_title"];
        _goodsfLab.textColor = UIColorWithRGB(255, 168, 50, 1);
        _goodsfLab.numberOfLines = 0;
        [self.view addSubview:_goodsfLab];
        
        //  商品
        UIImageView *anImgView= [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 115) / 2, setHeight + 120 , 115, 58)];
        anImgView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:anImgView];
        [anImgView setImage:[UIImage imageNamed:@"indiana_join.png"]];
//        switch (selectCand) {
//            case 1:
//                self.titleLable.text = @"参与抢宝";
//                
//                break;
//            case 2:
//                self.titleLable.text = @"参与群抢宝";
//                
//                break;
//            default:
//                break;
//        }

        
        // 点击获取抽取码
        _getCodebtn = [[UIButton alloc] initWithFrame:CGRectMake(20, setHeight  , iPhoneWidth - 40, 190)];
        _getCodebtn.backgroundColor = [UIColor clearColor];
        [_getCodebtn addTarget:self action:@selector(goDetailPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_getCodebtn];
    }
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.headerView];
    [self.view bringSubviewToFront:self.headerBgView];
    [self.view bringSubviewToFront:self.titleLable];
    [self.view bringSubviewToFront:self.rightBtn];

    [self.view bringSubviewToFront:self.leftBtn];
}

//TODO:传入口令
- (void)setCodeStr:(NSString *)codeStr{
    if (_codeStr == codeStr) {
        return;
    }
    _codeStr = codeStr;
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}


//TODO:获取抽奖码
- (void)getlistPressed{
    MyCountersignDetailViewController *detailsViewController = [[MyCountersignDetailViewController alloc] init];
    
    detailsViewController.countersignStyle = WelfareCountersign;

    detailsViewController.isMyJoin = YES;
    detailsViewController.isKLjoin = YES;
    detailsViewController.detailID = [_codeinfoDict objectForKey:@"id"];
    [self.navigationController pushViewController:detailsViewController animated:YES];

}

//TODO:我的抢宝
- (void)myPressed{
    MyCountersignViewController *myCountersignViewController = [[MyCountersignViewController alloc] init];
    [self.navigationController pushViewController:myCountersignViewController animated:YES];
}


#pragma mark 网络请求
//TODO:加入抢宝
- (void)goDetailPressed{
    switch (selectCand) {
        case 1:
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInt:REQ_KL_JOIN] forKey:REQ_CODE];
            
            [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
            [dict setObject:_codeStr forKey:@"code"];
            [self.httpManager sendReqWithDict:dict];
            [self.progressView show:YES];

        }
            
            break;
        case 2:
        {
            MyCountersignDetailViewController *detailsViewController = [[MyCountersignDetailViewController alloc] init];
            
            detailsViewController.isGroupjoin = NO;
            detailsViewController.countersignStyle = GroupCountersign;
            detailsViewController.isMyJoin = YES;
            detailsViewController.isKLjoin = YES;
            detailsViewController.detailID = [_infoDict objectForKey:@"id"];
            [self.navigationController pushViewController:detailsViewController animated:YES];
        }
            break;
        default:
            break;
    }
    
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 验证口令
        case REQ_KL_JOIN:
        {
            _codeinfoDict = [resultDict objectForKey:RESP_CONTENT];
            
            [self getlistPressed];
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
            //
        case REQ_KL_JOIN:{
            msg = @"口令输入错误";
            
        }
            break;
            
        default:
            break;
    }
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
    
}


@end
