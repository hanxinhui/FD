//
//  BaseViewController.h
//  FD
//
//  Created by leo xu on 14-10-16.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPManager.h"
#import "MBProgressHUD.h"
#import "FontDefine.h"
#import "RDVTabBarController.h"
#import "LXActivity.h"

@interface BaseViewController : UIViewController<HTTPManagerDelegate,LXActivityDelegate>


//导航栏背景
@property (nonatomic, retain) UIImageView *headerView;
@property (nonatomic, retain) UIImageView *headerBgView;
@property (nonatomic, retain) UIImageView *dlineImgView;

//整体背景图片
@property (nonatomic, retain) UIImageView *backgroundView;


//标题
@property (nonatomic, retain) UILabel *titleLable;
//左侧按钮
@property (nonatomic, retain) UIButton *leftBtn;
//右侧按钮
@property (nonatomic, retain) UIButton *rightBtn;
//小菊花
@property (nonatomic, retain) MBProgressHUD *progressView;
@property (nonatomic, retain) MBProgressHUD *MSGprogressView;
//@property (nonatomic, retain) MBProgressHUD *msgProgressView;

//网络连接
@property (nonatomic, retain) HTTPManager *httpManager;

//statuesBar颜色 ios7使用
@property (nonatomic, retain) UIColor *statusColor;
//statuesBar样式 ios7使用
@property (nonatomic, assign) BOOL statusLight;
//状态条图片
@property (nonatomic, retain) UIImageView* statusBarView;

// 头部样式
- (void)setStatusSytle;

//加载样式
-(void)setProgressViewLoadingStyle;

//TODO:显示progress
-(void)showProgressWithString:(NSString *)string hiddenAfterDelay:(float)delay;
////TODO:显示progress
//-(void)showProgressWithString:(NSString *)string hiddenAfterDelay:(float)delay;

//TODO:显示分享
- (void)showShareView;


@end
