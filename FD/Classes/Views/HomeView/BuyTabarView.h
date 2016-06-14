//
//  BuyTabarView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenBuyView.h"


@protocol BuyTabarViewDelegate <NSObject>

//TODO:综合排序
- (void)allAction:(UIButton *)newBtn;
//TODO:保证金
- (void)newlAction:(NSInteger )setTag;
//TODO:奖励
- (void)awardAction:(NSInteger )setTag;
//TODO:周期
- (void)timeAction:(NSInteger )setTag;
@end

@interface BuyTabarView : UIView
{
    BOOL isjoinMoneyUP;// 保证金升序
    BOOL isawardUP;// 奖励升序
    BOOL iscycleUP;// 周期升序
  
}

@property (nonatomic, assign) id<BuyTabarViewDelegate>          delegate;//
@property (nonatomic, strong) UIButton  *allBtn;
@property (nonatomic, strong) UIButton  *newlBtn;
@property (nonatomic, strong) UIButton  *awardBtn;
@property (nonatomic, strong) UIButton  *timeBtn;

@property (nonatomic , strong)UIImageView  *allImgView;
@property (nonatomic , strong)UIImageView  *joinMoneyImgView;// 保证金图标
@property (nonatomic , strong)UIImageView  *awardImgView;// 奖励图标
@property (nonatomic , strong)UIImageView  *cycleImgView;// 周期图标

@end
