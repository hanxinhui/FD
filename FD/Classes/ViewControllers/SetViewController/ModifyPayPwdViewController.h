//
//  ModifyPayPwdViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:修改支付密码|| 修改手机号

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface ModifyPayPwdViewController : BaseViewController<UITextFieldDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) CustomTextField  *pwdTextField;// 新密码
@property (strong, nonatomic)  UIButton             *pwdTextBtn;//新密码清除

@property (nonatomic, strong) CustomTextField  *rePwdTextField;// 重复密码
@property (strong, nonatomic)  UIButton             *rePwdTextBtn;//重复密码清除

@property (nonatomic, strong) NSString  *verNum;// 验证码

@end

