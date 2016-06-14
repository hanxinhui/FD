//
//  RegisterViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:注册

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface RegisterViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    float setHeight;//设置高度
   
}


@property (nonatomic, strong)  CustomTextField *phoneTextField;    // 手机号
@property (strong, nonatomic)  UIButton             *phoneTextBtn;//手机号清除
@property (strong, nonatomic)  UIButton             *dealBtn;//手机号清除

@end

