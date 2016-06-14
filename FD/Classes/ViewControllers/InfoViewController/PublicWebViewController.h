//
//  PublicWebViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:webView

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


typedef enum {
    WebWithPay,// 充值
    WebWithShare, // 分享
} PublicWebStyle;


@interface PublicWebViewController : BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
 
}


@property (nonatomic, strong) UIWebView *conWebView;//加载界面
@property (nonatomic, strong) NSString  *webUrl;//地址
@property (nonatomic, strong) NSString  *webName;//名称
@property (nonatomic) PublicWebStyle       webStyle;// 请求类型
@property (nonatomic, strong) NSString  *shareUrl;//分享链接
@property (nonatomic, assign) BOOL      isSnatch;//是意愿抢宝


@end

