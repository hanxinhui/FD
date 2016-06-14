//
//  ExplainViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:说明

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum{
    ShowRechargeStyle,//充值说明
    ShowBuyStyle,// 我要赚 说明
    ShowGetStyle,// 随心兑 说明
    ShowLayStyle//  我要抽 说明

}ExplainStyle;

@interface ExplainViewController : BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
   
}


@property (nonatomic, strong) UIWebView *conWebView;//加载界面
@property (nonatomic, strong) NSString  *goodID;//商品id
@property (nonatomic, strong) NSString  *jsonString;//数据

@property (nonatomic) ExplainStyle   explainStyle;// 判断说明类型
@end

