//
//  ZCTradeView.h
//  FD
//
//  Created by Leo Xu on 15/4/30.
//  Copyright (c) 2015年 FD. All rights reserved.
//  交易密码视图\负责整个项目的交易密码输入

#import <UIKit/UIKit.h>

@class ZCTradeKeyboard;

@protocol ZCTradeViewDelegate <NSObject>

@optional
/** 输入完成点击确定按钮 */
- (NSString *)finish:(NSString *)pwd;

@end

@interface ZCTradeView : UIView

@property (nonatomic, weak) id<ZCTradeViewDelegate> delegate;

/** 完成的回调block */
@property (nonatomic, copy) void (^finish) (NSString *passWord);
@property (nonatomic, weak) NSString  *showStr;// 显示的提示
@property (nonatomic, assign) BOOL  isPass;//是否是输入密码

/** 快速创建 */
+ (instancetype)tradeView;

/** 弹出 */
- (void)show:(NSString *)str isP:(BOOL)isp;
- (void)showInView:(UIView *)view;

@end
