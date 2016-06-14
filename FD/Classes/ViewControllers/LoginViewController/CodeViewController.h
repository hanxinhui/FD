//
//  CodeViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:验证码

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface CodeViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    float setHeight;//设置高度
    BOOL    timeStart;

}


@property (nonatomic, strong)  CustomTextField  *codeTextField;    // 验证码
@property (strong, nonatomic)  UIButton             *codeTextBtn;//验证码清除

@property (nonatomic, strong)  UIButton         *reSetBtn;    // 重新发送
@property (nonatomic, strong)  UILabel           *timeLab;//倒计时

@property (nonatomic, assign)  float                expCode;    // 倒计时
@property (nonatomic, strong)  NSString            *phoneNum;    // 手机号码
@property (nonatomic, strong)  NSString            *codeID;    // 序号

@end

