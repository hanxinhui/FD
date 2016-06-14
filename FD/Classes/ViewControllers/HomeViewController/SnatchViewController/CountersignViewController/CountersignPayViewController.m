//
//  CountersignPayViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "CountersignPayViewController.h"
#import "KLCreateViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "APAuthV2Info.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "DataMD5.h"
#import "AppDelegate.h"

#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"


#define SETFOOTHIGH         50  // 底部高度

@interface CountersignPayViewController ()


@end

@implementation CountersignPayViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WEIXINPAY_SUCCESS object:nil];
    
}


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    self.dlineImgView.hidden = YES;

    self.titleLable.text = @"支付";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}

//TODO:获取数据
- (void)setPayDict:(NSDictionary *)payDict{
    _payDict = [NSDictionary dictionary];
    
    _payDict = payDict;

   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reqCreateResult) name:WEIXINPAY_SUCCESS object:nil];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    isYuePay = NO;
    isSZFB = NO;
    isSWX = NO;
    nowPayStyle = 0;

    _codeDict = [NSDictionary dictionary];
    _resultDict = [NSMutableDictionary dictionary];
    
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 50) imageName:nil];
    [self setLabel:CGRectMake(10, setHeight, iPhoneWidth, 50) labFont:15 labText:@"奖品合计" textC:[UIColor blackColor]];
    
    _allLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth - 30, 50)];
    _allLab.backgroundColor = [UIColor clearColor];
    _allLab.textColor = [UIColor redColor];
    _allLab.textAlignment = NSTextAlignmentRight;
    _allLab.text = @"6000";
    _allLab.font = defaultFontSize(16);
    [self.view addSubview:_allLab];
    [self setLabel:CGRectMake(iPhoneWidth - 30, setHeight, 30, 50) labFont:16 labText:@"元" textC:[UIColor redColor]];
    
    setHeight = setHeight + 60;
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 50) imageName:nil];
    [self setLabel:CGRectMake(10, setHeight, 100, 50) labFont:17 labText:@"余额支付" textC:[UIColor blackColor]];
    
    _vacanciesLab = [[UILabel alloc] initWithFrame:CGRectMake(110, setHeight, iPhoneWidth-160, 50)];
    _vacanciesLab.backgroundColor = [UIColor clearColor];
    _vacanciesLab.textColor = [UIColor blackColor];
    _vacanciesLab.textAlignment = NSTextAlignmentLeft;
    _vacanciesLab.text = @"(余额:0000000000000元)";
    _vacanciesLab.font = defaultFontSize(16);
    [self.view addSubview:_vacanciesLab];

    _isyueBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 50, setHeight, 60, 50)];
    _isyueBtn.backgroundColor = [UIColor clearColor];
    [_isyueBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];
    [_isyueBtn addTarget:self action:@selector(isYuePressed) forControlEvents:UIControlEventTouchUpInside];
    [_isyueBtn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    [self.view addSubview:_isyueBtn];
    
    setHeight = setHeight + 50;
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 50) imageName:nil];
    [self setLabel:CGRectMake(10, setHeight, iPhoneWidth, 50) labFont:15 labText:@"其他支付方式" textC:[UIColor blackColor]];
    
    _otherLab = [[UILabel alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth - 30, 50)];
    _otherLab.backgroundColor = [UIColor clearColor];
    _otherLab.textColor = [UIColor redColor];
    _otherLab.textAlignment = NSTextAlignmentRight;
    _otherLab.text = @"6000";
    _otherLab.font = defaultFontSize(16);
    [self.view addSubview:_otherLab];
    [self setLabel:CGRectMake(iPhoneWidth - 30, setHeight, 30, 50) labFont:16 labText:@"元" textC:[UIColor redColor]];
    
    setHeight = setHeight + 50;
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 50) imageName:nil];
    _zfbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight + 10, 30, 30)];
    _zfbImgView.backgroundColor = [UIColor whiteColor];
    _zfbImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
    [self.view addSubview:_zfbImgView];
    

    [self setLabel:CGRectMake(80, setHeight, iPhoneWidth, 50) labFont:15 labText:@"支付宝" textC:[UIColor blackColor]];
    [self setBtn:CGRectMake(0, setHeight, iPhoneWidth, 50)  imageName:nil btnTag:10001 Color:[UIColor clearColor]];
//
//    setHeight = setHeight + 50;
//    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 50) imageName:nil];
//    
//    _wxImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight + 10, 30, 30)];
//    _wxImgView.backgroundColor = [UIColor whiteColor];
//    _wxImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
//    [self.view addSubview:_wxImgView];
//    
//    [self setLabel:CGRectMake(80, setHeight, iPhoneWidth, 50) labFont:15 labText:@"微信支付" textC:[UIColor blackColor]];
//    [self setBtn:CGRectMake(0, setHeight, iPhoneWidth, 50)  imageName:nil btnTag:10002 Color:[UIColor clearColor]];
    setHeight = setHeight + 70;

    // 抢宝说明
    UIButton   *showbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 50)];
    showbtn.backgroundColor = [UIColor redColor];
    [showbtn addTarget:self action:@selector(surePayPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showbtn];
    [showbtn setTitle:@"确认支付" forState:UIControlStateNormal];
    showbtn.titleLabel.textColor = [UIColor whiteColor];
    
    // 支付成功生成界面
    _showView = [[ShowSurePayView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    _showView.backgroundColor = [UIColor clearColor];
    _showView.delegate = self;
    [self.view addSubview:_showView];
    _showView.hidden = YES;
    _allLab.text = [_payDict objectForKey:@"pice"];
    allPay = [[_payDict objectForKey:@"pice"] floatValue];
    [self reqGetBalance];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];

}


//TODO:设置图片背景
- (void)setBgImgView:(CGRect )rect imageName:(NSString *)imgname{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.image = [UIImage imageNamed:imgname];
    [self.view addSubview:imageView];
}

//TODO:设置提示文字
- (void)setLabel:(CGRect )rect  labFont:(float )labfont labText:(NSString *)text textC:(UIColor *)color{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = color;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = text;
    lab.font = defaultFontSize(labfont);
    [self.view addSubview:lab];
}

//TODO:设置按钮
- (void)setBtn:(CGRect )rect imageName:(NSString *)imgname btnTag:(NSInteger )tag Color:(UIColor *)color{
    UIButton    *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = color;
    //    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnPassed:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    
    [self.view addSubview:btn];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:是否余额支付
- (void)isYuePressed{
    isYuePay = !isYuePay;
    if (isYuePay) {
        [_isyueBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_Yes.png"] forState:UIControlStateNormal];
        float sss;
        if ([[_payDict objectForKey:@"pice"] floatValue] < yue){
            sss = 0;
        }else{
            sss = [[_payDict objectForKey:@"pice"] floatValue] - yue;
            
        }
        _otherLab.text = [NSString stringWithFormat:@"%.2f",sss];
    }else{
        [_isyueBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];
        
        _otherLab.text = [NSString stringWithFormat:@"%.2f",[[_payDict objectForKey:@"pice"] floatValue]];
    }
}

//TODO:确认支付
- (void)surePayPressed{
    [self reqCreateWerlfare];

  
}

//TODO:生成口令
- (void)createKL{
    _showView.hidden = YES;
    [_showView.timer invalidate];
    KLCreateViewController *createViewController = [[KLCreateViewController alloc] init];
    createViewController.codeDict = _resultDict;
    [self.navigationController pushViewController:createViewController animated:YES];
}

//TODO:隐藏界面
- (void)hiddenBtnPressed{
    _showView.hidden = YES;
    
}

//TODO:响应事件
- (void)btnPassed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
        case 10001:
        {
            isSZFB = !isSZFB;
            isSWX = NO;
            if (isSZFB) {
                // 支付宝支付
                nowPayStyle = 1;
                _zfbImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_Yes.png"];
                _wxImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
            }else{
                // 余额支付
                nowPayStyle = 0;
                _zfbImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
                _wxImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
 
            }
            

        }
            break;
        case 10002:
        {
//            isSWX = !isSWX;
//            isSZFB = NO;
//            if (isSWX) {
//                // 微信支付
//                nowPayStyle = 2;
//                
//                _zfbImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
//                _wxImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_Yes.png"];
//            }else{
//                // 余额支付
//                nowPayStyle = 0;
//                
//                _zfbImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
//                _wxImgView.image = [UIImage imageNamed:@"ShoppingCart_Choose_No.png"];
//            }
           
        }
            break;
        default:
            break;
    }
}

#pragma mark 网络请求
//TODO:获取余额
- (void)reqGetBalance{
    // 获取余额
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GETBALANCE_FREE] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:进行支付-(福利)
- (void)reqCreateWerlfare{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_KWELFARE_CREATE] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[_payDict objectForKey:@"gid"] forKey:@"gid"];
    [dict setObject:[_payDict objectForKey:@"count"] forKey:@"count"];
    [dict setObject:[_payDict objectForKey:@"remark"] forKey:@"remark"];

    if (isYuePay &&  yue > allPay) {
        // 直接支付
        [dict setObject:@"1" forKey:@"usebalance"];
        [dict setObject:@"" forKey:@"paytype"];

    }else{
        // 第三方支付
        if (isYuePay) {
            [dict setObject:@"1" forKey:@"usebalance"];

  
        }else{
            [dict setObject:@"0" forKey:@"usebalance"];

        }
        switch (nowPayStyle) {
            case 0:
            {
                [self showProgressWithString:@"请先选择支付方式" hiddenAfterDelay:1];
                return;
            }
                break;
            case 1:
            {
                [dict setObject:@"1" forKey:@"paytype"];

                
                
            }
                break;
            case 2:
            {
                [dict setObject:@"2" forKey:@"paytype"];

            }
                break;
        }
    }
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}




//TODO:第三方支付成功
- (void)reqCreateResult{
    // 获取余额
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_KWELFARE_RESULT] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%@",[_codeDict objectForKey:@"code"]] forKey:@"out_trade_no"];
    [dict setObject:@"1" forKey:@"kind"];
    
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
            // 余额
        case REQ_GETBALANCE_FREE:{
            NSString *getY = [NSString stringWithFormat:@"%@",[resultDict objectForKey:RESP_CONTENT]];
            getY =  [getY stringByReplacingOccurrencesOfString:@"," withString:@""];
            // 显示余额
           _vacanciesLab.text = [NSString stringWithFormat:@"(余额:%.2f元)",[getY floatValue] / 100];
            yue = [getY floatValue] / 100;
            float sss;
            if ([[_payDict objectForKey:@"pice"] floatValue] < yue){
                sss = 0;
            }else{
                sss = [[_payDict objectForKey:@"pice"] floatValue] - yue  ;

            }
            _otherLab.text = [NSString stringWithFormat:@"%.2f",sss];
            
        }
            break;
            
            // 福利抢宝支付
        case REQ_KWELFARE_CREATE:
            // 群抢宝支付
        case REQ_KWELFARE_CREATE_GROUP:
        {
            if (isYuePay &&  yue > allPay) {
                // 直接支付成功
                _resultDict = [resultDict objectForKey:RESP_CONTENT];
                _showView.hidden = NO;
                
            }else{
                // 第三方支付获得数据
                _codeDict = [resultDict objectForKey:RESP_CONTENT];
                switch (nowPayStyle) {
                    case 1:
                    {
                        // 支付宝支付
                        NSDictionary *info = [resultDict objectForKey:RESP_CONTENT];
//                        NSInteger  uid =[[info objectForKey:@"uid"] integerValue];
                        _price = [[info objectForKey:@"money"] floatValue];
                        float kYue;
                        // 第三方支付
                        if (isYuePay) {
                            kYue = allPay - yue;
                        }else{
                            kYue = allPay;
                        }
                        
//                        if (uid != [UserDataManager sharedUserDataManager].userData.UID ||             _price!= kYue
//                            ) {
//                            [self showProgressWithString:@"非法操作" hiddenAfterDelay:1];
//                            return;
//                        }
                        _backUrl = [info objectForKey:@"url"];
                        _orderId = [info objectForKey:@"code"];
                        _subject = [info objectForKey:@"subject"];
                        _body = [info objectForKey:@"body"];
                        [self gotoZFBPlayPressed];

                    }
                        break;
                    case 2:
                    {
                        // 微信支付
                        NSDictionary *info = [resultDict objectForKey:RESP_CONTENT];
                        //                        NSInteger  uid =[[info objectForKey:@"uid"] integerValue];
                        _price = [[info objectForKey:@"money"] floatValue];
                        float kYue;
                        // 第三方支付
                        if (isYuePay) {
                            kYue = allPay - yue;
                        }else{
                            kYue = allPay;
                        }
                        
                        _nonceStr = [info objectForKey:@"nonce_str"];
                        _partnerId = [info objectForKey:@"mch_id"];
                        _prepayId = [info objectForKey:@"prepay_id"];
                        _signWX = [info objectForKey:@"timeStamp"];

                        app.isPayWX = YES;
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

            
        }
            break;
        case REQ_KWELFARE_RESULT:{
            [self reqGetBalance];

            // 第三方支付成功
            _resultDict = [resultDict objectForKey:RESP_CONTENT];
            _showView.hidden = NO;

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
            // 详情
        case REQ_KWELFARE_CREATE:
        case REQ_KWELFARE_CREATE_GROUP:
        case REQ_KWELFARE_RESULT:{
            
        }
            break;
            
        default:
            break;
    }
    
    
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
//            _codeDict = resultDic;
            if ([[resultDic objectForKey:@"result"] isEqualToString:@""] || [resultDic objectForKey:@"result"] == nil ) {
                [self showProgressWithString:@"支付失败" hiddenAfterDelay:1];
                return ;
            }
            [self reqCreateResult];
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
//                [self topayPressed];
                
            }
                break;
                // 微信充值
            case 2:
            {
//                [self toWXpayPressed];
                
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
//                [self topayPressed];
                
            }
                break;
                // 微信充值
            case 2:
            {
//                [self toWXpayPressed];
                
            }
                break;
            default:
                break;
        }
        
        
    }
}

@end
