//
//  BuyDetailViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:详情

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BuyDetilView.h"
#import "BuyDetailNode.h"

@interface BuyDetailViewController : BaseViewController<UIWebViewDelegate,BuyDetilViewDelegate,UIScrollViewDelegate>
{
    float setHeight;//设置高度
    float setChangeH;
    NSInteger   missionS;// 状态
    float setDownH;
    
    BOOL  isFav;// 是否关注
    
    
    BOOL  isGetTask;// 是否领任务
    
    BOOL  isFirstShare;// 第一次分享
}


@property (nonatomic, strong) UIWebView         *conWebView;//加载界面
@property (nonatomic, strong) NSString          *goodID;//商品id
@property (nonatomic, strong) NSString          *jsonString;//数据
@property (nonatomic, strong) BuyDetailNode     *buyDetailNode;//数据
@property (nonatomic, strong) UIView            *footView;//底部界面
@property (nonatomic, strong) UIButton          *taskBtn;//任务
@property (nonatomic, strong) UIButton          *backBtn;//返回
@property (nonatomic, strong) UIButton          *favBtn;//收藏
@property (nonatomic, strong) BuyDetilView      *buyDetilView;//确认任务
@property (nonatomic, strong) NSString          *mid;//任务id
@property (nonatomic, strong) UIButton          *bgHiddenBtn;//
@property (nonatomic, strong) UIView            *showHeadView;//显示头部界面

@property (nonatomic, strong) UIImageView            *shareImgView;//分享的图片


@end

