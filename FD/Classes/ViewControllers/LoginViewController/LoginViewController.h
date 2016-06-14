//
//  LoginViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:登录

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface LoginViewController : BaseViewController<UITextFieldDelegate>
{
    float setHeight;//设置高度
    
}

@property (strong, nonatomic)  CustomTextField   *phoneTextField;// 手机号
@property (strong, nonatomic)  CustomTextField   *passWordTextField;//密码
@property (strong, nonatomic)  UIButton             *phoneTextBtn;//手机号清除
@property (strong, nonatomic)  UIButton      *passWordBtn;//密码

@end

