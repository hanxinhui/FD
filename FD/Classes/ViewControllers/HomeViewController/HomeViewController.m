//
//  HomeViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MyTasksViewController.h"
#import "QRCodeReaderViewController.h"
#import "RMDownloadIndicator.h"
#import "AnyTimeBuyViewController.h"
#import "ShopViewController.h"
#import "SnatchViewController.h"
#import "MyNewsListViewController.h"
#import "AppDelegate.h"
#import "MyConsListViewController.h"
#import "MoreViewController.h"
#import "OpenAdNode.h"
#import "SetViewController.h"
#import "WebLoginViewController.h"
#import "SignUpViewController.h"

#define CELL_HIGHT     200

@interface HomeViewController ()
@property (weak, nonatomic) RMDownloadIndicator *closedIndicator;


@end

@implementation HomeViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    //    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"首页";
    self.headerView.hidden = YES;
    //    self.statusColor = UIColorWithRGB(255, 255, 255, 0.5);
    self.statusColor = [UIColor clearColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 登录成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinished) name:USER_DID_LOG_IN object:nil];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openGestureFailed) name:ISOPENGESTUREFAIL object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
    
    setHeight = IOS7?20:0;
    
    [self initNavBar];
    //    setHeight = setHeight + NVARBAR_HIGHT;
    
    _listDataArr = [NSMutableArray array];
    
    isfirstLoad = YES;
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - 0 - TARBAR_HIGHT)];
    _conTabView.delegate = self;
    _conTabView.canMove = YES;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = NO;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
    isAnm = NO;
    // 头部内容
    _showHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, NVARBAR_HIGHT+20)];
    _showHeadView.backgroundColor = UIColorWithRGB(255, 255, 255, 0.9);
    [self.view addSubview:_showHeadView];
    //    _showHeadView.hidden = YES;
    _showHeadView.alpha = 0.0;
    
    // 左边按钮 扫描二维码
    _zxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _zxBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [_zxBtn setImage:[UIImage imageNamed:@"Home_left_w.png"] forState:UIControlStateNormal];
    _zxBtn.backgroundColor = [UIColor clearColor];
    [_zxBtn addTarget:self action:@selector(zxPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zxBtn];
    
    // 用户按钮
    _userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userBtn.frame = CGRectMake((iPhoneWidth - 50 ) / 2, 0, 50, 50);
    [_userBtn setImage:[UIImage imageNamed:@"Home_head_big.png"] forState:UIControlStateNormal];
    _userBtn.backgroundColor = [UIColor clearColor];
    //    [_userBtn addTarget:self action:@selector(userPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [_showHeadView addSubview:_userBtn];
    
    // 右边按钮 菜单按钮
    _listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _listBtn.frame = CGRectMake(iPhoneWidth - 50, setHeight, 50, 50);
    [_listBtn setImage:[UIImage imageNamed:@"Home_right_w.png"] forState:UIControlStateNormal];
    _listBtn.backgroundColor = [UIColor clearColor];
    [_listBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_listBtn];
    
    // 列表头部内容
    _homeHeadView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 400- 110 + iPhoneWidth/ 4)];
    _homeHeadView.backgroundColor = [UIColor clearColor];
    _homeHeadView.delegate = self;
    _conTabView.table.tableHeaderView = _homeHeadView;
    
    _page = 1;
    [self addDownloadIndicators];
    
    isLoading = NO;
    isallRe = NO;
    nowY = 0.0;
    nowRow = 0;
    [self setTheAdViews];// 设置开机广告
    
//    // 抽奖界面
//    _layWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth , iPhoneHeight -  TARBAR_HIGHT)];
//    _layWebView.delegate = self;
//    _layWebView.backgroundColor = [UIColor clearColor];
//    NSString *urlS = [NSString stringWithFormat:@"%@%ld",SERVER_HOME_LAY,(long)[UserDataManager sharedUserDataManager].userData.UID];
//    [_layWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlS]]];
//    _layWebView.opaque = NO;
    
//    _closeLayBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 100, setHeight, 50, 50)];
//    _closeLayBtn.backgroundColor = [UIColor clearColor];
//    [_layWebView addSubview:_closeLayBtn];
//    [_closeLayBtn addTarget:self action:@selector(closeLayPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview: _layWebView];
//    _layWebView.hidden = YES;
//    _layWebView.hidden = NO;

//    BOOL isT = [self isFirstLag];
//    if (isT) {
//        _layWebView.hidden = NO;
//
//    }

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


//TODO:设置开机广告
- (void)setTheAdViews{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_LOADINGAD] forKey:REQ_CODE];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


//TODO:获取最新版本
- (void)getVersionHttp{
    NSString *url = [[NSString alloc] initWithFormat:SERVER_APPSTORE_VERSION];
    
    [self Postpath:url];

    //    [self.progressView show:YES];
}
#pragma mark -- 获取数据
-(void)Postpath:(NSString *)path
{
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
            }else{
                
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
        }else{
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
        [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
    }];
    
}
-(void)receiveData:(id)sender
{
    NSLog(@"receiveData=%@",sender);
    NSDictionary *releaseInfo = (NSDictionary *)sender;
    NSString *latestVersion = [releaseInfo objectForKey:@"version"];

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    if ([currentVersion floatValue] < [latestVersion floatValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"有新版本是否更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立刻更新", nil];
        [alert show];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:latestVersion forKey:APPSTORE_VERSION];
}
//TODO:网络请求 首页数据
- (void)reqHttpHomeList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_HOME_LIST] forKey:REQ_CODE];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}
//TODO:网页登陆
- (void)loginToWeb{
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        LoginViewController *loginv = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginv animated:YES];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_HOME_LOGINWEB] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    [dict setObject:[UserDataManager sharedUserDataManager].userData.UPassWord forKey:@"pwd"];
    [dict setObject:_zxCode forKey:@"code"];
    
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:加载 进度框
- (void)addDownloadIndicators
{
    [_closedIndicator removeFromSuperview];
    _closedIndicator = nil;
    
    
    
    RMDownloadIndicator *closedIndicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake(-1, -1, 86, 86) type:kRMClosedIndicator];
    [closedIndicator setBackgroundColor:[UIColor clearColor]];
    //    [closedIndicator setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [closedIndicator setFillColor:[UIColor clearColor]];
    
    [closedIndicator setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    closedIndicator.radiusPercent = 0.45;
    [_homeHeadView.headImgView addSubview:closedIndicator];
    
    [closedIndicator loadIndicator];
    _closedIndicator = closedIndicator;
    
}

//#pragma mark -
//#pragma mark ============ UIWebViewDelegate ============
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *requestString = [[request URL] absoluteString];
//    NSLog(@"requestString is======== %@",requestString);
//
//    // 抽奖成功返回
//    if([requestString hasPrefix:@"http://www.ihuluu.com/-1"]){
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd"];
//        // 当前时间
//        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
//        [[NSUserDefaults standardUserDefaults] setObject:dateTime forKey:TIME_HOME_LAT];
//        _layWebView.hidden = YES;
//        return NO;
//        
//    }
//    // 关闭
//    else if ([requestString hasPrefix:@"http://www.ihuluu.com/-2"]){
//        _layWebView.hidden = YES;
//
//        
//        return NO;
//    }
//    // 进入用户中心
//    else if ([requestString hasPrefix:@"http://www.ihuluu.com/1"]){
//        [[self rdv_tabBarController] setTheViewController:2];
//
//        
//        return NO;
//    }
//    // 登陆
//    else if ([requestString hasPrefix:@"http://www.ihuluu.com/0"]){
//        
//        LoginViewController *loginv = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:loginv animated:YES];
//        return NO;
//    }
//    else{
//        return YES;
//    }
//}
//
//// 开始加载
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [self.progressView show:YES];
//}
//
////TODO:加载完成
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    
//    [self.progressView hide:YES];
// 
//    
//}
//
////TODO:加载失败
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [self.progressView hide:YES];
//    
//}

#pragma mark - Update Views
- (void)startAnimations:(float )getDownf
{
    [_closedIndicator setIndicatorAnimationDuration:1.0];
    
    
    [_closedIndicator updateWithTotalBytes:100 downloadedBytes:getDownf];
    
}

#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    
    //    [self reqShopList:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    //    [self reqShopList:_page];
}
#pragma mark -
#pragma mark ======刷新或显示更多获取数据后手动调用完成函数======

-(void)doneLoadMoreTableViewData:(FHTableView *)table
{
    [table doneLoadMoreTableViewData];
}

-(void)doneLoadingTableViewData:(FHTableView *)table
{
    [table doneLoadingTableViewData];
    [table doneLoadMoreTableViewData];
}

//Section 段数
- (NSInteger)numberOfSectionsInTableView:(FHTableView *)ftableView
{
    
    return _listDataArr.count;
}
-(CGFloat)fhtable:(FHTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (NSString *)fhtable:(FHTableView *)table titleForHeaderInSection:(NSInteger)section{
    
    return nil;
    
}
- (UIView *)fhtable:(FHTableView *)table viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath node:(id)node
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HomeNode *hNode =  [_listDataArr objectAtIndex:indexPath.section];
    
    MoreViewController *moreViewController = [[MoreViewController alloc] init];
    moreViewController.webUrl = hNode.Hpath;
    moreViewController.webName = @"详情";
    moreViewController.cID = @"0";
    moreViewController.gID = @"";
    moreViewController.typeS= @"1";
    moreViewController.goodName = @"";
    [self.navigationController pushViewController:moreViewController animated:YES];
}

-(CGFloat)fhtable:(FHTableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HIGHT;
}
-(NSInteger)fhtable:(FHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)fhtable:(FHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HomeCell";
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    HomeNode *node =  [_listDataArr objectAtIndex:indexPath.section];
    
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor clearColor];
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    
    if (indexPath.section < 2) {
        cell.canAim = YES;
    }else{
        cell.canAim = NO;
        
    }
    cell.canAim = YES;
    
    cell.homeNode = node;
    
    if (indexPath.section > 1) {
        //        NSLog(@"nowRow is====== %d",indexPath.section);
        [UIView animateWithDuration:1.5
                              delay:0
             usingSpringWithDamping:0.9
              initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             cell.VICimgView.frame = frame;
                             cell.VICimgView.contentMode = UIViewContentModeScaleAspectFill;
                         } completion:nil];
        //        cell.imgView.hidden = NO;
        //
        //        cell.imgView.hidden = YES;
    }else{
        cell.VICimgView.frame = frame;
        
    }
    //    NSLog(@"nowRow is====== %d",nowRow);
    nowRow = indexPath.section;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
}



-(void)startAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 3;
    [_homeHeadView.loadImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)hiddenLoad{
    _homeHeadView.loadImgView.hidden = YES;
}
//TODO:是否超过滑动高度 隐藏
- (void )isSurpassOriginY:(CGFloat )surpassOriginY
{
    //    NSLog(@"surpassOriginY ======= %f",surpassOriginY);
    _homeHeadView.loadImgView.hidden = YES;
    isAnm = NO;
    
    if (surpassOriginY == 0) {
        _homeHeadView.loadImgView.hidden = NO;
        [self performSelector:@selector(hiddenLoad) withObject:nil afterDelay:3];
        isAnm = YES;
        _homeHeadView.headImgView.frame = CGRectMake((iPhoneWidth - 84  ) / 2, _homeHeadView.headImgView.frame.origin.y   ,  84 , 84);
        _homeHeadView.loginBtn.frame = CGRectMake((iPhoneWidth - 84  ) / 2, _homeHeadView.headImgView.frame.origin.y   ,  84 , 84);
        _homeHeadView.headImgView.layer.cornerRadius= 84 / 2; //最重要的是这个地方要设
        
    }
    //    if (85 - surpassOriginY > 0) {
    //
    //    }
    if (surpassOriginY > 0 && surpassOriginY < 35) {
        [_homeHeadView addSubview:_homeHeadView.headImgView];
        _homeHeadView.headImgView.frame = CGRectMake((iPhoneWidth - 84 * (85 -surpassOriginY) / 85 ) / 2, 20 + 40 * (85 -surpassOriginY) / 85  , 84 * (85 -surpassOriginY) / 85 , 84 * (85 -surpassOriginY) / 85);
        _homeHeadView.loginBtn.frame = CGRectMake((iPhoneWidth - 84 * (85 -surpassOriginY) / 85 ) / 2, 20 + 40 * (85 -surpassOriginY) / 85  , 84 * (85 -surpassOriginY) / 85 , 84 * (85 -surpassOriginY) / 85);
        _homeHeadView.headImgView.layer.cornerRadius=84 * (85 -surpassOriginY) / 85 / 2; //最重要的是这个地方要设
        
    }
    
    if (surpassOriginY < 0 && surpassOriginY > -41)
    {
        _closedIndicator.hidden = NO;
        if (isallRe && nowY < surpassOriginY) {
            return;
        }
        float ff = 0 -  surpassOriginY;
        ff = ff / 40 * 100;
        [self startAnimations:ff];
        if (!isLoading && ff == 50) {
            // 开始刷新
            isLoading = YES;
            // 刷新成功或失败 将状态改为NO
        }
        
        
    }else{
        isallRe = YES;
    }
    if (surpassOriginY >  -1  ) {
        _closedIndicator.hidden = YES;
        isallRe = NO;
        
    }
    if (surpassOriginY > 25) {
        [UIView animateWithDuration:1.0 animations:^{
            _showHeadView.alpha = 1.0;
            [_zxBtn setImage:[UIImage imageNamed:@"Home_left.png"] forState:UIControlStateNormal];
            [_listBtn setImage:[UIImage imageNamed:@"Home_right.png"] forState:UIControlStateNormal];
        }];
        _homeHeadView.headImgView.frame = CGRectMake((iPhoneWidth - 30 ) / 2, 30, 30, 30);
        _homeHeadView.loginBtn.frame = CGRectMake((iPhoneWidth - 30 ) / 2, 30, 30, 30);
        _homeHeadView.headImgView.layer.cornerRadius=15; //最重要的是这个地方要设
        
        [self.view addSubview:_homeHeadView.headImgView];
        [self.view addSubview:_homeHeadView.loginBtn];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _showHeadView.alpha = 0.0;
            [_zxBtn setImage:[UIImage imageNamed:@"Home_left_w.png"] forState:UIControlStateNormal];
            [_listBtn setImage:[UIImage imageNamed:@"Home_right_w.png"] forState:UIControlStateNormal];
        }];
        
    }
    if (surpassOriginY < 0) {
        _homeHeadView.headImgView.frame = CGRectMake((iPhoneWidth - 84 ) / 2, 55, 84, 84);
        [_homeHeadView addSubview: _homeHeadView.headImgView];
        _homeHeadView.loginBtn.frame = CGRectMake((iPhoneWidth - 84 ) / 2, 55, 84, 84);
        [_homeHeadView addSubview: _homeHeadView.loginBtn];
        
        _homeHeadView.headImgView.layer.cornerRadius= 42; //最重要的是这个地方要设
        
    }
    
    nowY = surpassOriginY;
}
//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
    if (!isMove && isAnm) {
        [self startAnimation];
    }
}
#pragma mark - QRCodeReader Delegate Methods
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ============ UIAlertView事件 ============
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"立刻更新"]) {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:ProjectURL]];
        
    }
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:扫描二维码
- (void)zxPressed:(id)sender{
    static QRCodeReaderViewController *reader = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        reader                        = [QRCodeReaderViewController new];
        reader.modalPresentationStyle = UIModalPresentationFormSheet;
    });
    reader.delegate = self;
    
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"Completion with result: %@", resultAsString);
        if (isloginWeb) {
            return;
        }
        if ([resultAsString hasPrefix:@"signin:"]){
       
            _zxCode = [resultAsString substringFromIndex:7];
            NSLog(@"_zxCode: %@", _zxCode);
            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                LoginViewController *loginv = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginv animated:YES];
                return;
            }
            WebLoginViewController *webLoginViewController = [[WebLoginViewController alloc] init];
            webLoginViewController.urlStr = _zxCode;

            [webLoginViewController initWithStyle:ShowLoginWeb];
            [self.navigationController pushViewController:webLoginViewController animated:YES];
            isloginWeb = YES;
//            [self loginToWeb];// 网页登陆
        }else{
            if ([resultAsString hasPrefix:@""] || resultAsString.length == 0 || resultAsString == nil) {
                return;
            }
            WebLoginViewController *webLoginViewController = [[WebLoginViewController alloc] init];
            webLoginViewController.urlStr = resultAsString;

            [webLoginViewController initWithStyle:ShowOtherWeb];

            [self.navigationController pushViewController:webLoginViewController animated:YES];
            isloginWeb = YES;

            return;

        }
    }];
    [self.navigationController pushViewController:reader animated:YES];
    //    [self presentViewController:reader animated:YES completion:NULL];
}

//TODO:进入更多界面
- (void)rightBtnAction:(id)sender{
    if (_homeMoreView) {
        [_homeMoreView removeFromSuperview];
        _homeMoreView = nil;
        
    }
    
    // 初始化界面
    _homeMoreView = [[HomeMoreView alloc] initWithFrame:CGRectMake(0, 0, 140, 155)];
    _homeMoreView.backgroundColor = [UIColor clearColor];
    _homeMoreView.delegate = self;
    if (_popover) {
        [_popover removeFromSuperview];
        _popover = nil;
    }
    _popover = [DXPopover popover];
    [_popover showAtView:sender withContentView:_homeMoreView];
    
}

//TODO:点击进入更多项目事件
- (void)goToMorePressed:(id)sender{
    [_popover dismiss];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        app.isInfo = YES;

        LoginViewController *loginv = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginv animated:YES];
        return;
    }
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag - 100000;
    switch (tag) {
            // 我的消息
        case 0:{
            MyNewsListViewController *myNewsListViewController = [[MyNewsListViewController alloc] init];
            [self.navigationController pushViewController:myNewsListViewController animated:YES];
            
        }
            break;
        case 1:{
            // 我的任务
            MyTasksViewController *myTasksViewController = [[MyTasksViewController alloc] init];
            [self.navigationController pushViewController:myTasksViewController animated:YES];
        }
            break;
        case 2:{
            // 我的关注
            MyConsListViewController *myConsListViewController = [[MyConsListViewController alloc] init];
            [self.navigationController pushViewController:myConsListViewController animated:YES];
        }
            break;
   
        default:
            break;
    }
}

//TODO:任务列表
- (void)taskListPressed{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    AnyTimeBuyViewController *anyTimeBuyViewController = [[AnyTimeBuyViewController alloc] init];
    [self.navigationController pushViewController:anyTimeBuyViewController animated:YES];
}

//TODO:商品列表
- (void)goodsListPressed{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    ShopViewController *shopViewController = [[ShopViewController alloc] init];
    [self.navigationController pushViewController:shopViewController animated:YES];
}

//TODO:抽奖
- (void)layPressed{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    SnatchViewController *snatchViewController = [[SnatchViewController alloc] init];
    [self.navigationController pushViewController:snatchViewController animated:YES];
   
}

//TODO:签到
-(void)registerPressed{
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        app.isInfo = NO;
        
        LoginViewController *loginv = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginv animated:YES];
        return;
    }
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    signUpViewController.signUpStyle = SignIng;
    [self.navigationController pushViewController:signUpViewController animated:YES];
}

////TODO:关闭抽奖界面
//- (void)closeLayPressed{
//    _closeLayBtn.hidden = YES;
//    _layWebView.hidden = YES;
//    
//}

#pragma mark ============ 其他事件 ============
//TODO: 获取网络数据
- (void)getHttpData{
    //    _page = 1;
    //    [self reqShopList:_page];
    
}

//TODO: 登录
- (void)getLoginPressed{
//    app.isInfo = YES;
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}
//TODO: 重新登录
- (void)getLoginAgainPressed{
    [[UserDataManager sharedUserDataManager] reqLoginWithUserName:[UserDataManager sharedUserDataManager].userData.UPhone password:[UserDataManager sharedUserDataManager].userData.UPassWord];
    
    
}




//TODO:登录成功
- (void)loginFinished{
    if (app.isInfo) {
        [[self rdv_tabBarController] setTheViewController:2];
        
    }
    [_homeHeadView.headImgView sd_setImageWithURL:[NSURL URLWithString:[UserDataManager sharedUserDataManager].userData.UAvatar] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];
 
    _homeHeadView.userNameLab.text = [UserDataManager sharedUserDataManager].userData.Unike;
    _homeHeadView.conpLab.text = [UserDataManager sharedUserDataManager].userData.UtodayIn;

}


//TODO:打开手势密码失败
- (void)openGestureFailed{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ISOPENGESTURE];
    [[UserDataManager sharedUserDataManager] clearUserData];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOG_OUT object:nil];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    LoginViewController *loginv = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginv animated:YES];
    
}
//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_DID_LOG_IN object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ISOPENGESTUREFAIL object:nil];
    
}

//TODO:判断是否当天第一次抽奖
- (BOOL)isFirstLag{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 当前时间
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *layTime = [[NSUserDefaults standardUserDefaults] objectForKey:TIME_HOME_LAT];
    NSDate *date1=[formatter dateFromString:layTime];
    NSDate *date2=[formatter dateFromString:dateTime];

    
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    typedef double NSTimeInterval;
    int days=((int)time)/(3600*24);
    if (days > 0 ) {
        
        return YES;

    }else{
        if ([layTime isEqualToString:@""] || layTime.length == 0 || layTime == nil){
            return YES;
        }else{
            return NO;

        }

    }
}

#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 列表
        case REQ_HOME_LIST:
        {
            
            _listDataArr = [resultDict objectForKey:RESP_CONTENT];
            [_conTabView.table reloadData];
            [self getVersionHttp];
            
            //            [self doneLoadingTableViewData:_conTabView];
            
        }
            break;
        case REQ_HOME_LOGINWEB:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            // 开机广告
        case REQ_LOADINGAD:{
            
            NSMutableArray *arr = [NSMutableArray array];
            arr = [resultDict objectForKey:RESP_CONTENT];
            NSMutableArray *imgs = [NSMutableArray array];
            NSMutableArray *names = [NSMutableArray array];
            for (OpenAdNode *node in arr) {
                [imgs addObject:node.src];
                [names addObject:node.time];
            }
            app.imgsArr = imgs;
            app.timesArr = names;
            
            [app showAdds];
            [self reqHttpHomeList];
            
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
            // 首页列表
        case REQ_HOME_LIST:{
        }
            break;
        case REQ_HOME_LOGINWEB:{
            
        }
            break;
            // 开机广告
        case REQ_LOADINGAD:{
            [self reqHttpHomeList];
            
        }
            break;
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}


//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        _homeHeadView.conLab.text = @"别人教你花钱";
        _homeHeadView.conpLab.text = @"我们教你赚钱";
    }else{
        _homeHeadView.conLab.text = @"今日收益";
        _homeHeadView.conpLab.text = [UserDataManager sharedUserDataManager].userData.UtodayIn;
        
    }
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
   [_homeHeadView.headImgView sd_setImageWithURL:[NSURL URLWithString:[UserDataManager sharedUserDataManager].userData.UAvatar] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];
    _homeHeadView.userNameLab.text = [UserDataManager sharedUserDataManager].userData.Unike;
    isloginWeb = NO;
}

//TODO:进入设置界面
- (void)toSetPressed{
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        LoginViewController *loginv = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginv animated:YES];
    }else{
        [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
        
        SetViewController *setViewController = [[SetViewController alloc] init];
        [self.navigationController pushViewController:setViewController animated:YES];
    }
}



@end
