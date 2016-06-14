//
//  WithdrawViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:提现

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyBankListNode.h"
#import "CustomTextField.h"
#import "SelectDataView.h"
#import "SelectPickerView.h"
#import "STAlertView.h"


@interface WithdrawViewController : BaseViewController<UITextFieldDelegate,SelectDataViewDelegate,SelectPickerViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
{
    float setHeight;//设置高度
    BOOL  canTX;// 可以提现
}

@property (nonatomic, strong) MyBankListNode    *bankNode;//银行信息
@property (nonatomic, strong) CustomTextField   *cityTextField;//省市
@property (nonatomic, strong) NSString            *provinceStr;//省
@property (nonatomic, strong) NSString           *cityStr;//市
@property (nonatomic, strong) CustomTextField *keyTextField;//关键字
@property (nonatomic, strong) CustomTextField           *pointTextField;//网点
@property (nonatomic, strong) SelectDataView           *cityDataView;//地址
@property (nonatomic, strong) SelectPickerView           *drawPickerView;//网点地址
@property (nonatomic, strong) NSMutableArray           *drawArr;//网点地址
@property (nonatomic, strong) CustomTextField           *moneyTextField;//提现金额
@property (nonatomic, strong) UILabel           *withholdingLab;//提现金额
@property (nonatomic , strong) UIScrollView     *mainScrollView;//

@property (nonatomic, strong) STAlertView *stAlertView;

@end

