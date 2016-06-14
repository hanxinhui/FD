//
//  AppDelegate.m
//  FD
//
//  Created by leoxu on 15/6/15.
//  Copyright (c) 2015年 leoxu. All rights reserved.
//

#import "AppDelegate.h"                
#import <AlipaySDK/AlipaySDK.h>

#import "LoginViewController.h"
#import "APService.h"
#import "MobClick.h"

//#define kDurationo 0.7   // 动画持续时间(秒)

@interface AppDelegate ()

@end

@implementation AppDelegate

AppDelegate *app;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    
    // leoxuzero
    //向微信注册
    [WXApi registerApp:WEIXIN_APPID];
    
    app = self;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    _isLoginAgain = NO;
    _isModifyPoint = NO;
    _isPayWX = NO;
    
    [self customizeInterface];

    [self setTheAdViews];// 设置开机广告
    [self isOpenGesture];

    // 开机帮助界面
    if ([[SystemStateManager sharedSystemStateManager] isFirstLaunch]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISSHOW_SCORE];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:RECHARGEABLE_CLOSE];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:SAVE_ANYTIMEDO_SCREEN_FIRST];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:SAVE_ANYTIMEDO_SCREEN_SECOND];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SAVE_ANYTIMEDO_SCREEN_ISYUE];
       
        
        [self showIntroWithCrossDissolve];// 开机引导
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd"];
//        // 当前时间
//        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        [[NSUserDefaults standardUserDefaults] setObject:@"2015-10-01" forKey:TIME_HOME_LAT];
    }

    // 推送相关
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    [APService setupWithOption:launchOptions];
    

    return YES;
}

//TODO:初始化引导
- (void)showIntroWithCrossDissolve {
    NSString *help1;
    NSString *help2;
    NSString *help3;
    NSString *help4;
    
    // 4/4S
    if (iPhoneWidth == 320 && iPhoneHeight<500) {
        help1 = @"help_I4_1";
        help2 = @"help_I4_2";
        help3 = @"help_I4_3";
        help4 = @"help_I4_4";
    }
    else if(iPhone5){
        help1 = @"help_I5_1";
        help2 = @"help_I5_2";
        help3 = @"help_I5_3";
        help4 = @"help_I5_4";
    }
    else if(iPhone6){
        help1 = @"help_I6_1";
        help2 = @"help_I6_2";
        help3 = @"help_I6_3";
        help4 = @"help_I6_4";
    }
    else if(iPhone6plus){
        help1 = @"help_I6P_1";
        help2 = @"help_I6P_2";
        help3 = @"help_I6P_3";
        help4 = @"help_I6P_4";
    }
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:help1];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:help2];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:help3];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:help4];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3,page4]];
    
    [intro setDelegate:self];
    intro.isHelp = NO;
    [intro showInView:self.window animateDuration:0.0];
}


//TODO:开机引导结束
- (void)introDidFinish {
    NSLog(@"Intro callback");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

}


//TODO:设置开机广告
- (void)setTheAdViews{
    if (_adViews) {
        [_adViews removeFromSuperview];
        _adViews = nil;
    }
    _adViews = [[UIView alloc] initWithFrame:self.window.bounds];
    _adViews.backgroundColor = [UIColor whiteColor];
    UIImageView *aadImgView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    aadImgView.backgroundColor = [UIColor clearColor];
    NSString *adBgImg;
    // 4/4S
    if (iPhoneWidth == 320 && iPhoneHeight<500) {
        adBgImg = @"LaunchImage-1-700.png";
    }
    else if(iPhone5){
        adBgImg = @"LaunchImage-1-700-568h.png";
        
    }
    else if(iPhone6){
        adBgImg = @"LaunchImage-1-800-667h.png";
        
    }
    else if(iPhone6plus){
        adBgImg = @"LaunchImage-1-800-Portrait-736h.png";
        
    }
    [aadImgView setImage:[UIImage imageNamed:adBgImg]];
    [_adViews  addSubview:aadImgView];
    [self.window addSubview:_adViews];
    
    nowImg = 0;
    
    _imgsArr = [NSMutableArray array];
    
    _timesArr = [NSMutableArray array];
    // 隐藏按钮
    _hiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.window.frame.size.width - 80, 20, 80, 45)];
    _hiddenBtn.backgroundColor = [UIColor clearColor];
    [_hiddenBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_hiddenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _hiddenBtn.titleLabel.font = defaultFontSize(15);
    [_hiddenBtn addTarget:self action:@selector(hiddenAdds) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:_hiddenBtn];

//    [app showAdds];// 显示开机广告

}

//TODO:显示广告
- (void)sAdds{
    float time = [[_timesArr objectAtIndex:nowImg] floatValue];
    [self performSelector:@selector(showAdds) withObject:@"" afterDelay:time];   // 调用因此广告
    
}

- (void)showAdds{
    if (_adImgView) {
        [_adImgView removeFromSuperview];
        _adImgView = nil;
    }
    _adImgView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    _adImgView.backgroundColor = [UIColor whiteColor];
    
    if (nowImg == _imgsArr.count) {
        [_adViews removeFromSuperview];
        [_hiddenBtn removeFromSuperview];
        return;
    }
    NSString *adBgImg;
    // 4/4S
    if (iPhoneWidth == 320 && iPhoneHeight<500) {
        adBgImg = @"LaunchImage-1-700.png";
    }
    else if(iPhone5){
        adBgImg = @"LaunchImage-1-700-568h.png";

    }
    else if(iPhone6){
        adBgImg = @"LaunchImage-1-800-667h.png";

    }
    else if(iPhone6plus){
        adBgImg = @"LaunchImage-1-800-Portrait-736h.png";

    }
    [_adImgView sd_setImageWithURL:[NSURL URLWithString:[_imgsArr objectAtIndex:nowImg]] placeholderImage:[UIImage imageNamed:adBgImg]];
//    .image = [_imgsArr objectAtIndex:nowImg];
    [_adViews addSubview:_adImgView];
    
    [UIView transitionWithView:_adViews duration:0.6   // 在noteView视图上设置过渡效果
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{

                    }
                    completion:^(BOOL finished){
                        
                    }];
    
    if (nowImg <_imgsArr.count) {
        [self sAdds];
        nowImg = nowImg + 1;
        
    }else{
        [_adViews removeFromSuperview];
        
    }
}



//TODO:隐藏广告
- (void)hiddenAdds{
    [_adViews removeFromSuperview];
    [_hiddenBtn removeFromSuperview];

}

#pragma mark - Methods

- (void)setupViewControllers {
    _homeViewController = [[HomeViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:_homeViewController];
    [_homeViewController.navigationController setNavigationBarHidden:YES animated:NO];

    _findViewController = [[FindViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:_findViewController];
    [_findViewController.navigationController setNavigationBarHidden:YES animated:NO];

    _infoViewController = [[InfoViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:_infoViewController];
    [_infoViewController.navigationController setNavigationBarHidden:YES animated:NO];

    _tabBarController = [[RDVTabBarController alloc] init];
    _tabBarController.delegate = self;
    [_tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController]];
    self.viewController = _tabBarController;
    
    [self customizeTabBarForController:_tabBarController];
    

}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    NSArray *tabBarItemTitles = @[@"首页", @"发现", @"我的"];

    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = [tabBarItemTitles objectAtIndex:index];

        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage setName:lab];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    // 推送相关
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([UserDataManager sharedUserDataManager].userIsLogIn) {
        _isLoginAgain = YES;
        [_homeViewController getLoginAgainPressed];
    }else{
        _isLoginAgain = NO;

    }
    
    // 手势解锁相关
    NSString* pswd = [LLLockPassword loadLockPassword];
    if (pswd) {
        [self showLLLockViewController:LLLockViewTypeCheck];
    } else {
        [self showLLLockViewController:LLLockViewTypeCreate];
    }

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//TODO:选择界面
- (void)getSelectedViewIndex:(NSInteger )index{
    //    NSLog(@"Select==========   %ld",(long)index);
    switch (index) {
        case 0:{
            [_homeViewController getHttpData];
            
        }
            break;
        case 1:{
            [_findViewController getHttpData];
            
        }
            break;
        case 2:{
            [_infoViewController getHttpData];

        }
            break;

        default:
            break;
    }
}

// 登录
- (void)getSelectedLogin:(NSInteger )oldindex{
    //    NSLog(@"Select==========   %ld",(long)index);
    switch (oldindex) {
        case 0:{
            [_homeViewController getLoginPressed];
            
        }
            break;
        case 1:{
            [_findViewController getLoginPressed];

        }
            break;
        case 2:{
            [_infoViewController getHttpData];
        }
            break;
            
        default:
            break;
    }
}

//TODO:是否打开手势
- (void)isOpenGesture{
    // 手势解锁相关
//    NSString* pswd = [LLLockPassword loadLockPassword];
//    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:ISOPENGESTURE];
//    if (pswd && isOpen && [UserDataManager sharedUserDataManager].userIsLogIn) {
        [self showLLLockViewController:LLLockViewTypeCheck];
    //}
}

#pragma mark - 弹出手势解锁密码输入框
- (void)showLLLockViewController:(LLLockViewType)type
{
    if(self.window.rootViewController.presentingViewController == nil){
        
        LLLog(@"root = %@", self.window.rootViewController.class);
        LLLog(@"lockVc isBeingPresented = %d", [self.lockVc isBeingPresented]);
        
        self.lockVc = [[LLLockViewController alloc] init];
        self.lockVc.nLockViewType = type;
        
        self.lockVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self.window.rootViewController presentViewController:self.lockVc animated:NO completion:^{
        }];
        LLLog(@"创建了一个pop=%@", self.lockVc);
    }
}



//TODO:推送相关
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}
// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);

}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{

    return  [WXApi handleOpenURL:url delegate:self];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
  
    
    return  [WXApi handleOpenURL:url delegate:self];
}


// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

#pragma mark -
#pragma mark ========微信方法===========
/**   函数名称 :checkWeixinInstalled
 **   函数作用 :TODO:检查微信是否安装
 **   函数参数 :
 **   函数返回值:
 **/
-(BOOL)checkWeixinInstalled
{
    BOOL installed = [WXApi isWXAppInstalled];
    if (!installed) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"微信未安装，无法分享微信消息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    return installed;
}
//=================微信分享================
/**   函数名称 :openWeixin
 **   函数作用 :TODO:打开
 **   函数参数 :
 **   函数返回值:
 **/
-(void)openWeixin{
    //检查安装
    if (![self checkWeixinInstalled]) {
        return;
    }

    

    [WXApi openWXApp];
    

    
}

/**   函数名称 :sharePhotoToWeixinFriends
 **   函数作用 :TODO:分享图片到微信朋友
 **   函数参数 :
 **   函数返回值:
 **/
-(void)sharePhotoToWeixinFriends:(UIImage *)img description:(NSString *)desc title:(NSString *)title  webpageUrl:(NSString *)url
{
    //检查安装
    if (![self checkWeixinInstalled]) {
        return;
    }
    UIImage *thumbImg = [self OriginImage:img scaleToSize:CGSizeMake(160, 172)];
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:thumbImg];
    message.title = title;
    message.description = desc;
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.scene = WXSceneSession;
//    req.bText = NO;
    req.message = message;
    [WXApi sendReq:req];
    
}

/**   函数名称 :shareMsgToWeixin
 **   函数作用 :TODO:分享图片到微信
 **   函数参数 :
 **   函数返回值:
 **/
-(void)sharePhotoToWeixin:(UIImage *)img description:(NSString *)desc scene:(int )sce webpageUrl:(NSString *)url
{
    //检查安装
    if (![self checkWeixinInstalled]) {
        return;
    }
    UIImage *thumbImg = [self OriginImage:img scaleToSize:CGSizeMake(160, 172)];
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:thumbImg];
    message.title = desc;
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;

    message.mediaObject = ext;

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.scene = WXSceneTimeline;
    req.bText = NO;
    req.message = message;
    [WXApi sendReq:req];
    
}
-(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

///**   函数名称 :shareMsgToQQ
// **   函数作用 :TODO:分享到QQ
// **   函数参数 :
// **   函数返回值:
// **/
//- (void)shareMsgToQQ:(NSString *)msg{
//    // 初始化qq分享
//    TencentOAuth *tencentOAuth  = [[TencentOAuth alloc] initWithAppId:QQ_KEY andDelegate:self];
//    
//    NSString *utf8String = ProjectURL;
//    NSString *title = @"爱葫芦";
//    NSString *description = msg;
//    NSString *previewImageUrl = @"http://www.ihuluu.com/Public/Images/icon/apple-touch-icon-114x114.png";
//    QQApiNewsObject *newsObj = [QQApiNewsObject
//                                objectWithURL:[NSURL URLWithString:utf8String]
//                                title:title
//                                description:description
//                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
//    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
//    if (![QQApiInterface isQQSupportApi]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"QQ未安装，无法分享QQ消息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }else{
//        //将内容分享到qq
////        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//        [QQApiInterface sendReq:req];
//    }
//    
//}

/**   函数名称 :showSMSPicker
 **   函数作用 :TODO:分享到短信
 **   函数参数 :
 **   函数返回值:
 **/
-(void)showSMSPicker:(NSString *)msg webpageUrl:(NSString *)url{
    
   Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
    // Check whether the current device is configured for sending SMS messages
    if ([messageClass canSendText]) {

        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        
        picker.messageComposeDelegate =self;
        
        NSString *smsBody =[NSString stringWithFormat:@"我正在玩“爱葫芦”，新生代的赚钱神器，爱上葫芦里的秘密！赶紧下载吧 %@",url] ;

        picker.body=smsBody;
        [self.window.rootViewController presentViewController:picker animated:YES completion:nil];

    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"设备不支持短信功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        }
    
    }

}
//TODO:分享短信 回调
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MessageComposeResultCancelled:
        {
            //click cancel button
        }
            break;
        case MessageComposeResultFailed:// send failed
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"短信分享失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
            
        case MessageComposeResultSent:
        {
            //do something
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"短信分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        default:
            break;
    } 
    
}



-(void)onResp:(BaseResp *)resp{
    NSString *strTitle;
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if ([resp isKindOfClass:[PayResp class]]) {
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
            {
                NSLog(@"支付结果: 成功!");
                [self setAlertMsg:@"支付成功"];
                if (_isPayWX) {
                    // 支付成功 请求生成口令
                    [[NSNotificationCenter defaultCenter] postNotificationName:WEIXINPAY_SUCCESS object:nil];
   
                }
                
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                [self setAlertMsg:@"支付失败"];

                NSLog(@"支付结果: 失败!");
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                NSLog(@"支付结果: 失败!===  %@",resp.errStr);
                [self setAlertMsg:@"支付失败"];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                NSLog(@"发送失败");
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                NSLog(@"微信不支持");
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                NSLog(@"授权失败");
                [self setAlertMsg:@"授权失败"];

            }
                break;
            default:
                break;
        }
        //------------------------
    }
}

//TODO:显示提示
- (void)setAlertMsg:(NSString *)msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

//TODO:友盟统计
- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
}
@end
