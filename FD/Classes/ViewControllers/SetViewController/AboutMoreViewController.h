//
//  AboutMoreViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:帮助第二层

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface AboutMoreViewController : BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) NSString *moreUrl;// 更多链接
@property (nonatomic, strong) UIWebView *conWebView;//加载界面

@end

