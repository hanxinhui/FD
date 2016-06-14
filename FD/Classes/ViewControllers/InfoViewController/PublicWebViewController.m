//
//  PublicWebViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "PublicWebViewController.h"
#import "AppDelegate.h"

@interface PublicWebViewController ()

@end

@implementation PublicWebViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = _webName;
    if (_isSnatch){
        self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
        self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
        self.dlineImgView.hidden = YES;

    }
    
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
   if ([requestString hasPrefix:@"share:"]){
       _shareUrl = [requestString substringFromIndex:6];

   [self showShareView];
        return NO;
    }

    else{
        if ([requestString hasPrefix:@"http://baidu.lecai.com"]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestString]];

            return NO;
        }else{
            return YES;

        }

        
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

#pragma mark - LXActivityDelegate-- 分享

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"========= %d",(int)imageIndex);
    int i = (int)imageIndex ;
    switch (i) {
            // 分享到QQ好友
        case 0 :{
            UIImageView *imgv = [[UIImageView alloc] init];
            [imgv setImage:[UIImage imageNamed:@"icon.png"]];
            
            [app sharePhotoToWeixinFriends:imgv.image description:SHARE_TEXT title:SHARE_TITLE webpageUrl:_shareUrl];
        }
            
            
            break;
            // 分享到微信朋友圈
        case 1 :{
            UIImageView *imgv = [[UIImageView alloc] init];
            [imgv setImage:[UIImage imageNamed:@"icon.png"]];
            
            [app sharePhotoToWeixin:imgv.image description:[self shareText] scene:1 webpageUrl:_shareUrl];
        }
            break;
            // 分享到短信
        case 2 :
            [app showSMSPicker:[self shareText] webpageUrl:_shareUrl];
            break;
        default:
            break;
    }
}

/**   函数名称 :shareText
 **   函数作用 :TODO:分享的字迹
 **   函数参数 :
 **   函数返回值:
 **/
- (NSString *)shareText
{
    NSString *shareString = [NSString stringWithFormat:@"%@ %@ %@",SHARE_TITLE,SHARE_TEXT,_shareUrl];
    return shareString;
}

@end
