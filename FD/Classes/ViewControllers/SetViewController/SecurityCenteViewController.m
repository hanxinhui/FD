//
//  SecurityCenteViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SecurityCenteViewController.h"
#import "AppDelegate.h"
#import "ModifyLPassWordViewController.h"
#import "PayCodeViewController.h"
#import "LoginViewController.h"

@interface SecurityCenteViewController ()


@end

@implementation SecurityCenteViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.titleLable.textColor = [UIColor blackColor];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.titleLable.text = @"安全中心";
  
    //安全中心
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ISMODIFYGESTUREFAIL object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ISSETGESTURE_SUCCESS object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openGestureFailed) name:ISMODIFYGESTUREFAIL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setGestureSuccess) name:ISSETGESTURE_SUCCESS object:nil];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    setHeight = setHeight + 30;
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    //绑定手机
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth , 45) btnTag:100001 imgStr:@""];
    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 45) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 45) textColor:[UIColor blackColor] labText:@"绑定手机" setFont:17 setCen:NO];
    
    _phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 45)];
    _phoneLab.backgroundColor = [UIColor clearColor];
    _phoneLab.text = [UserDataManager sharedUserDataManager].userData.UPhone;
    _phoneLab.textColor = [UIColor grayColor];
    _phoneLab.textAlignment = NSTextAlignmentRight;
    _phoneLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_phoneLab];
    
    setHeight = setHeight + 45;
    [self setTheLineImg:setHeight];
    setHeight = setHeight + 1;

    //支付密码
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth , 45) btnTag:100002 imgStr:@""];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 45) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 45) textColor:[UIColor blackColor] labText:@"支付密码" setFont:17 setCen:NO];
    
    _payPwdLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 45)];
    _payPwdLab.backgroundColor = [UIColor clearColor];
//    _payPwdLab.text = [UserDataManager sharedUserDataManager].userData.Unike;
    _payPwdLab.textColor = [UIColor grayColor];
    _payPwdLab.textAlignment = NSTextAlignmentRight;
    _payPwdLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_payPwdLab];
    
    setHeight = setHeight + 45;
    [self setTheLineImg:setHeight];
    setHeight = setHeight + 1;

    //登录密码
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth , 45) btnTag:100003 imgStr:@""];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 45) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 45) textColor:[UIColor blackColor] labText:@"登录密码" setFont:17 setCen:NO];
    
    _loginPwdLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 45)];
    _loginPwdLab.backgroundColor = [UIColor clearColor];
    _loginPwdLab.text = @"已设置";
    _loginPwdLab.textColor = [UIColor grayColor];
    _loginPwdLab.textAlignment = NSTextAlignmentRight;
    _loginPwdLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_loginPwdLab];
    
    setHeight = setHeight + 45;
//    [self setTheLineImg:setHeight];
    setHeight = setHeight + 10;


    //打开手势
    
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth , 45) imgStr:@"" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 45) textColor:[UIColor blackColor] labText:@"打开手势" setFont:17 setCen:NO];
    
    _gestureSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(iPhoneWidth - 100, setHeight + 5, 50, 45)];
    BOOL isopen = [[NSUserDefaults standardUserDefaults] boolForKey:ISOPENGESTURE];
    [_gestureSwitch setOn:isopen];

    [_gestureSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_gestureSwitch];
    
    setHeight = setHeight + 45;
    [self setTheLineImg:setHeight];
    setHeight = setHeight + 1;
    
    _modifySSBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth , 45)];
    _modifySSBtn.backgroundColor = [UIColor whiteColor];
    [_modifySSBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_modifySSBtn];
    [self setTheImg:CGRectMake(iPhoneWidth - 40, setHeight +(_modifySSBtn.frame.size.height - 17 )/ 2, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];

    
    _modifySSImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setHeight, iPhoneWidth , 45)];
    _modifySSImgView.backgroundColor = [UIColor clearColor];
//    [_modifySSImgView setImage:[UIImage imageNamed:name]];
    [self.view addSubview:_modifySSImgView];

    _modifySSLab = [[UILabel alloc] initWithFrame:CGRectMake(20, setHeight, 200, 45)];
    _modifySSLab.backgroundColor = [UIColor clearColor];
    _modifySSLab.text = @"设置手势密码";
    _modifySSLab.textColor = [UIColor blackColor];
    _modifySSLab.textAlignment = NSTextAlignmentLeft;
    _modifySSLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_modifySSLab];
    
    // 手势解锁相关
    NSString* pswd = [LLLockPassword loadLockPassword];
    if ([pswd isEqualToString:@""] || pswd.length == 0 || pswd == nil)
    {
        //设置手势密码
        _modifySSLab.text = @"设置手势密码";
        _modifySSBtn.tag = 100004;

    }else{
        //修改手势密码
        _modifySSLab.text = @"修改手势密码";
        _modifySSBtn.tag = 100005;

    }
    
    setHeight = setHeight + 45;
    [self setTheLineImg:setHeight];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    
}



//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    
    
    [self setTheImg:CGRectMake(iPhoneWidth - 40, setHeight +(btn.frame.size.height - 17 )/ 2, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
    
}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self.view addSubview:imgView];
}
//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, sizeY, iPhoneWidth , 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    [self.view addSubview:imgView];
    imgView.alpha = 0.5;

}
//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setCen:(BOOL )cen{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (cen) {
        lab.textAlignment = NSTextAlignmentCenter;
        
    }else{
        lab.textAlignment = NSTextAlignmentLeft;
        
    }
    lab.font = [UIFont systemFontOfSize:font];
    [self.view addSubview:lab];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 修改手机手机
        case 100001:
        {
            PayCodeViewController *payCodeViewController= [[PayCodeViewController alloc] init];
            payCodeViewController.modifyStyle = ModifyWithPhone;
            [self.navigationController pushViewController:payCodeViewController animated:YES];
        }
            break;
            // 支付密码
        case 100002:
        {
            PayCodeViewController *payCodeViewController= [[PayCodeViewController alloc] init];
            payCodeViewController.modifyStyle = ModifyWithPassWord;
            [self.navigationController pushViewController:payCodeViewController animated:YES];
        }
            break;
            // 登录密码
        case 100003:
        {
            ModifyLPassWordViewController *vv= [[ModifyLPassWordViewController alloc] init];
            [self.navigationController pushViewController:vv animated:YES];
        }
            break;
            // 设置手势密码
        case 100004:
        {
            AppDelegate* ad = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [ad showLLLockViewController:LLLockViewTypeCreate];
        }
            break;
            // 修改手势密码
        case 100005:
        {
            [self modifyBtnPressed];
        }
            break;

        default:
            break;
    }
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"====== 打开手势");
        NSString* pswd = [LLLockPassword loadLockPassword];

        if (pswd) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISOPENGESTURE];

        }else{
            [_gestureSwitch setOn:NO];
            
            AppDelegate* ad = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [ad showLLLockViewController:LLLockViewTypeCreate];
            
        }
        
    }else {
        NSLog(@"====== 关闭手势");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ISOPENGESTURE];
        [_gestureSwitch setOn:NO];

    }
}

//TODO:修改手势密码
- (void)modifyBtnPressed{
    AppDelegate* ad = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [ad showLLLockViewController:LLLockViewTypeModify];
    
}



//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 手势解锁相关
    NSString* pswd = [LLLockPassword loadLockPassword];
    if ([pswd isEqualToString:@""] || pswd.length == 0 || pswd == nil)
    {
        //设置手势密码
        _modifySSLab.text = @"设置手势密码";
        _modifySSBtn.tag = 100004;
        
    }else{
        //修改手势密码
        _modifySSLab.text = @"修改手势密码";
        _modifySSBtn.tag = 100005;
        
    }
    _phoneLab.text = [UserDataManager sharedUserDataManager].userData.UPhone;

    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}


//TODO:打开手势密码失败
- (void)openGestureFailed{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ISOPENGESTURE];
    [[UserDataManager sharedUserDataManager] clearUserData];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOG_OUT object:nil];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    app.isModifyPoint = NO;
    LoginViewController *loginv = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginv animated:YES];
    
}


//TODO:设置密码成功
- (void)setGestureSuccess{
    [_gestureSwitch setOn:YES];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISOPENGESTURE];

}

@end
