//
//  ModifyLPassWordViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ModifyLPassWordViewController.h"
#import "MHCommonTool.h"



@interface ModifyLPassWordViewController ()


@end

@implementation ModifyLPassWordViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    self.backgroundView .backgroundColor = UIColorWithRGB(0, 0, 0, 0.8);
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.text = @"修改登录密码";
    self.headerBgView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.statusBarView.backgroundColor = [UIColor clearColor];
    self.dlineImgView.hidden = YES;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 50);
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODIFY_LPD_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODIFY_LPD_FAILED object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifySuccess) name:MODIFY_LPD_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyFailed:) name:MODIFY_LPD_FAILED object:nil];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.alpha = 0.8;
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    setHeight = setHeight + 30;

    // 原密码
    _opdTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _opdTextField.backgroundColor = [UIColor clearColor];
    _opdTextField.font = defaultFontSize(21);
    _opdTextField.textColor = [UIColor whiteColor];
    _opdTextField.placeholder = @"请输入原始密码";
    _opdTextField.verticalPadding = 2;
//    [_opdTextField becomeFirstResponder];
    [self.view addSubview:_opdTextField];
    _opdTextField.secureTextEntry = NO;
    _opdTextField.delegate = self;
    _opdTextField.secureTextEntry = YES;

    [self setTheLineImg:setHeight + 40];
    // 清除密码
    _opdTextBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _opdTextBtn.backgroundColor = [UIColor clearColor];
    [_opdTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_opdTextBtn addTarget:self action:@selector(clearOpdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_opdTextBtn];
    _opdTextBtn.hidden = YES;
    
    setHeight =  setHeight + 60;
//    _opdTextField.clearButtonMode = UITextFieldViewModeAlways;

    // 密码
    _pdTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _pdTextField.backgroundColor = [UIColor clearColor];
    _pdTextField.font = defaultFontSize(21);
    _pdTextField.textColor = [UIColor whiteColor];
    _pdTextField.placeholder = @"请输入新密码";
    _pdTextField.verticalPadding = 2;
    _pdTextField.delegate = self;
    [self.view addSubview:_pdTextField];
    _pdTextField.secureTextEntry = YES;
    [self setTheLineImg:setHeight + 40];
    // 清除密码
    _pdTextBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _pdTextBtn.backgroundColor = [UIColor clearColor];
    [_pdTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_pdTextBtn addTarget:self action:@selector(clearPdTextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pdTextBtn];
    _pdTextBtn.hidden = YES;
    _pdTextField.secureTextEntry = YES;

    setHeight =  setHeight + 60;
    
    // 重复密码
    _rePDTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _rePDTextField.backgroundColor = [UIColor clearColor];
    _rePDTextField.font = defaultFontSize(21);
    _rePDTextField.textColor = [UIColor whiteColor];
    _rePDTextField.placeholder = @"请确认新密码";
    _rePDTextField.verticalPadding = 2;
//    [_rePDTextField becomeFirstResponder];
    [self.view addSubview:_rePDTextField];
    _rePDTextField.secureTextEntry = YES;
    [self setTheLineImg:setHeight + 40];
    _rePDTextField.delegate = self;
    _rePDTextField.secureTextEntry = YES;

//    _rePDTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 清除密码
    _rePDTextBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _rePDTextBtn.backgroundColor = [UIColor clearColor];
    [_rePDTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_rePDTextBtn addTarget:self action:@selector(clearRePDTextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rePDTextBtn];
    _rePDTextBtn.hidden = YES;
    
    setHeight =  setHeight + 80;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(20, setHeight, iPhoneWidth - 40, 40);
    nextBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg"] forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg_h"] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(nextBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - 40, 40)];
    lab.backgroundColor = [UIColor clearColor];
    [nextBtn addSubview:lab];
    lab.text = @"确认";
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    

}

//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, sizeY-1, iPhoneWidth - 40, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [self.view addSubview:imgView];
}

//TODO:传人手机号
- (void)setPhoneNum:(NSString *)phoneNum{
    _phoneNum = phoneNum;

}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_opdTextField resignFirstResponder];
    [_pdTextField resignFirstResponder];
    [_rePDTextField resignFirstResponder];
}
#pragma mark -
#pragma mark ============ UIAlertViewDelegate ============
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"确定"]) {
        // 进入下一层
    }
    if ([str isEqualToString:@"放弃"]) {
       // 返回
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark ============ UITextFieldDelegate ============
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _opdTextField) {
        _opdTextField.hidden = NO;
        
    }
    else if(textField == _pdTextField){
        _pdTextField.hidden = NO;
        
    }
    else if(textField == _rePDTextField){
        _rePDTextField.hidden = NO;
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _opdTextField) {
        _opdTextField.hidden = YES;
        
    }
    else if(textField == _pdTextField){
        _pdTextField.hidden = YES;
        
    }
    else if(textField == _rePDTextField){
        _rePDTextField.hidden = YES;
        
    }
}

//TODO:清除
- (void)clearOpdAction{
    _opdTextField.text = nil;
    [_opdTextField becomeFirstResponder];

}

//TODO:清楚密码
- (void)clearPdTextBtnAction{
    _pdTextField.text = nil;
    [_pdTextField becomeFirstResponder];

}
//TODO:清楚密码
- (void)clearRePDTextBtnAction{
    _rePDTextField.text = nil;
    [_rePDTextField becomeFirstResponder];

}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
//    // 弹出警告
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否放弃修改" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"继续修改", nil];
//    [alert show];
    [self.navigationController popViewControllerAnimated:YES];

}

//TODO:下一步
- (void)nextBtnPressed{
    if ([ShareDataManager getText:_opdTextField.text]) {
        NSLog(@"未输入原始密码");
        [self showProgressWithString:@"未输入原始密码" hiddenAfterDelay:1];

        return;
        
    }
    if ([ShareDataManager getText:_pdTextField.text]) {
        NSLog(@"未输入新密码");
        [self showProgressWithString:@"未输入新密码" hiddenAfterDelay:1];

        return;
        
    }
    if ([ShareDataManager getText:_rePDTextField.text]) {
        NSLog(@"请输入重复密码");
        [self showProgressWithString:@"请输入重复密码" hiddenAfterDelay:1];

        return;
        
    }
    if (_pdTextField.text.length > 30 || _pdTextField.text.length < 6){
        NSLog(@"不在规定范围");
        [self showProgressWithString:@"不在规定范围" hiddenAfterDelay:1];

        return;
    }
    
  
    if (![_pdTextField.text isEqualToString:_rePDTextField.text]) {
        NSLog(@"两次输入密码不一致");
        [self showProgressWithString:@"两次输入密码不一致" hiddenAfterDelay:1];

        return;
        
    }
//    if (_pdTextField.text.length < 6 || _rePDTextField.text.length > 30){
//        NSLog(@"请输入6到30位字符密码");
//        return;
//
//    }
    [self reqRegister];
    
}



#pragma mark ===============网络请求 ================
//TODO:修改密码
- (void)reqRegister{
    NSString *opas = [MHCommonTool stringToShaValue:_opdTextField.text];
    NSString *pas = [MHCommonTool stringToShaValue:_pdTextField.text];
    [[NSUserDefaults standardUserDefaults] setObject:pas forKey:MODIFY_LPD];
    
    // 注册
    [[UserDataManager sharedUserDataManager] ModifyLoginPD:opas npassword:pas];
    
 
    [self.progressView show:YES];
}


//TODO:修改成功
- (void)modifySuccess{
    [self.progressView hide:YES];
    
    [self showProgressWithString:@"修改成功" hiddenAfterDelay:1];
    // 返回
    NSArray *ctrlArray = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 2] animated:YES];
    
    
    
}


//TODO:修改失败
- (void)modifyFailed:(NSNotification*)notification{
    [self.progressView hide:YES];
    NSString *msg = [notification object];
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}

@end
