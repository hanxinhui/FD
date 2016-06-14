//
//  HelpViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:帮助

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface HelpViewController : BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isFIn;// 第一次进入
}


@property (nonatomic, strong) UIWebView *conWebView;//加载界面

@end

