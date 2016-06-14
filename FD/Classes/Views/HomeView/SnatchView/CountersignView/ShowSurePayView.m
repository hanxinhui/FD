//
//  ShowSurePayView.m
//  SnatchGoodsView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "ShowSurePayView.h"
#import "FontDefine.h"

@interface ShowSurePayView()

@end

@implementation ShowSurePayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self creat];
    }
    return self;
}

//TODO:初始化数据
- (void)creat{
    // 确认生成
    UIButton *hiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    hiddenBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:hiddenBtn];
    [hiddenBtn addTarget:self action:@selector(hiddenBtnPressed) forControlEvents:UIControlEventTouchUpInside];

    
    float setSW = 360;
    float setSH = 453;
    if (iPhoneWidth < 360) {
        setSW = iPhoneWidth;
        setSH = 453 * iPhoneWidth / 360;
    }
    
    // 展示图片
    _firstImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - setSW)/ 2, (iPhoneHeight - setSH) / 2, setSW,setSH )];
    _firstImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_firstImgView];
    [_firstImgView setImage:[UIImage imageNamed:@"kl_create_bg_first.png"]];
    _firstImgView.hidden = NO;

    // 展示图片
    _secondImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - setSW)/ 2, (iPhoneHeight - setSH) / 2, setSW,setSH )];
    _secondImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_secondImgView];
    [_secondImgView setImage:[UIImage imageNamed:@"kl_create_bg_second.png"]];
    _secondImgView.hidden = YES;

    float setW = 355;
    float setH = 250;
    if (iPhoneWidth < 355) {
        setW = iPhoneWidth;
        setH = 250 * iPhoneWidth / 355;
    }
    // 展示图片
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - setW)/ 2, (iPhoneHeight - setH) / 2, setW,setH )];
    bgImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgImgView];
    [bgImgView setImage:[UIImage imageNamed:@"kl_create_bg.png"]];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

    
    // 确认生成
    UIButton *setCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake((iPhoneWidth  - 166)/ 2, (iPhoneHeight - setH) / 2 + setH - 70 , 166, 40)];
    setCodeBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:setCodeBtn];
    [setCodeBtn setImage:[UIImage imageNamed:@"kl_create_btn.png"] forState:UIControlStateNormal];
    [setCodeBtn addTarget:self action:@selector(createPressed:) forControlEvents:UIControlEventTouchUpInside];
}

//TODO:倒计时
- (void)timerFireMethod:(NSTimer *)theTimer
{
    _firstImgView.hidden = !_firstImgView.hidden;
    _secondImgView.hidden = !_secondImgView.hidden;

}

//TODO:生成口令
- (void)createPressed:(id)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(createKL)]) {
        [_timer invalidate];
        [_delegate createKL];
    }
}

//TODO:隐藏界面
- (void)hiddenBtnPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(hiddenBtnPressed)]) {
        [_delegate hiddenBtnPressed];
    }
}

@end
