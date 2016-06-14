//
//  AddBankViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "AddBankViewController.h"




@interface AddBankViewController ()


@end

@implementation AddBankViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor clearColor];
    
    self.titleLable.text = @"";
//    self.headerBgView.backgroundColor = [UIColor clearColor];
//    self.headerView.backgroundColor = [UIColor clearColor];
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn] ;
 
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavBar];

    setHeight = setHeight + NVARBAR_HIGHT;

    // 初始化界面
    _conWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , iPhoneHeight - setHeight)];
    _conWebView.delegate = self;
    NSString *wUrl = [NSString stringWithFormat:@"%@%@%ld",SERVER_URL,SERVER_ADDBANK,(long)[UserDataManager sharedUserDataManager].userData.UID];
    [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wUrl]]];
    [self.view addSubview: _conWebView];
//    _conWebView.scrollView.pagingEnabled = YES;
    _conWebView.scrollView.clipsToBounds = NO;

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is======== %@",requestString);
    if([requestString hasSuffix:@"#open"]){
        
        return NO;
        
    }else{
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
    [[NSNotificationCenter defaultCenter] postNotificationName:BANKLIST_RELOAD object:nil];

    [self.navigationController popViewControllerAnimated:YES];
}


@end
