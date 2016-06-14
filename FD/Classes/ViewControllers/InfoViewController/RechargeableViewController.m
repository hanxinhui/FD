//
//  RechargeableViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"

#import "RechargeableViewController.h"
#import "CodeViewController.h"
#import "PublicWebViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "DataMD5.h"
#import "AppDelegate.h"

@interface RechargeableViewController ()


@end

@implementation RechargeableViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"充值";
    self.titleLable.textColor = [UIColor whiteColor];
//    self.titleLable.text = [UserDataManager sharedUserDataManager].userData.UPhone;
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 50);
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    self.view.backgroundColor = UIColorWithRGB(240, 239, 244, 1);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.alpha = 0.8;
    nowPayStyle = 0;

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - 50)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];
    setHeight =  0;

    UIImageView *tImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 60)];
    [tImgView setImage:[UIImage imageNamed:@""]];
    tImgView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:tImgView];
    UIImage* img=[UIImage imageNamed:@"recharge_top.png"];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(0, 10, 0,10);
    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
   //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
   img= [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    tImgView.image=img;
    
    setHeight =  70;

    UIImageView *fImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 60)];
    fImgView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:fImgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, setHeight, 100, 60)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"充值";
    lab.font = defaultFontSize(17);
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor blackColor];
    [_mainScrollView addSubview:lab];
    
    _payTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(100, setHeight, iPhoneWidth - 145, 60)];
    _payTextField.backgroundColor = [UIColor clearColor];
    _payTextField.font = defaultFontSize(19);
    _payTextField.textColor = UIColorWithRGB(102, 102, 102, 1);
    _payTextField.placeholder = @"请输入充值金额,最低0.01元";
    _payTextField.verticalPadding = 5;
    _payTextField.textAlignment = NSTextAlignmentRight;
//    [_phoneTextField becomeFirstResponder];
//    _payTextField.keyboardType = UIKeyboardTypeNumberPad;
    _payTextField.delegate = self;
    [_mainScrollView addSubview:_payTextField];
//    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self setTheLineImg:setHeight + 40];
    // 清除手机号
    _payTextBtn  = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 20 , 20, 20)];
    _payTextBtn.backgroundColor = [UIColor clearColor];
    [_payTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_payTextBtn addTarget:self action:@selector(clearPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:_payTextBtn];
    _payTextBtn.hidden = YES;
    
    setHeight =  setHeight + 60;
    UILabel *fslab = [[UILabel alloc] initWithFrame:CGRectMake(20, setHeight, 200, 35)];
    fslab.backgroundColor = [UIColor clearColor];
    fslab.text = @"请选择支付方式";
    fslab.font = defaultFontSize(14);
    fslab.textAlignment = NSTextAlignmentLeft;
    fslab.textColor = [UIColor blackColor];
    [_mainScrollView addSubview:fslab];
    setHeight =  setHeight + 35;

    UIImageView *sImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 120)];
    sImgView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:sImgView];
    
    // 支付宝支付
    UIImageView *zfbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight + 10, 40, 40)];
    zfbImgView.backgroundColor = [UIColor whiteColor];
    [zfbImgView setImage:[UIImage imageNamed:@"zfbicon.png"]];
    [_mainScrollView addSubview:zfbImgView];
    
    UILabel *zfblab = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight+6, 100, 30)];
    zfblab.backgroundColor = [UIColor clearColor];
    zfblab.text = @"支付宝";
    zfblab.font = defaultFontSize(15);
    zfblab.textAlignment = NSTextAlignmentLeft;
    zfblab.textColor = [UIColor blackColor];
    [_mainScrollView addSubview:zfblab];
    
    UILabel *zfblabs = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight+ 27, 200, 30)];
    zfblabs.backgroundColor = [UIColor clearColor];
    zfblabs.text = @"推荐支付宝用户使用";
    zfblabs.font = defaultFontSize(13);
    zfblabs.textAlignment = NSTextAlignmentLeft;
    zfblabs.textColor = [UIColor blackColor];
    [_mainScrollView addSubview:zfblabs];
    
    _payZFB = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 50, setHeight +13, 33, 33)];
    _payZFB.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_payZFB];
    [_payZFB setImage:[UIImage imageNamed:@"zfSelect.png"] forState:UIControlStateNormal];
    _payZFB.hidden = YES;
    
    UIButton *apayZFB = [[UIButton alloc] initWithFrame:CGRectMake(0, setHeight , iPhoneWidth, 60)];
    apayZFB.backgroundColor = [UIColor clearColor];
    [apayZFB addTarget:self action:@selector(selectZFB) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:apayZFB];
    
    setHeight =  setHeight + 60;

    // 微信支付
    UIImageView *wzfImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight + 10, 40, 40)];
    wzfImgView.backgroundColor = [UIColor whiteColor];
    [wzfImgView setImage:[UIImage imageNamed:@"wzficon.png"]];
    [_mainScrollView addSubview:wzfImgView];
    
    UILabel *wzflab = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight+6, 100, 30)];
    wzflab.backgroundColor = [UIColor clearColor];
    wzflab.text = @"微信";
    wzflab.font = defaultFontSize(15);
    wzflab.textAlignment = NSTextAlignmentLeft;
    wzflab.textColor = [UIColor blackColor];
    [_mainScrollView addSubview:wzflab];
    
    UILabel *wzflabs = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight+ 27, 200, 30)];
    wzflabs.backgroundColor = [UIColor clearColor];
    wzflabs.text = @"推荐微信用户使用";
    wzflabs.font = defaultFontSize(13);
    wzflabs.textAlignment = NSTextAlignmentLeft;
    wzflabs.textColor = [UIColor blackColor];
    [_mainScrollView addSubview:wzflabs];
    
    _payWX = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 50, setHeight +13, 33, 33)];
    _payWX.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_payWX];
    [_payWX setImage:[UIImage imageNamed:@"zfSelect.png"] forState:UIControlStateNormal];
    _payWX.hidden = YES;
    
    UIButton *apayWX = [[UIButton alloc] initWithFrame:CGRectMake(0, setHeight , iPhoneWidth, 60)];
    apayWX.backgroundColor = [UIColor clearColor];
    [apayWX addTarget:self action:@selector(selectWX) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:apayWX];
    
    setHeight =  setHeight + 65;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 200)];
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = UIColorWithRGB(102, 102, 102, 1);
    textView.text = @"1. 充值时所产生的手续费为第三方支付平台收取；\n2. 每日的充值限额依据各银行限额为准；\n3. 严禁利用充值功能进行信用卡套现、转账、洗钱等行为，一经发现，资金将退回原卡并封停账号30天；\n4. 判定为风险、可疑交易的资金将通过第三方支付平台退回原卡，到账时间以发卡行通知为准；";
    textView.userInteractionEnabled = NO;
    textView.editable = NO;
    textView.font = defaultFontSize(14);
    [_mainScrollView addSubview:textView];

    setHeight =  setHeight + 220;

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(0, iPhoneHeight - 55, iPhoneWidth, 55);
    nextBtn.backgroundColor = UIColorWithRGB(44, 136, 242, 0.8);
    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg"] forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg_h"] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(nextBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
//    [nextBtn.layer setMasksToBounds:YES];
//    [nextBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
//    [signBtn.layer setBorderWidth:1.0]; //边框宽度
    
    UILabel *xlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 55)];
    xlab.backgroundColor = [UIColor clearColor];
    [nextBtn addSubview:xlab];
    xlab.text = @"充值";
    xlab.font = [UIFont boldSystemFontOfSize:17];
    xlab.textColor = [UIColor whiteColor];
    xlab.textAlignment = NSTextAlignmentCenter;

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
    [_mainScrollView addSubview:imgView];
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:下一步
- (void)nextBtnPressed{

    if ([ShareDataManager getText:_payTextField.text]) {
        NSLog(@"未输入金额");
        [self showProgressWithString:@"请输入金额" hiddenAfterDelay:1];

        return;
        
    }
    NSString *str = [NSString stringWithFormat:@"%.2f",[_payTextField.text floatValue]];
    float money = [str floatValue] * 100;
    
    NSRange range = [_payTextField.text rangeOfString:@"."];//判断字符串是否包含
    NSInteger lent = _payTextField.text.length - range.length ;
    if (lent < 0) {
        [self showProgressWithString:@"充值金额输入不规范" hiddenAfterDelay:1];
        
        return;
    }
    if (money <1 ) {
        [self showProgressWithString:@"充值金额不得小于0.01元" hiddenAfterDelay:1];
        
        return;

    }else{
        // 易支付
//        PublicWebViewController *webController = [[PublicWebViewController alloc] init];
//        webController.webStyle = WebWithPay;
//        NSString *webs = [NSString stringWithFormat:@"http://m.ihuluu.com/Trade/payWeb/uid/%ld/money/%@",(long)[UserDataManager sharedUserDataManager].userData.UID,_payTextField.text];
//        webController.webUrl = webs;
//        webController.webName = @"充值";
//        [self.navigationController pushViewController:webController animated:YES];
        switch (nowPayStyle) {
            case 0:
            {
                [self showProgressWithString:@"请先选择支付方式" hiddenAfterDelay:1];
                return;
            }
                break;
            case 1:
            {
                BOOL isClose = [[NSUserDefaults standardUserDefaults] boolForKey:RECHARGEABLE_CLOSE];
                if (isClose) {
                    [self topayPressed];

                }else{
                    UIAlertView *showAlertView = [[UIAlertView alloc] initWithTitle:@"首次充值送钱啦！" message:@"充多少送多少，最多可送150元" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
                    [showAlertView show];

                }
                
                
            }
                break;
            case 2:
            {
                BOOL isClose = [[NSUserDefaults standardUserDefaults] boolForKey:RECHARGEABLE_CLOSE];
                if (isClose) {
                    [self toWXpayPressed];
                    
                }else{
                    UIAlertView *showAlertView = [[UIAlertView alloc] initWithTitle:@"首次充值送钱啦！" message:@"充多少送多少，最多可送150元" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
                    [showAlertView show];
                    
                }
            }
                break;
            default:
                break;
        }

    }
 
    
}

//TODO:选择支付宝支付
- (void)selectZFB{
    _payZFB.hidden = NO;
    _payWX.hidden = YES;
    nowPayStyle = 1;
}

//TODO:选择微信支付
- (void)selectWX{
    _payZFB.hidden = YES;
    _payWX.hidden = NO;
    nowPayStyle = 2;
    
}


#pragma mark ============ UITextFieldDelegate ============
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _payTextBtn.hidden = NO;

    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _payTextBtn.hidden = YES;

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"string ======si=========== %@",string);
    NSLog(@"range ======si=========== %lu",(unsigned long)range.length);
    NSLog(@"textField ======si=========== %@",textField.text);
//    NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    if (![self isPureInt:string] && ![ShareDataManager getText:string] && ![string isEqualToString:@"."]){
        [self showProgressWithString:@"输入不规范" hiddenAfterDelay:1];
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

//TODO:清除手机号
- (void)clearPhoneAction{
    _payTextField.text = nil;
    [_payTextField becomeFirstResponder];

}


#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

//    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
}




//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_payTextField resignFirstResponder];
}

#pragma mark 网络请求
//TODO:充值请求订单
- (void)topayPressed{

    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_PAY_ZFB_ORDER] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_payTextField.text forKey:@"money"];

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:微信充值请求订单
- (void)toWXpayPressed{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_PAY_WX_ORDER] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_payTextField.text forKey:@"money"];
    
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
            // 获取支付宝充值订单
        case REQ_PAY_ZFB_ORDER:
        {
            NSDictionary *info = [resultDict objectForKey:RESP_CONTENT];
            NSInteger  uid =[[info objectForKey:@"uid"] integerValue];
            _price = [[info objectForKey:@"money"] floatValue];

            if (uid != [UserDataManager sharedUserDataManager].userData.UID ||             _price!= [_payTextField.text floatValue]
 ) {
                [self showProgressWithString:@"非法操作" hiddenAfterDelay:1];
                return;
            }
            _backUrl = [info objectForKey:@"url"];
            _orderId = [info objectForKey:@"code"];
            _subject = [info objectForKey:@"subject"];
            _body = [info objectForKey:@"body"];
            [self gotoZFBPlayPressed];

        }
            break;
            // 获取微信充值订单
        case REQ_PAY_WX_ORDER:
        {
            NSDictionary *info = [resultDict objectForKey:RESP_CONTENT];
            _price = [_payTextField.text floatValue];
            
         
            _nonceStr = [info objectForKey:@"nonce_str"];
            _partnerId = [info objectForKey:@"mch_id"];
            _prepayId = [info objectForKey:@"prepay_id"];
            _signWX = [info objectForKey:@"timeStamp"];
//            [[JSenPayEngine sharePayEngine] wxPayAction];

            app.isPayWX = NO;
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = WEIXIN_APPID;
            req.partnerId           = _partnerId;
//            [WXApi registerApp:WEIXIN_APPID withDescription:@"demo 2.0"];

            req.prepayId            = _prepayId;
            NSString *anoncestr  = [NSString stringWithFormat:@"%d", rand()];

            req.nonceStr            = anoncestr;
            //将当前事件转化成时间戳
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            UInt32 timeStamp =[timeSp intValue];
            req.timeStamp           = timeStamp;
            req.package = @"Sign=WXPay";
//            req.sign                = _signWX;
            DataMD5 *md5 = [[DataMD5 alloc] init];
            req.sign=[md5 createMD5SingForPay:WEIXIN_APPID partnerid:req.partnerId prepayid:req.prepayId package:req.package noncestr:req.nonceStr timestamp:req.timeStamp];
            [WXApi sendReq:req];
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );

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
            // 获取支付宝充值订单
        case REQ_PAY_ZFB_ORDER:
            // 获取微信充值订单
        case REQ_PAY_WX_ORDER:{
            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}


#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
//TODO:选中商品调用支付宝极简支付
//
- (void)gotoZFBPlayPressed
{
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088021987364600";
    NSString *seller = @"13951806977@163.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMzwYEuxXpmlOk+kKPq9FXgexxf7if7UV12q8c9GSI4f/O+eXPh2GVkC6/xJ4uGDCaDO9q3VAk3hmlf7EgCzOHqhFcuP0TVS2Cu6v6NK2vLwnVrcMzc/gUknOTFi6TOrTjJhsYwrJITIC3PK08pePAExKnh+hFJ3BoWACc72ZHHLAgMBAAECgYB1IKzolebLSXOaMOh65bZvgKepPUoRKqsEDb9GB5VQJVgaWxgnqNez18en2VKiMJJAJgk2MJewi0/7GLOhUszjwrhTVU5lMCxot3csOE7ftER2EocpfZJa7tMV0sjCPhOH4mJlMR08bke986xnzCAiVmJbgj2NYzTukKh8EfXIAQJBAPcvF+RC0T5GH01q9veXXokieSHk+LAMDa7aOJAP1K6Qu9O3E0pbKv9XI/qcvYb/3BYK2CF87CLzAQDIKGyVKEECQQDUP5DpVHhuHw5CduBFvMyzWAlEOJ6KrLn8YEChNi3XFSADrvcoubrQAKrT+L+v7BuMKhyPKTFlOqeP1Ilg5fcLAkEAyocCe1sn2G9Z/HO00J5src3aFCRogs4NdAOGrrrZ1wHtc4WgP589NqNubkt4mqEO8dyGw8F4NRaH7t0RCg6YQQJAKixPQO2V2Fu3W6F/QpwXGHOfs7yEVA2qDumZLe80AI6kA9daKO9unTHkv6WngO8rMhiUACYxOGoFLWEPwv8urQJBALTyTu9MbKFVCXySwK1KXYxgbrWOf4Ng7OaYZL3xlG4BVGoEfuuNhdezvaSXS1ncr98dd3PfQs6DftoVR3vdPKc=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = _orderId; //订单ID（由商家自行制定）
    order.productName = _subject; //商品标题
    order.productDescription = _body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",_price]; //商品价格
    order.notifyURL =  _backUrl; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"ihuluu";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
//    if (![[AlipaySDK defaultService] isLogined]) {
//        [self showProgressWithString:@"您尚未安装支付宝应用" hiddenAfterDelay:1];
//        return;
//    }
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            // 支付成功回调
            NSLog(@"pay reslut ==== %@",resultDic);
//            [self showProgressWithString:@"充值成功" hiddenAfterDelay:1];

        }];
        
    }
}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void)onResp:(BaseResp*)resp{
    //启动微信支付的response
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                strMsg = @"支付结果：成功！";
                break;
            case -1:
                strMsg = @"支付结果：失败！";
                break;
            case -2:
                strMsg = @"用户已经退出支付！";
                break;
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！ retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
    
    [self showProgressWithString:strMsg hiddenAfterDelay:1];

}


#pragma mark ============ UIAlertView事件 ============
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"知道了"]) {
        
        switch (nowPayStyle) {
                // 支付宝充值
            case 1:
            {
                [self topayPressed];
                
            }
                break;
                // 微信充值
            case 2:
            {
                [self toWXpayPressed];
                
            }
                break;
            default:
                break;
        }
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:RECHARGEABLE_CLOSE];
        
    }
    if ([str isEqualToString:@"取消"]) {
        switch (nowPayStyle) {
                // 支付宝充值
            case 1:
            {
                [self topayPressed];

            }
                break;
                // 微信充值
            case 2:
            {
                [self toWXpayPressed];
                
            }
                break;
            default:
                break;
        }

        
    }
}
@end
