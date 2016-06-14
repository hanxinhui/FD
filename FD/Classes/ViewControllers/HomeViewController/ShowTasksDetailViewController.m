//
//  ShowTasksDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ShowTasksDetailViewController.h"


#define SETFOOTHIGH         65  // 底部高度

@interface ShowTasksDetailViewController ()


@end

@implementation ShowTasksDetailViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor clearColor];
    
    self.titleLable.text = @"";
    self.headerBgView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.statusColor = [UIColor clearColor];

    self.titleLable.text = @"详情";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    

    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
//    setHeight = setHeight + NVARBAR_HIGHT;
    isFirst = YES;
    // 初始化界面
    _conWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth , iPhoneHeight  )];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    _conWebView.delegate = self;
    NSString *filePath =[resourcePath stringByAppendingPathComponent:@"localH5/mission.html"];

    [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: filePath]]];
    [self.view addSubview: _conWebView];
    _conWebView.scrollView.bounces = NO;
    
    [self initNavBar];

//    id repr = [self.jsonString JSONFragment];
//    [_conWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initMission(%@);",repr]];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    if([requestString hasPrefix:@"http://baidu.c"] || [requestString hasPrefix:@"http://www.baidu."])
    {
        if (!isFirst){
            return YES;
        }else{
            isFirst = NO;

        }

        // 任务完成
        [[NSNotificationCenter defaultCenter] postNotificationName:TASKS_HAVEDONE_SUCCESS object:nil];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DOTASK] forKey:REQ_CODE];
        
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
        [dict setObject:_detailNode.gid forKey:@"id"];
        [dict setObject:_detailNode.mid forKey:@"mid"];
        [self.httpManager sendReqWithDict:dict];
        [self.progressView show:YES];
        return NO;
    }
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

    NSLog(@"webViewDidFinishLoad======");

    id repr = [self.jsonString JSONFragment];
    [_conWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initMission(%@);",repr]];
  
   
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
#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
      
            //做随时赚的任务
        case REQ_ANYTIMEBUY_DOTASK:{
            if (_isMyTask) {
                
                // 任务完成
                [[NSNotificationCenter defaultCenter] postNotificationName:DOMYTASK_SUCCESS object:nil];
                
            }


//            NSLog(@"REQ_ANYTIMEBUY_DOTASK is========= %@",resultDict);
            _nextjsonString = [resultDict objectForKey:RESP_CONTENT];
            NSDictionary *ddd = [resultDict objectForKey:RESP_CONTENT];
            if ([ddd count] != 0 ) {
                BuyDetailNode *node = [[BuyDetailNode alloc] initWithDict:ddd];
                _detailNode = node;
                // 继续做任务
                UIAlertView *showAlertV = [[UIAlertView alloc] initWithTitle:nil message:@"继续进行下个任务?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续", nil];
                [showAlertV show];
                
            }else{
                // 全部完成任务
                UIAlertView *showAlertV = [[UIAlertView alloc] initWithTitle:nil message:@"恭喜,您今日的任务已全部做完!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [showAlertV show];
            }

        }
            break;
        default:
            break;
    }
    
}

#pragma mark -
#pragma mark ============ UIAlertViewDelegate ============
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"确定"]) {
        if (_isMyTask) {
            NSArray *ctrlArray = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 3] animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:ISSHOW_SCORE_SUCCESS object:nil];

        }else{
            [self.navigationController popViewControllerAnimated:YES];
            
        }

    }
    else if ([str isEqualToString:@"取消"]) {
        if (_isMyTask) {
            NSArray *ctrlArray = self.navigationController.viewControllers;
            
            [self.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 3] animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
 
        }
        
    }
    if ([str isEqualToString:@"继续"]) {
        isFirst = YES;
        // 返回
        id repr = [self.nextjsonString JSONFragment];
        [_conWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initMission(%@);",repr]];
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
        case REQ_ANYTIMEBUY_DOTASK:{
            
        }
            break;
   
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

@end
