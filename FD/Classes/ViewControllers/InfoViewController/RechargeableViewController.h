//
//  RechargeableViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:充值

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"



@interface Product : NSObject
{
    float _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString  *body;
@property (nonatomic, copy) NSString  *orderId;

@end
@interface RechargeableViewController : BaseViewController<UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    float setHeight;//设置高度
    NSInteger nowPayStyle;// 当前支付方式
    NSMutableArray *_products;
    SEL _result;
}


@property (nonatomic, strong)  CustomTextField  *payTextField;    // 输入金额
@property (strong, nonatomic)  UIButton             *payTextBtn;//手机号清除
@property (strong, nonatomic)  UIButton             *payZFB;//选择支付宝支付
@property (strong, nonatomic)  UIButton             *payWX;//选择微信支付
@property (nonatomic , strong) UIScrollView     *mainScrollView;//

@property (nonatomic, assign) float price;// 金额
@property (nonatomic, copy) NSString *subject;//名称
@property (nonatomic, copy) NSString *body;//内容
@property (nonatomic, copy) NSString *orderId;//订单号
@property (nonatomic, copy) NSString *backUrl;// 回调连接

@property (nonatomic, copy) NSString *partnerId;//
@property (nonatomic, copy) NSString *prepayId;//
@property (nonatomic, copy) NSString *nonceStr;//
@property (nonatomic, copy) NSString *signWX;//

@property (nonatomic, assign) SEL result;
//- (void)paymentResult:(NSString *)result;
@end

