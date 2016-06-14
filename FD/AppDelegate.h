//
//  AppDelegate.h
//  FD
//
//  Created by leoxu on 15/6/15.
//  Copyright (c) 2015年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "InfoViewController.h"
#import "LLLockViewController.h"
#import "EAIntroView.h"
//#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WXApiObject.h"
//#import <TencentOpenAPI/QQApi.h>
//#import <TencentOpenAPI/QQApiInterface.h>
#import <MessageUI/MessageUI.h>

#define UMENG_APPKEY @"4eeb0c7b527015643b000003"

@interface AppDelegate : UIResponder <UIApplicationDelegate,RDVTabBarControllerDelegate,EAIntroDelegate,WXApiDelegate,MFMessageComposeViewControllerDelegate>
{
    NSInteger nowImg;// 当前广告图片位置
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) HomeViewController        *homeViewController;
@property (strong, nonatomic) FindViewController        *findViewController;
@property (strong, nonatomic) InfoViewController        *infoViewController;
@property (strong, nonatomic) RDVTabBarController       *tabBarController;

@property (strong, nonatomic) UIView        *adViews;//开机广告界面
@property (strong, nonatomic) UIImageView        *adImgView;//开机广告
@property (strong, nonatomic) UIButton        *hiddenBtn;//隐藏按钮
@property (nonatomic , strong) NSMutableArray      *imgsArr;//图片数据
@property (nonatomic , strong) NSMutableArray      *timesArr;//时间数据
@property (nonatomic , assign) BOOL         isInfo;//时间数据
@property (nonatomic , assign) BOOL         isLoginAgain;//重新登录
@property (nonatomic , assign) BOOL         isModifyPoint;//修改手势密码
@property (nonatomic , assign) BOOL         isPayWX;//是否是微信支付 NO则为充值


// 手势解锁相关
@property (strong, nonatomic) LLLockViewController* lockVc; // 添加解锁界面



- (void)showLLLockViewController:(LLLockViewType)type;
- (void)showAdds;// 显示开机广告

//=================微信分享================
/**   函数名称 :openWeixin
 **   函数作用 :TODO:打开
 **   函数参数 :
 **   函数返回值:
 **/
-(void)openWeixin;
/**   函数名称 :sharePhotoToWeixinFriends
 **   函数作用 :TODO:分享图片到微信朋友
 **   函数参数 :
 **   函数返回值:
 **/
-(void)sharePhotoToWeixinFriends:(UIImage *)img description:(NSString *)desc title:(NSString *)title webpageUrl:(NSString *)url;
/**   函数名称 :shareMsgToWeixin
 **   函数作用 :TODO:分享图片到微信
 **   函数参数 :
 **   函数返回值:
 **/
- (void)sharePhotoToWeixin:(UIImage *)img description:(NSString *)desc scene:(int )sce webpageUrl:(NSString *)url;

/**   函数名称 :shareMsgToQQ
 **   函数作用 :TODO:分享到QQ
 **   函数参数 :
 **   函数返回值:
 **/
//- (void)shareMsgToQQ:(NSString *)msg;


/**   函数名称 :showSMSPicker
 **   函数作用 :TODO:分享到短信
 **   函数参数 :
 **   函数返回值:
 **/
-(void)showSMSPicker:(NSString *)msg webpageUrl:(NSString *)url;
@end

extern AppDelegate *app;
