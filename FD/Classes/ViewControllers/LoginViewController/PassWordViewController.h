//
//  PassWordViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:输入密码

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface PassWordViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong)  CustomTextField *pdTextField;    // 密码
@property (strong, nonatomic)  UIButton             *pdTextBtn;//手机号清除
@property (nonatomic, strong)  CustomTextField *rePDTextField;    // 重复密码
@property (strong, nonatomic)  UIButton             *rePDTextBtn;//手机号清除

@property (nonatomic, strong)  NSString            *phoneNum;    // 手机号码

@end

