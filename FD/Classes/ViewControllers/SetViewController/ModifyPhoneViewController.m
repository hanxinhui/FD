//
//  ModifyPhoneViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ModifyPhoneViewController.h"


@interface ModifyPhoneViewController ()


@end

@implementation ModifyPhoneViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.backgroundView .backgroundColor = UIColorWithRGB(0, 0, 0, 0.8);
    self.titleLable.textColor = [UIColor whiteColor];
    self.headerBgView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.statusBarView.backgroundColor = [UIColor clearColor];
    self.dlineImgView.hidden = YES;
    self.titleLable.text = @"修改手机号";


    //设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODIFY_PHONE_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODIFY_PHONE_FAILED object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _codeLab = [[UILabel alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifySuccess) name:MODIFY_PHONE_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyFailed:) name:MODIFY_PHONE_FAILED object:nil];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    UILabel *alab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 50)];
    alab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:alab];
    alab.textColor = [UIColor grayColor];
    alab.font = [UIFont systemFontOfSize:13];
    alab.textAlignment = NSTextAlignmentCenter;
    
    setHeight = setHeight + 30;

   
    // 新密码
    _phoneTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _phoneTextField.backgroundColor = [UIColor clearColor];
    _phoneTextField.font = defaultFontSize(21);
    _phoneTextField.textColor = [UIColor whiteColor];
    _phoneTextField.delegate = self;
//    _phoneTextField.secureTextEntry = YES;
    _phoneTextField.verticalPadding = 2;
    [_phoneTextField becomeFirstResponder];
    _phoneTextField.placeholder = @"输入新手机号";

    [self.view addSubview:_phoneTextField];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight+ 40, iPhoneWidth - 40, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [self.view addSubview:imgView];
    
    // 清除
    _phoneTextBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _phoneTextBtn.backgroundColor = [UIColor clearColor];
    [_phoneTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_phoneTextBtn addTarget:self action:@selector(clearPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_phoneTextBtn];
    _phoneTextBtn.hidden = YES;

    
    setHeight = setHeight + 60;

    
    _codeTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 120, 40)];
    _codeTextField.backgroundColor = [UIColor clearColor];
    _codeTextField.font = defaultFontSize(21);
    _codeTextField.textColor = [UIColor grayColor];
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.verticalPadding = 2;
    //    [_codeTextField becomeFirstResponder];
    [self.view addSubview:_codeTextField];
    _codeTextField.delegate = self;
    
    // 清除验证码
    _codeTextBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _codeTextBtn.backgroundColor = [UIColor clearColor];
    [_codeTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_codeTextBtn addTarget:self action:@selector(clearCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeTextBtn];
    _codeTextBtn.hidden = YES;
    
    
    
    //    _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView *aimgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight+ 40, iPhoneWidth - 40, 1)];
    aimgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    aimgView.alpha = 0.5;
    [self.view addSubview:aimgView];
    
    // 获取验证码
    _reSetBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 100, setHeight + 5,80, 30)];
    _reSetBtn.backgroundColor = UIColorWithRGB(252, 132, 37, 1);
    //    [_getIdCodeBtn setImage:[UIImage imageNamed:@"myLogin_loginBg.png"] forState:UIControlStateNormal];
    [_reSetBtn addTarget:self action:@selector(reqGetCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reSetBtn];
    [_reSetBtn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    //    _reSetBtn.userInteractionEnabled = NO;
    
    
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 100, setHeight + 5,80, 30)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.textColor = [UIColor whiteColor];
    _timeLab.textAlignment = NSTextAlignmentCenter;
    _timeLab.text = @"发送验证码";
    _timeLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_timeLab];
    
    //    [self reqGetCode];
    
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
    lab.text = @"确认修改";
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

//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
}


#pragma mark -
#pragma mark ============ UIAlertViewDelegate ============
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"继续注册"]) {
        
    }
    if ([str isEqualToString:@"放弃"]) {
        // 返回
        NSArray *ctrlArray = self.navigationController.viewControllers;
        
        [self.navigationController popToViewController:[ctrlArray objectAtIndex:0] animated:YES];
    }
    
}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
    
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
    NSString *msg = [notification object];
    
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    [self showProgressWithString:msg hiddenAfterDelay:1];
  

}


#pragma mark ============ UITextFieldDelegate ============
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _codeTextBtn.hidden = NO;
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _codeTextBtn.hidden = YES;
    
}

//TODO:清除手机号
- (void)clearPhoneAction{
    _phoneTextField.text = nil;
    [_phoneTextField becomeFirstResponder];
    
}

//TODO:清除验证码
- (void)clearCodeAction{
    _codeTextField.text = nil;
    [_codeTextField becomeFirstResponder];
    
}

#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
}
//TODO:重新求求验证码
- (void)reSendIDCode{
    timeStart = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
}
//TODO:倒计时
- (void)timerFireMethod:(NSTimer *)theTimer
{
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间...
    NSDate *today = [NSDate date];    //得到当前时间
    
    NSDate *date = [NSDate dateWithTimeInterval:_expCode sinceDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    static int year;
    static int month;
    static int day;
    static int hour;
    static int minute;
    static int second;
    if(timeStart) {//从NSDate中取出年月日，时分秒，但是只能取一次
        year = [[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[dateString substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[dateString substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[dateString substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStart= NO;
    }
    
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    NSDate *todate = [cal dateFromComponents:endTime]; //把目标时间装载入date
    
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    NSString *fen = [NSString stringWithFormat:@"%ld", (long)[d minute]];
    if([d minute] < 10) {
        fen = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%ld 秒", (long)[d second] + (long)[d minute] * 60];
    if([d second] + [d minute] * 60 < 10) {
        miao = [NSString stringWithFormat:@"0%ld 秒",(long)[d second]];
    }
    
    if([d second] > 0 || [d minute] > 0) {
        
        _reSetBtn.selected = YES;
        _reSetBtn.userInteractionEnabled = NO;
        _timeLab.text = miao;
        //        _timeLab.textColor = [UIColor lightGrayColor];
        
        
        //计时尚未结束，do_something
        
    } else if([d second] + [d minute] * 60 == 0) {
        
        //计时1分钟结束，do_something
        timeStart = NO;
        
        _reSetBtn.selected = NO;
        _reSetBtn.userInteractionEnabled = YES;
        _timeLab.text = @"发送验证码";
        //        _timeLab.textColor = [UIColor whiteColor];
        
        
    } else{
        [theTimer invalidate];
    }
    
}

#pragma mark ===============网络请求 ================
//TODO:上传手机号获取验证码
- (void)reqGetCode{
    if ([ShareDataManager getText:_phoneTextField.text]) {
        NSLog(@"未输入手机号");
        [self showProgressWithString:@"请输入手机号" hiddenAfterDelay:1];
        
        return;
        
    }
    
    if (![ShareDataManager isValidatePhoneNum:_phoneTextField.text]) {
        [self showProgressWithString:@"手机号不符合规范" hiddenAfterDelay:1];
        
        return;
    }

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GETCODE] forKey:REQ_CODE];
    [dict setObject:_phoneTextField.text forKey:@"username"];
    [dict setObject:@"0" forKey:@"sign"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:确认修改
- (void)nextBtnPressed{
    
    if ([ShareDataManager getText:_phoneTextField.text]) {
        NSLog(@"未输入手机号");
        [self showProgressWithString:@"请输入手机号" hiddenAfterDelay:1];
        
        return;
        
    }
    
    if (![ShareDataManager isValidatePhoneNum:_phoneTextField.text]) {
        [self showProgressWithString:@"手机号不符合规范" hiddenAfterDelay:1];
        
        return;
    }
    
    if ([ShareDataManager getText:_codeTextField.text]) {
        NSLog(@"未输入验证码");
        [self showProgressWithString:@"请输入验证码" hiddenAfterDelay:1];
        
        return;
        
    }
    
    [self.progressView show:YES];

    [[UserDataManager sharedUserDataManager] ModifyPhone:_codeLab.text phone:_phoneTextField.text];
    
}

#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 请求验证码
        case REQ_GETCODE:
        {
            NSDictionary *info = [resultDict objectForKey:RESP_CONTENT];
            _expCode = [[info objectForKey:@"exp"] floatValue];
            _codeLab.text = [info objectForKey:@"verify"];
            [self reSendIDCode];
            
        }
            break;
 
        default:
            break;
    }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    [self.progressView hide:YES];
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
            // 请求验证码失败
        case REQ_GETCODE:{
        }
            break;

        default:
            break;
    }
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
    
}

@end
