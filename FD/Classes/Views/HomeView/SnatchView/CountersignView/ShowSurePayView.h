//
//  ShowSurePayView.h
//  ShowSurePayView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ShowSurePayViewDelegate <NSObject>

//TODO:生成口令
- (void)createKL;

//TODO:隐藏界面
- (void)hiddenBtnPressed;


@end
@interface ShowSurePayView : UIView

@property (nonatomic, strong) UIImageView   *firstImgView;//背景
@property (nonatomic, strong) UIImageView   *secondImgView;//背景
@property (nonatomic, strong) NSTimer *timer;// 定时器


@property (nonatomic, assign) id<ShowSurePayViewDelegate>          delegate;//

@end
