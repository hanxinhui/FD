//
//  AddCountersignView.h
//  FD
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnatchDetailNode.h"
#import "MMLabel.h"



@protocol AddCountersignViewDelegate <NSObject>

//TODO:弹出提示
- (void)showAlertMsgPressed:(NSString *)msg;
- (void)cancelAddView;// 取消参加
- (void)addSnatch:(NSInteger )num;//夺宝
- (void)addNumSnatch;//增加数目
- (void)lessNumSnatch;//减少数目

@end
@interface AddCountersignView : UIView<UITextFieldDelegate>
{
    
}

@property (nonatomic, strong) UITextField  *numTextField;// 选择数量
@property (nonatomic, assign) NSInteger     canNum;// 可选数量
@property (nonatomic, assign) id<AddCountersignViewDelegate>          delegate;//

@property (nonatomic, assign) BOOL isShowKeyP;// 是否显示键盘
@property (nonatomic, strong) SnatchDetailNode *dNode;// 数据
@property (nonatomic, strong) MMLabel   *showLab;// 显示说明

- (void)showInView:(UIView *)view;
- (void)cancelPicker;
@end
