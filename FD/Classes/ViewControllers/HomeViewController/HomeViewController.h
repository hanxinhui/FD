//
//  HomeViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:首页

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "HomeCell.h"
#import "HomeHeadView.h"
#import "HomeMoreView.h"
#import "DXPopover.h"
#import "QRCodeReaderDelegate.h"
#import "HomeNode.h"

@interface HomeViewController : BaseViewController<FHTableViewDelegate,HomeHeadViewDelegate,HomeMoreViewDelegate,QRCodeReaderDelegate,UIAlertViewDelegate,UIWebViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新
    
    BOOL  isallRe;// 全圆
    float nowY;//当前位置
    
    NSInteger  nowRow;
    
    BOOL  isfirstLoad;// 是否第一次加载
    BOOL isloginWeb;// 已经登陆web
    
    BOOL  isAnm;// 是否移动
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, strong) HomeHeadView   *homeHeadView;//
@property (nonatomic, strong) HomeMoreView   *homeMoreView;//
@property (nonatomic, strong) DXPopover   *popover;//
@property (nonatomic, strong) UIView    *showHeadView;//显示头部界面
@property (nonatomic, strong) UIButton    *zxBtn;//左边按钮 扫描二维码
@property (nonatomic, strong) UIButton    *listBtn;//右边按钮 菜单
@property (nonatomic, strong) UIButton    *userBtn;//用户按钮 菜单
@property (nonatomic, strong) NSString    *zxCode;//扫描后的码数

//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;

@property (nonatomic ,strong) UIWebView *layWebView;// 抽奖界面
@property (nonatomic ,strong) UIButton *closeLayBtn;// 关闭抽奖界面

//TODO: 获取网络数据
- (void)getHttpData;

//TODO: 登录
- (void)getLoginPressed;
//TODO: 重新登录
- (void)getLoginAgainPressed;
@end

