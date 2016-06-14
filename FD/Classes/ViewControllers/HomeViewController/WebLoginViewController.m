//
//  DetailsViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "WebLoginViewController.h"


#define SETFOOTHIGH         50  // 底部高度

@interface WebLoginViewController ()


@end

@implementation WebLoginViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"扫描结果";
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);

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
    setHeight = setHeight + 20;
    // 显示链接
    _webTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 20, 100)];
    _webTextView.backgroundColor = [UIColor clearColor];
    _webTextView.textColor = [UIColor blackColor];
    [_webTextView setEditable:NO];
    [self.view addSubview:_webTextView];
    _webTextView.delegate = self;
    _webTextView.font = defaultFontSize(21);
    setHeight = setHeight + 100;

    // 登陆图标
    _comImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 130 ) / 2, setHeight, 130, 100)];
    _comImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_comImgView];
    [_comImgView setImage:[UIImage imageNamed:@"compute.png"]];
    
    setHeight = setHeight + 120;

    // 登陆提示
    _comLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 50)];
    _comLab.backgroundColor = [UIColor clearColor];
    _comLab.textColor = [UIColor blackColor];
    _comLab.font = defaultFontSize(17);
    _comLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_comLab];
    _comLab.text = @"网页版爱葫芦登录确认";
    
    setHeight = iPhoneHeight - 150;
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((iPhoneWidth- 150)/2, setHeight, 150, 40)];
    _loginBtn.backgroundColor = [UIColor clearColor];
    [_loginBtn.layer setMasksToBounds:YES];
    [_loginBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_loginBtn.layer setBorderWidth:1.0]; //边框宽度
    CGColorRef colorref = UIColorWithRGB(81, 164, 79, 1).CGColor;
    
    [_loginBtn.layer setBorderColor:colorref];//边框颜色
    
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:UIColorWithRGB(81, 164, 79, 1) forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(reqLoginWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    setHeight = setHeight+ 80;

    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((iPhoneWidth- 150)/2, setHeight, 150, 40)];
    _cancelBtn.backgroundColor = [UIColor clearColor];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:UIColorWithRGB(159, 162, 162, 1) forState:UIControlStateNormal];

    [_cancelBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    if (self.showWebStyle == ShowLoginWeb) {
        _loginBtn.hidden = NO;
        _cancelBtn.hidden = NO;
        _comImgView.hidden  = NO;
        _webTextView.hidden = YES;
        _comLab.hidden = NO;

    }else{
        _loginBtn.hidden = YES;
        _cancelBtn.hidden = NO;
        _comImgView.hidden  = YES;
        _webTextView.hidden = NO;
        _comLab.hidden = YES;
        _webTextView.text = _urlStr;
        
    }

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
 
}

//TODO:出入类型
- (void)initWithStyle:(ShowWebStyle)style{
    
    self.showWebStyle = style;
    if (self.showWebStyle == ShowLoginWeb) {
        _loginBtn.hidden = NO;
        _cancelBtn.hidden = NO;
        _comImgView.hidden  = NO;
        _webTextView.hidden = YES;
        _comLab.hidden = NO;
    }else{
        _loginBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        _comImgView.hidden  = YES;
        _webTextView.hidden = NO;
        _comLab.hidden = YES;
        _webTextView.text = _urlStr;

    }
}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 网络请求
//TODO:登陆网页
- (void)reqLoginWebView{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_HOME_LOGINWEB] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    [dict setObject:[UserDataManager sharedUserDataManager].userData.UPassWord forKey:@"pwd"];
    [dict setObject:_urlStr forKey:@"code"];
    
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
            // 登陆成功
        case REQ_HOME_LOGINWEB:{
            [self backPressed];
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
            // 登陆失败
        case REQ_HOME_LOGINWEB:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
}



@end
