//
//  CountersignViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "CountersignViewController.h"
#import "KLGetCodeViewController.h"
#import "WelfareGetViewController.h"
#import "MyCountersignViewController.h"
#import "MyCountersignDetailViewController.h"
#import "PublicWebViewController.h"
#import "GroupGetViewController.h"

#define FL_TAG          101// 土豪抽疯
#define QUN_TAG         102// 集体抽疯
#define MY_TAG          103// 我的心愿
#define SHOW_TAG        104// 介绍

@interface CountersignViewController ()


@end

@implementation CountersignViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"暗号抽疯";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.dlineImgView.hidden = YES;
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    //我的抢宝
    UIButton *myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(0, 0, 100, 50);
    myBtn.backgroundColor = [UIColor clearColor];
    [myBtn addTarget:self action:@selector(myPressed) forControlEvents:UIControlEventTouchUpInside];
    [myBtn setTitle:@"我的暗号" forState:UIControlStateNormal];
    myBtn.titleLabel.textColor = [UIColor whiteColor];
    myBtn.titleLabel.font = defaultFontSize(14);
    self.rightBtn = myBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, iPhoneWidth, 168)];
    bgImgView.backgroundColor = [UIColor clearColor];
    bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg.png"];
   
    [self.view addSubview:bgImgView];
    
    setHeight = IOS7?20:0;

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
//    setHeight = setHeight + 50;

    UILabel *showLab = [[UILabel alloc] initWithFrame:CGRectMake(50, setHeight+20, iPhoneWidth-100, 30)];
    showLab.backgroundColor = [UIColor clearColor];
    showLab.text = @"对暗号 来找抽";
    showLab.font = [UIFont systemFontOfSize:22];
    showLab.textColor = [UIColor whiteColor];
    showLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLab];
    
       setHeight = setHeight + 60;
    UIImageView *seBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 284)/2, setHeight , 284, 80)];
    seBgImgView.backgroundColor = [UIColor clearColor];
    
    //    [self.view addSubview:seBgImgView];
    [seBgImgView setImage:[UIImage imageNamed:@"MyCounterSign_Home_Search.png"]];
    [self.view addSubview:seBgImgView];
 
    //搜索框
    _countersTextField = [[UITextField alloc] initWithFrame:CGRectMake  ((iPhoneWidth - 284)/2, setHeight , 284, 73)];
    _countersTextField.backgroundColor =[UIColor clearColor];
    _countersTextField.delegate = self;
    _countersTextField.font = defaultBoldFontSize(45);
    _countersTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_countersTextField];
    _countersTextField.returnKeyType = UIReturnKeyJoin;
    _countersTextField.clearButtonMode = UITextFieldViewModeNever; //编辑时会出现个修改X
    
    // 进入
    _goBtn = [[UIButton alloc] initWithFrame:CGRectMake((iPhoneWidth - 284)/2 + 284 - 55, setHeight + 23, 50, 75)];
    _goBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_goBtn];
    [_goBtn setImage:[UIImage imageNamed:@"Countersigb_Go.png"] forState:UIControlStateNormal];
    [_goBtn addTarget:self action:@selector(reqGetCode) forControlEvents:UIControlEventTouchUpInside];
    _goBtn.hidden = YES;
//    _countersTextField.keyboardType = UIKeyboardTypeNumberPad;
    // 4S
    if (iPhoneWidth==320 && iPhoneHeight <500) {
        seBgImgView.frame = CGRectMake((iPhoneWidth-247) / 2, setHeight ,247 , 63);
        _countersTextField.frame = CGRectMake((iPhoneWidth-247) / 2, setHeight ,247 , 63);
        
        _goBtn.frame = CGRectMake((iPhoneWidth - 247)/2 + 247 - 35, setHeight , 30, 63);

        [seBgImgView setImage:[UIImage imageNamed:@"MyCounterSign_Home_Search_320.png"]];
        bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
        bgImgView.frame = CGRectMake(0, setHeight-60 ,320, 150);
        

    }
    // 5/5S
    if (iPhoneWidth==320 && iPhoneHeight >500) {
        seBgImgView.frame = CGRectMake((iPhoneWidth-247) / 2, setHeight+20 ,247 , 63);
        _countersTextField.frame = CGRectMake((iPhoneWidth-247) / 2, setHeight+20 ,247 , 63);
        _goBtn.frame = CGRectMake((iPhoneWidth - 247)/2 + 247 - 35, setHeight + 15, 30, 75);

        [seBgImgView setImage:[UIImage imageNamed:@"MyCounterSign_Home_Search_320.png"]];
        bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
        bgImgView.frame = CGRectMake(0, setHeight-60 ,320, 221);
        
        
    }
    // 6/6s
    if (iPhoneWidth==375) {
        showLab.frame = CGRectMake(50, setHeight - 30, iPhoneWidth-100, 30);
        _goBtn.frame = CGRectMake((iPhoneWidth - 284)/2 + 284 - 55, setHeight + 23, 50, 75);

        
        seBgImgView.frame = CGRectMake((iPhoneWidth-292) / 2, setHeight+20 ,292 , 83);
        _countersTextField.frame = CGRectMake((iPhoneWidth-292) / 2, setHeight +20,292 , 83);
        bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_375.png"];
        
        [seBgImgView setImage:[UIImage imageNamed:@"MyCounterSign_Home_Search_414.png"]];
        bgImgView.frame = CGRectMake(0, setHeight - 60 , 375, 259);
        
    }
    // 6P/6SP

    if (iPhoneWidth==414) {
        showLab.frame = CGRectMake(50, setHeight - 30, iPhoneWidth-100, 30);

        seBgImgView.frame = CGRectMake((iPhoneWidth-323) / 2, setHeight + 40 ,323 , 83);
        _countersTextField.frame = CGRectMake((iPhoneWidth-323) / 2, setHeight+ 40 ,323 , 83);
        bgImgView.frame = CGRectMake(0, setHeight- 60 , 414, 286);
        _goBtn.frame = CGRectMake((iPhoneWidth - 323)/2 + 323 - 55, setHeight + 40, 50, 83);

        [seBgImgView setImage:[UIImage imageNamed:@"MyCounterSign_Home_Search_375.png"]];
        bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_414.png"];
        
    }

 
     // 土豪抽疯
    [self setBtn:CGRectMake((iPhoneWidth - 270 )/ 2 , iPhoneHeight - 240, 270, 52) textname:@"" btnTag:FL_TAG imgname:@""];
    [self setTheLab:CGRectMake((iPhoneWidth - 40 )/ 2 , iPhoneHeight - 228, 100, 30) textColor:UIColorWithRGB(238, 95, 80, 1) labText:@"土壕抽疯" setFont:18];
    [self setTheImg:CGRectMake((iPhoneWidth - 100 )/ 2, iPhoneHeight - 228, 21, 25) imgStr:@"MyCounterSign_home_Welfare.png" bgColor:nil];

    // 集体抽疯
    [self setBtn:CGRectMake((iPhoneWidth - 270 )/ 2, iPhoneHeight - 180,  270, 52) textname:@"" btnTag:QUN_TAG imgname:@""];
    [self setTheLab:CGRectMake((iPhoneWidth - 40 )/ 2 , iPhoneHeight - 168, 100, 30) textColor:UIColorWithRGB(238, 95, 80, 1) labText:@"集体抽疯" setFont:18];
     [self setTheImg:CGRectMake((iPhoneWidth - 100 )/ 2, iPhoneHeight - 165, 23, 21) imgStr:@"MyCounterSign_home_custom.png" bgColor:nil];

//    // 我的心愿
//    [self setBtn:CGRectMake((iPhoneWidth - 270 )/ 2, iPhoneHeight - 120, 270, 52) textname:@"我的心愿" btnTag:MY_TAG imgname:@"indiana_password_btn_03.png"];

    // 暗号说明
    UIButton   *showbtn = [[UIButton alloc] initWithFrame:CGRectMake(80, iPhoneHeight - 40, iPhoneWidth - 160, 30)];
    showbtn.backgroundColor =[ UIColor whiteColor];
    showbtn.tag = SHOW_TAG;
    [showbtn setTitle:@"暗号玩法介绍" forState:UIControlStateNormal];
    [showbtn setTitleColor:UIColorWithRGB(172, 172, 172, 1) forState:UIControlStateNormal];
    showbtn.titleLabel.font = defaultBoldFontSize(15);
    [showbtn addTarget:self action:@selector(btnPassed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showbtn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
}

//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    lab.font = [UIFont systemFontOfSize:font];
    [self.view addSubview:lab];
}


//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self.view addSubview:imgView];
}

//TODO:设置按钮
- (void)setBtn:(CGRect )rect textname:(NSString *)name btnTag:(NSInteger )tag imgname:(NSString *)img{
    UIButton    *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
//    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateHighlighted];
//    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateSelected];
    
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor: UIColorWithRGB(238, 95, 80, 1) forState:UIControlStateNormal];
    
    
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnPassed:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=5;
    [btn.layer setBorderWidth:1.0f];
    [btn.layer setBorderColor: UIColorWithRGB(238, 95, 80, 1).CGColor];

    
    [self.view addSubview:btn];
}


#pragma mark -
#pragma mark ====== UITextFielddelegate =====
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [self reqGetCode];
    return YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"string ======si=========== %@",string);
//    NSLog(@"range ======si=========== %lu",(unsigned long)range.length);
//    NSLog(@"textField ======si=========== %@",textField.text);
    NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    _goBtn.hidden = YES;

    if ([self isPureInt:string]){
        if (str.length > 6) {
            _goBtn.hidden = NO;

            return NO;
//            [self showProgressWithString:@"口令输入有误" hiddenAfterDelay:1];

        }
        if (str.length == 6) {
            _goBtn.hidden = NO;
        }
    }else{
        if ([string isEqualToString:@""] || string.length == 0 || string == nil) {
            return YES;
        }
        [self showProgressWithString:@"口令输入有误" hiddenAfterDelay:1];
        return NO;
    }
    return YES;
}

// 整形判断
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:我的抢宝
- (void)myPressed{
    MyCountersignViewController *myCountersignViewController = [[MyCountersignViewController alloc] init];
    [self.navigationController pushViewController:myCountersignViewController animated:YES];
}



//TODO:响应事件
- (void)btnPassed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 土豪抽疯
        case FL_TAG:
        {
            WelfareGetViewController *welfareGetViewController = [[WelfareGetViewController alloc] init];
            [self.navigationController pushViewController:welfareGetViewController animated:YES];
        }
            break;
            // 集体抽疯
        case QUN_TAG:
        {
            GroupGetViewController *groupGetViewController = [[GroupGetViewController alloc] init];
            [self.navigationController pushViewController:groupGetViewController animated:YES];
        }
            break;
            // 我的心愿
        case MY_TAG:
        {
            
        }
            break;
            // 暗号介绍
        case SHOW_TAG:
        {
            // 
            PublicWebViewController *webController = [[PublicWebViewController alloc] init];
            webController.isSnatch = YES;
            webController.webStyle = WebWithShare;
            // leoxu 测试用
            NSString *webs = [NSString stringWithFormat:@"http://m-test.ihuluu.com/indiana/introduce"];
            webController.webUrl = webs;
            webController.webName = @"暗号玩法介绍";
            [self.navigationController pushViewController:webController animated:YES];
        }
           
            break;
        default:
            break;
    }
}

//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_countersTextField resignFirstResponder];
}

#pragma mark 网络请求
//TODO:验证口令
- (void)reqGetCode{
    if([ShareDataManager getText:_countersTextField.text]){
        [self showProgressWithString:@"请输入口令" hiddenAfterDelay:1];
        return;
    }
    if (_countersTextField.text.length != 6) {
        [self showProgressWithString:@"口令有误" hiddenAfterDelay:1];
        return;
    }
    [_countersTextField resignFirstResponder];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_KL_GETCODE] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_countersTextField.text forKey:@"code"];
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
            // 验证口令
        case REQ_KL_GETCODE:
        {
            NSDictionary *dict = [resultDict objectForKey:RESP_CONTENT];
            NSInteger exist = [[dict objectForKey:@"exist"] integerValue];// 0 未加入  1加入

            switch (exist) {
                case 0:
                {
                    NSInteger full = [[dict objectForKey:@"full"] integerValue];// 1表示 已满 0 表示未满
                    _goBtn.hidden = YES;

                    KLGetCodeViewController *getCodeViewController = [[KLGetCodeViewController alloc] init];
                    
                    if (full == 1) {
                        getCodeViewController.isFull = YES;
 
                    }else{
                        getCodeViewController.isFull = NO;

                    }
                    
                    getCodeViewController.codeStr = _countersTextField.text;
                    getCodeViewController.infoDict = dict;
                    [self.navigationController pushViewController:getCodeViewController animated:YES];
                }
                    break;
                case 1:{
                    _goBtn.hidden = YES;

                    MyCountersignDetailViewController *detailsViewController = [[MyCountersignDetailViewController alloc] init];
                    NSInteger kind = [[dict objectForKey:@"kind"] integerValue];// 1表示福利抢宝 2 表示群抢宝
  
                    switch (kind) {
                        case 1:
                            detailsViewController.countersignStyle = WelfareCountersign;

                            break;
                        case 2:{
                            detailsViewController.countersignStyle = GroupCountersign;
                            detailsViewController.isGroupjoin = YES;
                        }


                            break;
                        default:
                            break;
                    }
                    
//                    NSInteger exist = [[dict objectForKey:@"exist"] integerValue];// exist 1已参加 0 表示未参加
                    

                    
                    detailsViewController.isMyJoin = YES;
                    detailsViewController.isKLjoin = YES;
                    detailsViewController.detailID = [dict objectForKey:@"id"];
                    [self.navigationController pushViewController:detailsViewController animated:YES];
                }
                    break;
                default:
                    break;
            }
            _countersTextField.text = @"";

            
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
            // 
        case REQ_KL_GETCODE:{
//            msg = @"口令输入错误";

        }
            break;
            
        default:
            break;
    }
    [self showProgressWithString:msg hiddenAfterDelay:1];

    
}



@end
