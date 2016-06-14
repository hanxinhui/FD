//
//  ModifyPayPwdViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ModifyPayPwdViewController.h"


@interface ModifyPayPwdViewController ()


@end

@implementation ModifyPayPwdViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.backgroundView .backgroundColor = UIColorWithRGB(0, 0, 0, 0.8);
    self.titleLable.textColor = [UIColor whiteColor];
    self.headerBgView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.statusBarView.backgroundColor = [UIColor clearColor];
    self.dlineImgView.hidden = YES;
    self.titleLable.text = @"修改支付密码";


    //设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODIFY_PPD_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODIFY_PPD_FAILED object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifySuccess) name:MODIFY_PPD_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyFailed:) name:MODIFY_PPD_FAILED object:nil];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 50)];
    lab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lab];
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:13];
    lab.textAlignment = NSTextAlignmentCenter;
    
    setHeight = setHeight + 30;

   
    // 新密码
    _pwdTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _pwdTextField.backgroundColor = [UIColor clearColor];
    _pwdTextField.font = defaultFontSize(21);
    _pwdTextField.textColor = [UIColor whiteColor];
    _pwdTextField.delegate = self;
    _pwdTextField.secureTextEntry = YES;
    _pwdTextField.verticalPadding = 2;
    [_pwdTextField becomeFirstResponder];
    [self.view addSubview:_pwdTextField];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight+ 40, iPhoneWidth - 40, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [self.view addSubview:imgView];
    // 清除密码
    _pwdTextBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _pwdTextBtn.backgroundColor = [UIColor clearColor];
    [_pwdTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_pwdTextBtn addTarget:self action:@selector(clearPwdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pwdTextBtn];
    _pwdTextBtn.hidden = YES;

    
    setHeight = setHeight + 60;

    // 重复密码
    _rePwdTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _rePwdTextField.backgroundColor = [UIColor clearColor];
    _rePwdTextField.font = defaultFontSize(21);
    _rePwdTextField.textColor = [UIColor whiteColor];
    _rePwdTextField.verticalPadding = 2;
    [_rePwdTextField becomeFirstResponder];
    _rePwdTextField.delegate = self;
    _rePwdTextField.secureTextEntry = YES;

    [self.view addSubview:_rePwdTextField];
    UIImageView *aimgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight+ 40, iPhoneWidth - 40, 1)];
    aimgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    aimgView.alpha = 0.5;
    [self.view addSubview:aimgView];
    // 清除密码
    _rePwdTextBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _rePwdTextBtn.backgroundColor = [UIColor clearColor];
    [_rePwdTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_rePwdTextBtn addTarget:self action:@selector(clearRePDTextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rePwdTextBtn];
    _rePwdTextBtn.hidden = YES;

    
    setHeight = setHeight + 60;

    _pwdTextField.placeholder = @"支付密码";
    _rePwdTextField.placeholder = @"确定支付密码";
    
    
    //确认
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0, 0, 50, 50);
    sureBtn.frame = CGRectMake(20, setHeight, iPhoneWidth - 40, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.textColor = [UIColor blackColor];
    sureBtn.backgroundColor = [UIColor grayColor];
    [sureBtn addTarget:self action:@selector(sureBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);

    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_pwdTextField resignFirstResponder];
    [_rePwdTextField resignFirstResponder];
}

//TODO:获取验证码
- (void)setVerNum:(NSString *)verNum{
    _verNum = verNum;
}

#pragma mark ============ UITextFieldDelegate ============
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _pwdTextField) {
        _pwdTextBtn.hidden = NO;
        
    }else{
        _rePwdTextBtn.hidden = NO;
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _pwdTextField) {
        _pwdTextBtn.hidden = YES;
        
    }else{
        _rePwdTextBtn.hidden = YES;
        
    }
}

//TODO:清除
- (void)clearPwdAction{
    _pwdTextField.text = nil;
    [_pwdTextField becomeFirstResponder];

}

//TODO:清楚密码
- (void)clearRePDTextBtnAction{
    _rePwdTextField.text = nil;
    [_rePwdTextField becomeFirstResponder];

}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:确认修改
- (void)sureBtnPressed{
    if ([ShareDataManager getText:_pwdTextField.text]) {
        NSLog(@"未输入支付密码");
        [self showProgressWithString:@"未输入支付密码" hiddenAfterDelay:1];

        return;
        
    }
    if ([ShareDataManager getText:_rePwdTextField.text]) {
        NSLog(@"请输入重复密码");
        [self showProgressWithString:@"请输入重复密码" hiddenAfterDelay:1];

        return;
        
    }
    if ( _pwdTextField.text.length != 6){
        NSLog(@"不在规定范围");
        [self showProgressWithString:@"支付密码为6位数" hiddenAfterDelay:1];

        return;
    }
    
    
    if (![_pwdTextField.text isEqualToString:_rePwdTextField.text]) {
        NSLog(@"两次输入密码不一致");
        [self showProgressWithString:@"两次输入密码不一致" hiddenAfterDelay:1];
        return;
        
    }
//    if (_pwdTextField.text.length < 6 || _pwdTextField.text.length > 30){
//        NSLog(@"请输入6到30位字符密码");
//        return;
//        
//    }

    [self.progressView show:YES];
    NSString *opas = [MHCommonTool stringToShaValue:_pwdTextField.text];
    [[NSUserDefaults standardUserDefaults] setObject:opas forKey:MODIFY_PPD];
    [[UserDataManager sharedUserDataManager] ModifyPayPD:_verNum password:opas];
 
}


//TODO:修改成功
- (void)modifySuccess{
    [self.progressView hide:YES];
    
    [self showProgressWithString:@"修改成功" hiddenAfterDelay:1];
    // 返回
    NSArray *ctrlArray = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 3] animated:YES];
    
    
    
}


//TODO:修改失败
- (void)modifyFailed:(NSNotification*)notification{
    [self.progressView hide:YES];
//    NSString *msg = [notification object];
    [self showProgressWithString:@"修改失败" hiddenAfterDelay:1];
    
}


@end
