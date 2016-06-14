//
//  SecurityCenteViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:安全中心

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface SecurityCenteViewController : BaseViewController
{
    float setHeight;//设置高度
}

@property (nonatomic, strong) UILabel  *phoneLab;// 手机
@property (nonatomic, strong) UILabel  *payPwdLab;// 支付密码
@property (nonatomic, strong) UILabel  *loginPwdLab;//登录密码
@property (nonatomic, strong) UILabel  *emailLab;// 邮箱
@property (nonatomic, strong) UISwitch  *gestureSwitch;// 手势开关
@property (nonatomic, strong) UIButton  *modifySSBtn;// 修改手势
@property (nonatomic, strong) UIImageView  *modifySSImgView;// 修改手势
@property (nonatomic, strong) UILabel   *modifySSLab;// 修改手势


@end

