//
//  LoginViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MHCommonTool.h"


@interface LoginViewController ()


@end

@implementation LoginViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    self.headerBgView.hidden = YES;
    self.headerView.hidden = YES;
    self.statusBarView.backgroundColor = [UIColor clearColor];
    self.titleLable.text = @"登录";
  
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    

    
}

//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_DID_LOG_IN object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_LOG_IN_FAIL object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinished) name:USER_DID_LOG_IN object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed:) name:USER_LOG_IN_FAIL object:nil];
    
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    self.backgroundView .backgroundColor = UIColorWithRGB(0, 0, 0, 0.8);

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    setHeight =  setHeight + 50;

    
    _phoneTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _phoneTextField.backgroundColor = [UIColor clearColor];
    _phoneTextField.font = defaultFontSize(21);
    _phoneTextField.textColor = [UIColor whiteColor];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.verticalPadding = 2;
    _phoneTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextField];
    [self setTheLineImg:setHeight+ 40];
//    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 清除手机号
    _phoneTextBtn  = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _phoneTextBtn.backgroundColor = [UIColor clearColor];
    [_phoneTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_phoneTextBtn addTarget:self action:@selector(clearPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_phoneTextBtn];
    _phoneTextBtn.hidden = YES;

    setHeight =  setHeight + 60;
    
    // 密码
    _passWordTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _passWordTextField.backgroundColor = [UIColor clearColor];
    _passWordTextField.font = defaultFontSize(21);
    _passWordTextField.textColor = [UIColor whiteColor];
    _passWordTextField.placeholder = @"请输入密码";
    _passWordTextField.verticalPadding = 2;
    _passWordTextField.secureTextEntry = YES;
    _passWordTextField.delegate = self;
//    _passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_passWordTextField];
//    _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 清除手机号
    _passWordBtn  = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _passWordBtn.backgroundColor = [UIColor clearColor];
    [_passWordBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_passWordBtn addTarget:self action:@selector(clearpassWordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_passWordBtn];
    _passWordBtn.hidden = YES;
    
    [self setTheLineImg:setHeight+ 40];
    setHeight =  setHeight + 80;

    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, setHeight, iPhoneWidth - 40, 50);
    loginBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [loginBtn setImage:[UIImage imageNamed:@"next_blue_bg"] forState:UIControlStateNormal];
//    [loginBtn setImage:[UIImage imageNamed:@"next_blue_bg_h"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    setHeight =  setHeight + 70;

    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(20, setHeight, iPhoneWidth - 40, 40);
    nextBtn.backgroundColor = UIColorWithRGB(202, 85, 87, 1);
    nextBtn.backgroundColor = [UIColor clearColor];
    [nextBtn setTitle:@"手机快速注册" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg"] forState:UIControlStateNormal];
//    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg_h"] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(registerPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
 
    [self.view bringSubviewToFront:self.progressView];
    [self.view bringSubviewToFront:self.MSGprogressView];
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
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, sizeY, iPhoneWidth - 40, 1)];
    imgView.backgroundColor = UIColorWithRGB(239, 239, 239, 0.4);
    [self.view addSubview:imgView];
}

#pragma mark ============ UITextFieldDelegate ============
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _phoneTextField) {
        _phoneTextBtn.hidden = NO;

    }else{
        _passWordBtn.hidden = NO;

    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _phoneTextField) {
        _phoneTextBtn.hidden = YES;
        
    }else{
        _passWordBtn.hidden = YES;
        
    }
}

//TODO:清除手机号
- (void)clearPhoneAction{
    _phoneTextField.text = nil;
    [_phoneTextField becomeFirstResponder];
}

//TODO:清楚密码
- (void)clearpassWordAction{
    _passWordTextField.text = nil;
    [_passWordTextField becomeFirstResponder];

}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:注册
- (void)registerPressed{
    [_passWordTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}


#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}


#pragma mark ============ 登录事件 ============
//TODO:隐藏键盘
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [_phoneTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    
    
}

//TODO:检查输入参数
- (NSString *)checkAllInputs
{
    if([[_phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]){
        return @"请输入手机号码";
    }
    if ([[_passWordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return @"请输入密码";

    }
    if(_passWordTextField.text.length<6||_passWordTextField.text.length > 20)
    {
        return @"密码长度不正确";
    }
    if (![ShareDataManager isValidatePhoneNum:_phoneTextField.text]) {
        
        return @"手机号不符合规范";
    }
    return nil;
}

//TODO:登录
- (void)loginPressed{
    [self viewTapped:nil];
    NSString *msg = [self checkAllInputs];
    if(msg){
        [self showProgressWithString:msg hiddenAfterDelay:1];

        return;
    }
    
    [self.progressView show:YES];
    //
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_OTHERLOGIN];
    NSString *str = [MHCommonTool stringToShaValue:_passWordTextField.text];
    [[UserDataManager sharedUserDataManager] reqLoginWithUserName:_phoneTextField.text password:str];

}




#pragma mark -
#pragma mark ===============NSNOTIFICATIONCENTER================
//TODO:登录完成
- (void)loginFinished{
    
    
    [self.progressView hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_OTHERLOGIN_BANGDING];

//    BOOL isOtherLogin = [[NSUserDefaults standardUserDefaults] boolForKey:USER_OTHERLOGIN];
//    if (isOtherLogin) {
//        if (![UserDataManager sharedUserDataManager].userData.phone || [[UserDataManager sharedUserDataManager].userData.phone isEqualToString:@""] || [UserDataManager sharedUserDataManager].userData.phone == nil || [UserDataManager sharedUserDataManager].userData.phone.length == 0) {
//            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_OTHERLOGIN_BANGDING];
//            
//        }else{
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_OTHERLOGIN_BANGDING];
//            
//        }
//        
//    }
}


//TODO:登录失败
- (void)loginFailed:(NSNotification*)notification{
    [self.progressView hide:YES];
    if ([[notification object] isKindOfClass:[NSError class]]) {
        [self showProgressWithString:@"网络异常，稍后再试" hiddenAfterDelay:1];

        return;
    }
    
    NSString *msg = [notification object];
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_phoneTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
}
@end
