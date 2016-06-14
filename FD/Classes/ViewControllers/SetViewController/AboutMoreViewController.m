//
//  AboutViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "AboutMoreViewController.h"
#import "FeedViewController.h"


@interface AboutMoreViewController ()


@end

@implementation AboutMoreViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];

    
    self.titleLable.text = @"帮助";
  
    //设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag = 100000;
    self.leftBtn = backBtn;
    
    //反馈
    UIButton *feedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    feedBtn.frame = CGRectMake(0, 0, 50, 50);
    [feedBtn setTitle:@"反馈" forState:UIControlStateNormal];
    [feedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    feedBtn.backgroundColor = [UIColor clearColor];
    [feedBtn addTarget:self action:@selector(feedBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = feedBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    // 初始化界面
    _conWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , iPhoneHeight - setHeight )];
    _conWebView.delegate = self;
    [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_moreUrl]]]];
    [self.view addSubview: _conWebView];
    [self.progressView show:YES];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is======== %@",requestString);
    return YES;

}
// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.progressView show:YES];

}
//TODO:加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:反馈
- (void)feedBtnPressed{
    FeedViewController *feedViewController = [[FeedViewController alloc] init];
    [self.navigationController pushViewController:feedViewController animated:YES];
    
}

@end
