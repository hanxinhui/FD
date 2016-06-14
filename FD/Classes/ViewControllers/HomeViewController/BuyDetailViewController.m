//
//  BuyDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "BuyDetailViewController.h"
#import "ShowTasksDetailViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "CommentViewController.h"
#import "MoreViewController.h"
#import "BankListViewController.h"


#define SETFOOTHIGH         65  // 底部高度

@interface BuyDetailViewController ()


@end

@implementation BuyDetailViewController


//TODO:初始化导航栏
-(void)initNavBar
{
     
    self.titleLable.textColor = [UIColor clearColor];
    
    self.titleLable.text = @"";
    self.headerBgView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.statusColor = [UIColor clearColor];
    self.dlineImgView.hidden  = YES;
    //返回
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [_backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    _backBtn.backgroundColor = [UIColor clearColor];
    [_backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn] ;
    
    //收藏
    _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _favBtn.frame = CGRectMake(iPhoneWidth - 50, setHeight, 50, 50);
    [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];
    _favBtn.backgroundColor = [UIColor clearColor];
    [_favBtn addTarget:self action:@selector(favBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_favBtn] ;
    
    _shareImgView = [[UIImageView alloc] init];
    isFirstShare = YES;
    
    
}

//TODO:传人id
- (void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
}
//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TASKS_HAVEDONE_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:COMMENT__SUCCESS object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskFinished) name:TASKS_HAVEDONE_SUCCESS object:nil];
    // 评论成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentFinished) name:COMMENT__SUCCESS object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
    
    setChangeH = 0;
    //    setHeight = setHeight + NVARBAR_HIGHT;
    setDownH  = SETFOOTHIGH;
    if (iPhoneWidth > 320) {
        setDownH = SETFOOTHIGH;
    }else{
        setDownH = 45;
    }
    // 初始化界面
    _conWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth , iPhoneHeight - setDownH)];
    _conWebView.delegate = self;
    _conWebView.backgroundColor = [UIColor clearColor];
    NSString *urlS = [NSString stringWithFormat:@"%@%@%@",SERVER_URL,SERVER_ANYTIMEBUY_CON,_goodID];
    [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlS]]];
    [self.view addSubview: _conWebView];
    //    _conWebView.scrollView.pagingEnabled = YES;
    _conWebView.scrollView.clipsToBounds = NO;
    _conWebView.scrollView.delegate = self;
    [_conWebView setOpaque:NO];
    //    _conWebView.scrollView.bounces = NO;// 顶部禁止拖动
    
    [self reqGetDetail];
    
    // 头部内容
    _showHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, NVARBAR_HIGHT+setHeight)];
    //    _showHeadView.backgroundColor = UIColorWithRGB(1, 1, 1, 0.5);
    _showHeadView.backgroundColor = UIColorWithRGB(255, 255, 255, 0.9);
    
    [self.view addSubview:_showHeadView];
    //    _showHeadView.hidden = YES;
    _showHeadView.alpha = 0.0;
    
    [self initNavBar];
    
    
    
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - setDownH, iPhoneWidth, setDownH)];
    _footView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_footView];
    
    // 做任务
    _taskBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth - 80, setDownH)];
    _taskBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [_taskBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_taskBtn setTitle:@"领取任务" forState:UIControlStateNormal];
    [_taskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _taskBtn.tag = 10001;
    _taskBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_footView addSubview:_taskBtn];
    
    // 分享
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 80 , 0 , 80, setDownH)];
    shareBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [shareBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.tag = 10002;
    [_footView addSubview:shareBtn];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"Public_Share_h.png"] forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"Public_Share.png"] forState:UIControlStateSelected];
    
    
    // 隐藏
    _bgHiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    _bgHiddenBtn.backgroundColor = [UIColor blackColor];
    [_bgHiddenBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    _bgHiddenBtn.tag = 10003;
    [self.view addSubview:_bgHiddenBtn];
    _bgHiddenBtn.hidden = YES;
    _bgHiddenBtn.alpha = 0.3;
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is======== %@",requestString);
    //    NSMutableString *comurl = [NSMutableString stringWithString:SERVER_COMMENT_DETAIL];
    //    NSString *comand = [NSString stringWithFormat:SERVER_COMMENT_DETAIL];
    //    [comurl appendFormat:@"%@",comand];
    
    if([requestString hasSuffix:@"#open"]){
        requestString = [requestString substringToIndex:requestString.length - 5];
        NSLog(@"123 is======== %@",requestString);
        MoreViewController *moreViewController = [[MoreViewController alloc] init];
        moreViewController.webUrl = requestString;
        moreViewController.webName = @"更多详情";
        moreViewController.cID = @"0";
        moreViewController.gID = _buyDetailNode.gid;
        moreViewController.typeS= @"1";
        moreViewController.goodName = _buyDetailNode.name;
        [self.navigationController pushViewController:moreViewController animated:YES];
        return NO;
        
    }
    else if ([requestString hasSuffix:@"#fabu"]){
        CommentViewController *commentViewController = [[CommentViewController alloc] init];
        commentViewController.fID = @"0";
        commentViewController.goodID = _buyDetailNode.gid;
        commentViewController.typeStr = @"1";
        commentViewController.nameStr = _buyDetailNode.name;
        
        [self.navigationController pushViewController:commentViewController animated:YES];
        
        
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.y;
    if (offset > 0) {
        if (setChangeH < offset) {
            setChangeH = offset;
            
            //            _showHeadView.hidden = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _showHeadView.alpha = 1.0;
                [_backBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
                if (!isFav) {
                    [_favBtn setImage:[UIImage imageNamed:@"Public_Fav_b.png"] forState:UIControlStateNormal];
                    
                }
            }];
        }else{
            setChangeH = offset;
            
        }
        
    }else{
        setChangeH = offset;
        
        [UIView animateWithDuration:0.5 animations:^{
            _showHeadView.alpha = 0.0;
            [_backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
            if (!isFav) {
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];
                
            }
        }];
    }
    
    [NSObject
     
     cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:)
               withObject:scrollView
               afterDelay:0.3];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.5 animations:^{
        _footView.frame = CGRectMake(0, iPhoneHeight , iPhoneWidth, setDownH );
        
    }];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView

{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:0.5 animations:^{
        _footView.frame = CGRectMake(0, iPhoneHeight - setDownH, iPhoneWidth, setDownH );
        
    }];
}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:关注
- (void)favBtnPressed{
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        app.isInfo = NO;
        LoginViewController *loginview = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginview animated:YES];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_FAV] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_buyDetailNode.gid forKey:@"obj_id"];
    [dict setObject:@"1" forKey:@"type"];
    
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:获取余额
- (void)reqGetBalance{
    // 获取余额
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GETBALANCE] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        app.isInfo = NO;
        
        LoginViewController *loginview = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginview animated:YES];
        return;
    }
    switch (tag) {
            // 领取任务
        case 10001:
        {
            if (isGetTask) {
                // 获取余额
                [self reqGetBalance];
             
            }else{
                // 进入任务
                ShowTasksDetailViewController *showTasksDetailViewController = [[ShowTasksDetailViewController alloc]  init];
                showTasksDetailViewController.isMyTask = NO;
                showTasksDetailViewController.jsonString = _jsonString;
                showTasksDetailViewController.detailNode = _buyDetailNode ;
                [self.navigationController pushViewController:showTasksDetailViewController animated:YES];
            }
            
            
        }
            break;
            // 分享
        case 10002:{
//            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
//                app.isInfo = NO;
//                
//                LoginViewController *loginview = [[LoginViewController alloc] init];
//                [self.navigationController pushViewController:loginview animated:YES];
//                return;
//            }
            [self showShareView];
            
        }
            break;
            // 隐藏
        case 10003:{
            
            [self cancelBuyView];
            
        }
            break;
            
        default:
            break;
    }
}


//TODO:取消确认任务
- (void)cancelBuyView{
    _bgHiddenBtn.hidden = YES;
    [_buyDetilView cancelPicker];
    
}


//TODO:确定确认任务
- (void)sureBuyView{

    float bzj = [[_buyDetailNode.bond stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
    float ye = [[[UserDataManager sharedUserDataManager].userData.Utotal_Free stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
    if (bzj > ye) {
        // 跳到充值
        BankListViewController *controller = [[BankListViewController alloc] init];
        controller.bankStyle = BankWithPay;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }else{
        // -确定确认任务
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_GETTASK] forKey:REQ_CODE];
        
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
        [dict setObject:_buyDetailNode.gid forKey:@"id"];
        [self.httpManager sendReqWithDict:dict];
        [self.progressView show:YES];
        
    }
    
}

//TODO:任务完成
- (void)taskFinished{
    //今日任务已经完成
    _taskBtn.backgroundColor = [UIColor grayColor];
    [_taskBtn setTitle:@"今日任务已经完成" forState:UIControlStateNormal];
    _taskBtn.userInteractionEnabled = NO;
    
}

//TODO:评论成功
- (void)commentFinished{
    [_conWebView reload];
}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetDetail{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DETAIL] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_goodID forKey:@"id"];
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
            // 详情
        case REQ_ANYTIMEBUY_DETAIL:
        {
            self.jsonString = [resultDict objectForKey:RESP_CONTENT];
            _buyDetailNode = [resultDict objectForKey:RESP_NODE];
            [_shareImgView sd_setImageWithURL:[NSURL URLWithString:_buyDetailNode.src] placeholderImage:[UIImage imageNamed:@"icon.png"]];

            if ([_buyDetailNode.attention integerValue] == 1) {
                
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav_h.png"] forState:UIControlStateNormal];
                isFav = YES;
            }else{
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];
                isFav = NO;
                
            }
            _taskBtn.userInteractionEnabled = YES;
            
            missionS = [_buyDetailNode.mission_status integerValue];
            if (missionS > 0) {
                // 可以做任务
                _taskBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
                [_taskBtn setTitle:@"做任务" forState:UIControlStateNormal];
                isGetTask = NO;
                
            }
            else if (missionS == 0){
                //领任务
                _taskBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
                [_taskBtn setTitle:@"领取任务" forState:UIControlStateNormal];
                isGetTask = YES;
            }
            else if (missionS == -1){
                //今日任务已经完成
                _taskBtn.backgroundColor = [UIColor grayColor];
                [_taskBtn setTitle:@"今日任务已经完成" forState:UIControlStateNormal];
                _taskBtn.userInteractionEnabled = NO;
            }
            else if (missionS == -2){
                //任务的领取次数已达设置最大值 不可再领取
                _taskBtn.backgroundColor = [UIColor grayColor];
                [_taskBtn setTitle:@"任务的领取次数已达设置最大值 不可再领取" forState:UIControlStateNormal];
                _taskBtn.titleLabel.numberOfLines = 0;
                _taskBtn.userInteractionEnabled = NO;
                _taskBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                
            }
            else if (missionS == -3){
                //任务的领取次数已达设置最大值 不可再领取
                _taskBtn.backgroundColor = [UIColor grayColor];
                [_taskBtn setTitle:@"今日次数已被领光" forState:UIControlStateNormal];
                _taskBtn.userInteractionEnabled = NO;
                _taskBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                
            }

            
        }
            break;
            // 关注
        case REQ_FAV:{
            isFav = !isFav;
            if (isFav) {
                // 关注成功
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav_h.png"] forState:UIControlStateNormal];
                [self showProgressWithString:@"关注成功" hiddenAfterDelay:1];
                
            }else{
                // 取关成功
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];
                [self showProgressWithString:@"取消关注成功" hiddenAfterDelay:1];
                
            }
        }
            break;
            //领取随时赚任务
        case REQ_ANYTIMEBUY_GETTASK:{
            [self showProgressWithString:@"任务领取成功" hiddenAfterDelay:1];
            NSDictionary *info = [resultDict objectForKey:RESP_CONTENT];
            
            _buyDetailNode.mid = [info objectForKey:@"mid"];
            _buyDetailNode.surplus = [info objectForKey:@"surplus"];
            _buyDetailNode.mstatus = [info objectForKey:@"mstatus"];
            _buyDetailNode.mission_status = [info objectForKey:@"mission_status"];
            missionS = [_buyDetailNode.mission_status integerValue];
            
            [_buyDetilView cancelPicker];
            _bgHiddenBtn.hidden = YES;
            // 可以做任务
            _taskBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
            [_taskBtn setTitle:@"做任务" forState:UIControlStateNormal];
            isGetTask = NO;
   
        }
            break;
            // 获取余额
        case REQ_GETBALANCE:{
            
            [UserDataManager sharedUserDataManager].userData.Utotal_Free  = [resultDict objectForKey:RESP_CONTENT];
            _bgHiddenBtn.hidden = NO;
            if (_buyDetilView) {
                [_buyDetilView removeFromSuperview];
                _buyDetilView = nil;
            }
            _buyDetilView = [[BuyDetilView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _buyDetilView.delegate = self;
            _buyDetilView.dnode = _buyDetailNode;
            _buyDetilView.backgroundColor = [UIColor clearColor];
            [_buyDetilView showInView:self.view];
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
        case REQ_ANYTIMEBUY_DETAIL:{
            [self showProgressWithString:msg hiddenAfterDelay:1];

        }
            break;
            // 关注失败
        case REQ_FAV:{
            [self showProgressWithString:msg hiddenAfterDelay:1];

        }
            break;
        case REQ_GETBALANCE:{
            [self showProgressWithString:@"网络请求失败" hiddenAfterDelay:1];
 
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark - LXActivityDelegate-- 分享

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"========= %d",(int)imageIndex);
    int i = (int)imageIndex ;
    switch (i) {
            //            // 分享到QQ好友
            //        case 0 :
            //            [app shareMsgToQQ:[self shareText]];
            //            break;
            // 分享到微信好友
        case 0 :{
       
            [app sharePhotoToWeixinFriends:_shareImgView.image description:_buyDetailNode.sub_name title:_buyDetailNode.name webpageUrl:WEB_ADDRESS];
        }
    

            break;
            // 分享到微信朋友圈
        case 1 :{
        
            [app sharePhotoToWeixin:_shareImgView.image description:[self shareText] scene:1 webpageUrl:WEB_ADDRESS];
            //            [app shareMsgToWeixin:[self shareText] scene:1];
        }
            
            break;
            // 分享到短信
        case 2 :
            [app showSMSPicker:[self shareText] webpageUrl:WEB_ADDRESS];
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
//    NSString *shareString = [NSString stringWithFormat:SHARE_TEXT,@"测试",ProjectURL];
    
    NSString *shareString = [NSString stringWithFormat:@"%@%@",_buyDetailNode.name,_buyDetailNode.sub_name];
    return shareString;
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}

@end
