//
//  MoreViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MoreViewController.h"
#import "CommentViewController.h"
#import "LoginViewController.h"
#import "ModifyDataViewController.h"
#import "AnyTimeBuyViewController.h"
#import "RechargeableViewController.h"
#import "PublicWebViewController.h"



@interface MoreViewController ()


@end

@implementation MoreViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = _webName;
 
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
}

//TODO:命名
- (void)setWebName:(NSString *)webName{
    _webName = webName;
}

//TODO:传人链接
- (void)setWebUrl:(NSString *)webUrl{
    _webUrl = webUrl;
}

//TODO:评论名称
- (void)setGoodName:(NSString *)goodName{
    _goodName = goodName;
}
//TODO:评论类型
- (void)setTypeS:(NSString *)typeS{
    _typeS = typeS;
}
//TODO:评论商品id
- (void)setGID:(NSString *)gID{
    _gID = gID;
}
//TODO:评论id
- (void)setCID:(NSString *)cID{
    _cID = cID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    setHeight = setHeight + NVARBAR_HIGHT;

    // 初始化界面
    _conWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , iPhoneHeight - setHeight )];
    _conWebView.delegate = self;
    [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    [self.view addSubview: _conWebView];
//    _conWebView.scrollView.pagingEnabled = YES;
//    _conWebView.scrollView.clipsToBounds = NO;
    [self initNavBar];

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is======== %@",requestString);
    NSMutableString *comurl = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,SERVER_MORECOMMENT_COM]];
   if ([requestString hasPrefix:comurl]){
        MoreViewController *moreViewController = [[MoreViewController alloc] init];
       moreViewController.webName = @"评论详情";
       moreViewController.webUrl = requestString;
        moreViewController.cID = _cID;
        moreViewController.gID = _gID;
        moreViewController.typeS = _typeS;
        moreViewController.goodName = _goodName;
        [self.navigationController pushViewController:moreViewController animated:YES];
        
        
        return NO;
    }
    // 跳转到完善资料
   else if([requestString hasPrefix:@"http://www.ihuluu.com/#1"]){
       if (![UserDataManager sharedUserDataManager].userIsLogIn) {
           LoginViewController *loginv = [[LoginViewController alloc] init];
           [self.navigationController pushViewController:loginv animated:YES];
           return NO;
       }
       
       ModifyDataViewController *modifyDataViewController = [[ModifyDataViewController alloc] init];
       [self.navigationController pushViewController:modifyDataViewController animated:YES];
       
       return NO;

   }
    // 跳转到做任务
   else if([requestString hasPrefix:@"http://www.ihuluu.com/#2"]){
       AnyTimeBuyViewController *anyTimeBuyViewController = [[AnyTimeBuyViewController alloc] init];
       [self.navigationController pushViewController:anyTimeBuyViewController animated:YES];
       
       return NO;
       
   }
    // 跳转到充值
   else if([requestString hasPrefix:@"http://www.ihuluu.com/#3"]){
       if (![UserDataManager sharedUserDataManager].userIsLogIn) {
           LoginViewController *loginv = [[LoginViewController alloc] init];
           [self.navigationController pushViewController:loginv animated:YES];
           return NO;
       }
       // 跳转充值
   
       RechargeableViewController *controller = [[RechargeableViewController alloc] init];
       [self.navigationController pushViewController:controller animated:YES];
       
       return NO;
       
   }
    // 跳转到分享
   else if([requestString hasPrefix:@"http://www.ihuluu.com/#4"]){
       if (![UserDataManager sharedUserDataManager].userIsLogIn) {
           LoginViewController *loginv = [[LoginViewController alloc] init];
           [self.navigationController pushViewController:loginv animated:YES];
           return NO;
       }
       //            [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
       
       //            [self showShareView];
       PublicWebViewController *webController = [[PublicWebViewController alloc] init];
       webController.isSnatch = NO;

       webController.webStyle = WebWithShare;
       NSString *webs = [NSString stringWithFormat:@"%@Index/invite/uid/%ld",SERVER_URL,(long)[UserDataManager sharedUserDataManager].userData.UID];
       webController.webUrl = webs;
       webController.webName = @"分享好友";
       [self.navigationController pushViewController:webController animated:YES];
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


@end
