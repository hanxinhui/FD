//
//  SignUpViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SignUpViewController.h"




@interface SignUpViewController ()


@end

@implementation SignUpViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    if (_signUpStyle == SignIng){
        self.titleLable.text = @"签到";

    }else{
        self.titleLable.text = @"签到说明";

    }
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    // 右边按钮 菜单按钮
    UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    explainBtn.frame = CGRectMake(iPhoneWidth - 50, setHeight, 50, 50);
    explainBtn.frame = CGRectMake(0, 0, 50, 50);
    explainBtn.backgroundColor = [UIColor clearColor];
    [explainBtn addTarget:self action:@selector(showExpine) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:explainBtn];
    [explainBtn setTitle:@"说明" forState:UIControlStateNormal];
    self.rightBtn = explainBtn;

    if (_signUpStyle == SignExplain){
        self.rightBtn.hidden = YES;
    }else{
        self.rightBtn.hidden = NO;

    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
  
    _signWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , iPhoneHeight - setHeight)];
    _signWebView.delegate = self;
    _signWebView.backgroundColor = [UIColor clearColor];
    NSString *urlS;
    if (_signUpStyle == SignIng){
        urlS = [NSString stringWithFormat:@"%@%@/uid/%@",SERVER_URL,SERVER_SIGN_DETAIL,[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID]];

    }else {
        urlS = [NSString stringWithFormat:@"%@%@",SERVER_URL,SERVER_SIGN_EXPLAIN];

    }
    
    [_signWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlS]]];
    [self.view addSubview: _signWebView];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is======== %@",requestString);
    // 往期揭晓
    if ([requestString hasPrefix:@"http://wangqi/" ]){
        
  
        return NO;
    }
    

 
    
    else if ([requestString hasSuffix:@"#fabu"]){
        
        
        return NO;
    }
    else{
        return YES;
    }
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.progressView show:YES];
}

//TODO:加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSLog(@"webViewDidFinishLoad======");
    [self.progressView hide:YES];
    
    //    id repr = [self.jsonString JSONFragment];
    //    [_conWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initSpread(%@);",repr]];
    
}

//TODO:加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.progressView hide:YES];
    
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}


//TODO:签到说明
- (void)showExpine{
    //
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    signUpViewController.signUpStyle = SignExplain;
    [self.navigationController pushViewController:signUpViewController animated:YES];
}

@end
