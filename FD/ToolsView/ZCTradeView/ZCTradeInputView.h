//
//  ZCTradeInputView.h
//  FD
//
//  Created by Leo Xu on 15/4/30.
//  Copyright (c) 2015年 FD. All rights reserved.
//  交易输入视图

#import <Foundation/Foundation.h>

static NSString *ZCTradeInputViewCancleButtonClick = @"ZCTradeInputViewCancleButtonClick";
static NSString *ZCTradeInputViewOkButtonClick = @"ZCTradeInputViewOkButtonClick";
static NSString *ZCTradeInputViewPwdKey = @"ZCTradeInputViewPwdKey";

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class ZCTradeInputView;

@protocol ZCTradeInputViewDelegate <NSObject>

@optional
/** 确定按钮点击 */
- (void)tradeInputView:(ZCTradeInputView *)tradeInputView okBtnClick:(UIButton *)okBtn;
/** 取消按钮点击 */
- (void)tradeInputView:(ZCTradeInputView *)tradeInputView cancleBtnClick:(UIButton *)cancleBtn;

@end

@interface ZCTradeInputView : UIView
@property (nonatomic, weak) id<ZCTradeInputViewDelegate> delegate;
@property (nonatomic, weak) NSString *getShowStr;//获得提示
@end
