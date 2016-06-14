//
//  PayCodeViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "PayCodeViewController.h"
#import "ModifyPayPwdViewController.h"
#import "ModifyPhoneViewController.h"

@interface PayCodeViewController ()


@end

@implementation PayCodeViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    self.backgroundView .backgroundColor = UIColorWithRGB(0, 0, 0, 0.8);
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.text = @"修改信息";
    if (_modifyStyle == ModifyWithPassWord) {
        self.titleLable.text = @"修改支付密码";
        
    }
    if (_modifyStyle == ModifyWithPhone) {
        self.titleLable.text = @"修改手机号";
    }
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

//TODO:传人手机号
- (void)setPhoneNum:(NSString *)phoneNum{
    _phoneNum = phoneNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.alpha = 0.8;
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT + 10;
    NSMutableString *phoneN = [NSMutableString stringWithFormat:@"%@",[UserDataManager sharedUserDataManager].userData.UPhone];
    [phoneN replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    NSString *str = [NSString stringWithFormat:@"我们将发送验证码至“%@”手机上,请注意查收！",phoneN];
    
    UILabel *tsLab = [[UILabel alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 50)];
    tsLab.backgroundColor = [UIColor clearColor];
    tsLab.textColor = [UIColor whiteColor];
    tsLab.text = str;
    tsLab.numberOfLines = 0;
    tsLab.font = defaultFontSize(13);
    [self.view addSubview:tsLab];
    
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
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight+ 40, iPhoneWidth - 40, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [self.view addSubview:imgView];
    
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
    lab.text = @"下一步";
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    


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
        // 返回
        NSArray *ctrlArray = self.navigationController.viewControllers;
        
        [self.navigationController popToViewController:[ctrlArray objectAtIndex:0] animated:YES];
    }
   
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
//    // 弹出警告
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否放弃注册" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"继续注册", nil];
//    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:下一步
- (void)nextBtnPressed{
    
    if ([ShareDataManager getText:_codeTextField.text]) {
        NSLog(@"未输入验证码");
        [self showProgressWithString:@"未输入验证码" hiddenAfterDelay:1];

        return;
        
    }
    if (_modifyStyle == ModifyWithPassWord) {
        // 进入下一层 密码
        ModifyPayPwdViewController *modifyPayPwdViewController = [[ModifyPayPwdViewController alloc] init];
        modifyPayPwdViewController.verNum = _codeTextField.text;
        [self.navigationController pushViewController:modifyPayPwdViewController animated:YES];
        
    }
    if (_modifyStyle == ModifyWithPhone) {
          [self reqVerifyCode];
 
    }

  
    

}
#pragma mark ============ UITextFieldDelegate ============
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _codeTextBtn.hidden = NO;
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _codeTextBtn.hidden = YES;
    
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GETCODE] forKey:REQ_CODE];
    [dict setObject:[UserDataManager sharedUserDataManager].userData.UPhone forKey:@"username"];
    [dict setObject:@"0" forKey:@"sign"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:验证验证码
- (void)reqVerifyCode{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_VERIFY] forKey:REQ_CODE];
    [dict setObject:_codeTextField.text forKey:@"verify"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
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
//            _codeTextField.text = [info objectForKey:@"verify"];
            [self reSendIDCode];

        }
            break;
            // 验证验证码成功
        case REQ_VERIFY:{
            // 进入下一层 手机号
            ModifyPhoneViewController *modifyPhoneViewController = [[ModifyPhoneViewController alloc] init];
            [self.navigationController pushViewController:modifyPhoneViewController animated:YES];
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
            // 验证验证码失败
        case REQ_VERIFY:{
            _codeTextField.text = nil;
        }
            break;
        default:
            break;
    }
    [self showProgressWithString:msg hiddenAfterDelay:1];


}
@end
