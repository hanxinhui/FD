//
//  AddBankViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:添加银行卡

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface AddBankViewController : BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
 
}


@property (nonatomic, strong) UIWebView *conWebView;//加载界面


@end

