//
//  SignUpViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:签到

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum {
    SignIng,// 签到
    SignExplain // 说明
} SignUpStyle;



@interface SignUpViewController :  BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
    
}

@property (nonatomic, strong) UIWebView  *signWebView;// 详情
@property (nonatomic) SignUpStyle   signUpStyle;// 类型

@end

