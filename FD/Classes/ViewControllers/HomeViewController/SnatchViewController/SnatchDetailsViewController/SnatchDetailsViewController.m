//
//  SnatchDetailsViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SnatchDetailsViewController.h"
#import "PassedSnatchViewController.h"
#import "ShowMyViewController.h"
#import "ShoppingCartViewController.h"
#import "SnatchPayViewController.h"
#import "AddBankViewController.h"
#import "LoginViewController.h"


#define SETFOOTHIGH         50  // 底部高度

@interface SnatchDetailsViewController ()


@end

@implementation SnatchDetailsViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"奖品详情";
  
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
//    _detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , iPhoneHeight - setHeight - TARBAR_HIGHT)];
    _detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , iPhoneHeight - setHeight)];
    _detailWebView.delegate = self;
    _detailWebView.backgroundColor = [UIColor clearColor];
    NSString *urlS = [NSString stringWithFormat:@"%@%@id/%@/uid/%@",SERVER_URL,SERVER_SNATCH_DETAILS,_goodID,[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID]];
    [_detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlS]]];
    [self.view addSubview: _detailWebView];
    //    _conWebView.scrollView.pagingEnabled = YES;
//    _detailWebView.scrollView.clipsToBounds = NO;
//    _detailWebView.scrollView.delegate = self;
    [_detailWebView setOpaque:NO];

    // 隐藏
    _bgHiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    _bgHiddenBtn.backgroundColor = [UIColor blackColor];
  [_bgHiddenBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    _bgHiddenBtn.tag = 10001;
    [self.view addSubview:_bgHiddenBtn];
    _bgHiddenBtn.hidden = YES;
    _bgHiddenBtn.alpha = 0.3;
    
     
//    [self setFootView];
    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    //将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
}


//TODO:传人id
- (void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
}

#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is======== %@",requestString);
    // 往期揭晓
    if ([requestString hasPrefix:@"http://wangqi/" ]){
        
        PassedSnatchViewController *passV = [[PassedSnatchViewController alloc] init];
        passV.goodID = _goodID;
        [self.navigationController pushViewController:passV animated:YES];
        return NO;
    }
    
    // 晒单
    if ([requestString hasPrefix:@"http://shaidan/" ]){
        if (![UserDataManager sharedUserDataManager].userIsLogIn) {
            LoginViewController *loginv = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginv animated:YES];
            return NO;
        }
        NSString *winGoodsId = [requestString substringFromIndex:15];
        ShowMyViewController *showMyViewController = [[ShowMyViewController alloc] init];
        showMyViewController.goodsid = winGoodsId;
        [self.navigationController pushViewController:showMyViewController animated:YES];
        return NO;

    }
    
    // 加入购物车
    if ([requestString hasPrefix:@"http://addcart/" ]){
        if (![UserDataManager sharedUserDataManager].userIsLogIn) {
            LoginViewController *loginv = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginv animated:YES];
            return NO;
        }
        NSString *winGoodsId = [requestString substringFromIndex:15];

        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CART_ADD] forKey:REQ_CODE];
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
        
        [dict setObject:winGoodsId forKey:@"gid"];
        [self.httpManager sendReqWithDict:dict];
        [self.progressView show:YES];
        return NO;

    }
    // 立即参与
    if ([requestString hasPrefix:@"http://buy/" ]){
        if (![UserDataManager sharedUserDataManager].userIsLogIn) {
            LoginViewController *loginv = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginv animated:YES];
            return NO;
        }
        _winGoodsIds = [NSString stringWithFormat:@"%@",[requestString substringFromIndex:11]];
        // 判断是否实名
        [self judgementRealName];
//        [self joinPayPressed];

   
        return NO;
        
    }
    // 进入购物车
    if ([requestString hasPrefix:@"http://tocart/" ]){
        if (![UserDataManager sharedUserDataManager].userIsLogIn) {
            LoginViewController *loginv = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginv animated:YES];
            return NO;
        }
        // 进入购物车
        ShoppingCartViewController *shoppingCartViewController = [[ShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shoppingCartViewController animated:YES];
        return NO;
        
    }
    
    else if ([requestString hasSuffix:@"tel:"]){
        
        
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

//TODO:点击事件
- (void)toBtnPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 隐藏参加界面
        case 10001:
        {
           [self cancelAddView];
        }
            break;
            
        default:
            break;
    }
}

//TODO:增加数目
- (void)addNumSnatch{
    NSInteger aNum = [_addCountersignView.numTextField.text integerValue] + [_detaiNode.step integerValue];
    if (aNum > _detaiNode.less) {
        [self showProgressWithString:@"已经是最大可选数量" hiddenAfterDelay:1];
        return;
    }
    
    _addCountersignView.numTextField.text = [NSString stringWithFormat:@"%ld",(long)aNum];
    
   
    
}

//TODO:减少数目
- (void)lessNumSnatch{
    NSInteger aNum = [_addCountersignView.numTextField.text integerValue] - [_detaiNode.step integerValue];
    if (aNum < [_detaiNode.start integerValue]) {
        [self showProgressWithString:@"已经是最小可选数量" hiddenAfterDelay:1];
        return;
    }
    _addCountersignView.numTextField.text = [NSString stringWithFormat:@"%ld",(long)aNum];

}

//TODO:显示参与选择
- (void)showAddContersignView{
    if (_addCountersignView){
        [_addCountersignView removeFromSuperview];
        _addCountersignView = nil;
    }
    _bgHiddenBtn.hidden = NO;
    _addCountersignView = [[AddCountersignView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
   
    _addCountersignView.delegate = self;
    _addCountersignView.dNode = _detaiNode;
     [_addCountersignView showInView:self.view];
}

//TODO:夺宝
- (void)addSnatch:(NSInteger )num{
  
    NSMutableDictionary *goodDict = [NSMutableDictionary dictionary];
    
    [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [goodDict setObject:_detaiNode.Sid forKey:@"gid"];
    //            [_goodDiC setObject:_moneyLab.text forKey:@"pice"];
    [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)num] forKey:@"count"];
    [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)num * 100] forKey:@"pice"];
    
    SnatchPayViewController *snatchPayViewController = [[SnatchPayViewController alloc] init];
    snatchPayViewController.payStyle = publicPayStyle;
    snatchPayViewController.payDict = goodDict;
    [self.navigationController pushViewController:snatchPayViewController animated:YES];

    
}

//TODO:取消参加
- (void)cancelAddView{
        _bgHiddenBtn.hidden = YES;
   [_addCountersignView cancelPicker];


}

//TODO:弹出提示
- (void)showAlertMsgPressed:(NSString *)msg{
    [self showProgressWithString:msg hiddenAfterDelay:1];
}



//-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    
// 
//   [_addCountersignView.numTextField resignFirstResponder];
//   
//}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetDetilsList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_DETAILS] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_goodID forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:立即参与
- (void)joinPayPressed{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CANADD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    [dict setObject:_winGoodsIds forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:判断是否实名
- (void)judgementRealName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_ISREALNAME] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
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
            // 添加成功
        case REQ_SNATCH_CART_ADD:{
            [self showProgressWithString:@"添加购物车成功" hiddenAfterDelay:1];
            
        }
            break;
            // 获取参与信息
        case REQ_SNATCH_CANADD:{
            NSDictionary *dict = [resultDict objectForKey:RESP_CONTENT];
            _detaiNode = [[SnatchDetailNode alloc] initWithDict:dict];
            [self showAddContersignView];
            
        }
            break;
            // 是否实名
        case REQ_ISREALNAME:{
            NSDictionary *infoDict =[resultDict objectForKey:RESP_CONTENT];
            NSInteger realy = [[infoDict objectForKey:@"realy"] integerValue];
            if (realy == 1) {
                // 可以兑换
                [self joinPayPressed];
            }else{
                AddBankViewController *bankV = [[AddBankViewController alloc] init];
                [self.navigationController pushViewController:bankV animated:YES];
            }
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
        case REQ_SNATCH_DETAILS:
            // 获取参与信息
        case REQ_SNATCH_CANADD:
            // 添加成功
        case REQ_SNATCH_CART_ADD:{
     
        }
                 break;
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
}



@end
