//
//  SnatchQuestionViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SnatchQuestionViewController.h"


#define SETFOOTHIGH         50  // 底部高度

@interface SnatchQuestionViewController ()


@end

@implementation SnatchQuestionViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"常见问题";
  
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
    // 初始化界面
    _conWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , iPhoneHeight - setHeight )];
    _conWebView.delegate = self;
    [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,SERVER_SNATCH_QUESTION]]]];
    
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
    
//    if (isFIn) {
//        isFIn = NO;
//        //        [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",SERVER_HELPWEB]]]];
//        
//        return YES;
//        
//    }else{
//        AboutMoreViewController *aboutMore = [[AboutMoreViewController alloc] init];
//        aboutMore.moreUrl = requestString;
//        [self.navigationController pushViewController:aboutMore animated:YES];
//        return NO;
//        
//    }
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


#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetFavList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DETAIL] forKey:REQ_CODE];
//  
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
//    [dict setObject:_goodID forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
//    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
//            // 详情
//        case REQ_ANYTIMEBUY_DETAIL:
//        {
//            self.jsonString = [resultDict objectForKey:RESP_CONTENT];
//            
//
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    [self.progressView hide:YES];
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
//    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
//            // 详情
//        case REQ_ANYTIMEBUY_DETAIL:{
//        }
//            break;
//            
//        default:
//            break;
//    }
    
    
}

@end
