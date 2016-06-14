//
//  ModifyPhoneViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:修改手机号

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface ModifyPhoneViewController : BaseViewController<UITextFieldDelegate>
{
    float setHeight;//设置高度
    BOOL    timeStart;

}

@property (nonatomic, strong) CustomTextField  *phoneTextField;// 新手机号
@property (strong, nonatomic)  UIButton             *phoneTextBtn;//新密码清除
@property (nonatomic, strong)  CustomTextField  *codeTextField;    // 验证码
@property (strong, nonatomic)  UIButton             *codeTextBtn;//验证码清除

@property (nonatomic, strong)  UIButton         *reSetBtn;    // 重新发送
@property (nonatomic, strong)  UILabel           *timeLab;//倒计时

@property (nonatomic, assign)  float                expCode;    // 倒计时

@property (nonatomic, strong)  UILabel                *codeLab;    // 验证码


@end

