//
//  SnatchPayViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:支付奖品订单

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


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

typedef enum {
    groupPayStyle,// 群抢宝支付
    publicPayStyle // 公共支付
    
} PayStyle;


@interface SnatchPayViewController : BaseViewController {
    float setHeight;//设置高度
    
    BOOL  isYuePay;//是否余额支付
    
    float yue;// 余额
    float allPay;// 总额
    
    NSInteger nowPayStyle;// 当前支付方式
    NSMutableArray *_products;
    
    BOOL isSZFB;// 是否选中支付宝
    BOOL isSWX;// 是否选中微信
    
}

@property (nonatomic ,strong) UILabel   *allLab;// 奖品合计
@property (nonatomic ,strong) UILabel   *vacanciesLab;// 余额
@property (nonatomic ,strong) UIButton   *isyueBtn;// 是否余额支付
@property (nonatomic ,strong) UILabel   *otherLab;// 其他支付方式
@property (nonatomic ,strong) UIImageView   *zfbImgView;//支付宝显示
@property (nonatomic ,strong) UIImageView   *wxImgView;// 微信显示

@property (nonatomic, strong) NSDictionary   *payDict;// 数据字典
@property (nonatomic, strong) NSMutableDictionary   *resultDict;// 数据字典
@property (nonatomic, strong) NSDictionary   *codeDict;// 第三方支付返回数据
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
@property (nonatomic) PayStyle       payStyle;// 请求支付类型



@end

