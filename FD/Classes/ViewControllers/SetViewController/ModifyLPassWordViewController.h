//
//  ModifyLPassWordViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:修改密码

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface ModifyLPassWordViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong)  CustomTextField *opdTextField;    // 原密码
@property (strong, nonatomic)  UIButton             *opdTextBtn;//原密码清除

@property (nonatomic, strong)  CustomTextField *pdTextField;    // 密码
@property (strong, nonatomic)  UIButton             *pdTextBtn;//密码清除

@property (nonatomic, strong)  CustomTextField *rePDTextField;    // 重复密码
@property (strong, nonatomic)  UIButton             *rePDTextBtn;//重复密码清除

@property (nonatomic, strong)  NSString            *phoneNum;    // 手机号码

@end

