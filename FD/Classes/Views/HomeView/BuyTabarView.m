//
//  BuyTabarView.m
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "BuyTabarView.h"
#import "FontDefine.h"
#import "AnyBuyView.h"


#define MENUHEIHT 40

@implementation BuyTabarView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self commHeadInit];
    }
    return self;
}



#pragma mark UI初始化
//TODO:初始化数组
-(void)commHeadInit{
    float setDownH = 44;
    if (iPhoneWidth > 320) {
        setDownH = 44;
    }else{
        setDownH = TARBAR_HIGHT-2;
    }

    // 综合排序
    _allBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 50, setDownH)];
    _allBtn.backgroundColor = [UIColor whiteColor];
    [_allBtn setTitle:@"综合" forState:UIControlStateNormal];
    _allBtn.titleLabel.font = defaultFontSize(15);
    [_allBtn setTitleColor:UIColorWithRGB(153, 153, 153, 1) forState:UIControlStateNormal];
    [_allBtn setTitleColor:UIColorWithRGB(258, 95, 80, 1) forState:UIControlStateSelected];

    [_allBtn addTarget:self action:@selector(allPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_allBtn];
    _allBtn.selected = YES;
    
  _allImgView = [[UIImageView alloc] initWithFrame:CGRectMake(54 , setDownH/2-3, 13, 8)];
   _allImgView.image = [UIImage imageNamed:@"AnyBuy_Head_D.png"];

    [self addSubview:_allImgView];
    
    // 保证金
    _newlBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 2 - 65, 0, 50, setDownH)];
    _newlBtn.backgroundColor = [UIColor whiteColor];
    [_newlBtn setTitle:@"保证金" forState:UIControlStateNormal];
    _newlBtn.titleLabel.font = defaultFontSize(15);
    [_newlBtn setTitleColor:UIColorWithRGB(139, 141, 144, 1) forState:UIControlStateNormal];
   [_newlBtn setTitleColor:UIColorWithRGB(258, 95, 80, 1) forState:UIControlStateSelected];
    [_newlBtn addTarget:self action:@selector(newlBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_newlBtn];
    // 保证金状态图标
    _joinMoneyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 2 - 16, setDownH/2, 8, 4)];
    _joinMoneyImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    [self addSubview:_joinMoneyImgView];
    isjoinMoneyUP = NO;
    
    // 奖励最多
    _awardBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 4*3 - 60, 0, 40, setDownH)];
    _awardBtn.backgroundColor = [UIColor whiteColor];
    [_awardBtn setTitle:@"奖励" forState:UIControlStateNormal];
    _awardBtn.titleLabel.font = defaultFontSize(15);
    [_awardBtn setTitleColor:UIColorWithRGB(139, 141, 144, 1) forState:UIControlStateNormal];
     [_awardBtn setTitleColor:UIColorWithRGB(258, 95, 80, 1) forState:UIControlStateSelected];
    [_awardBtn addTarget:self action:@selector(awardBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_awardBtn];

    // 奖励状态图标
    _awardImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 4*3 - 24, setDownH/2, 8, 4)];
    _awardImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    [self addSubview:_awardImgView];
    isawardUP = NO;
    
    // 周期
    _timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth -60, 0, 40 , setDownH)];
    _timeBtn.backgroundColor = [UIColor whiteColor];
    [_timeBtn setTitle:@"周期" forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = defaultFontSize(15);
    [_timeBtn setTitleColor:UIColorWithRGB(139, 141, 144, 1) forState:UIControlStateNormal];
   [_timeBtn setTitleColor:UIColorWithRGB(258, 95, 80, 1) forState:UIControlStateSelected];
    [_timeBtn addTarget:self action:@selector(timeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeBtn];

    // 周期状态图标
    _cycleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth -24, setDownH/2, 8,4)];
    _cycleImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    [self addSubview:_cycleImgView];
    iscycleUP = NO;
}

#pragma mark - 其他辅助功能
#pragma mark
//TODO:综合排序

- (void)allPressed:(UIButton *)newBtn{
    
     _allImgView.image = [UIImage imageNamed:@"AnyBuy_Head_UR.png"];
    
    _awardImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _cycleImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _joinMoneyImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    
    _newlBtn.selected = NO;
    _awardBtn.selected = NO;
    _timeBtn.selected = NO;
    _allBtn.selected = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(allAction:)]) {
        [_delegate allAction:newBtn];
    }

}

//TODO:保证金
- (void)newlBtnPressed{
    NSInteger  tag = 3;
    if (isjoinMoneyUP) {
        _joinMoneyImgView.image = [UIImage imageNamed:@"AnyBuy_Head_up.png"];
        tag = 4;
    }else{
        _joinMoneyImgView.image = [UIImage imageNamed:@"AnyBuy_Head_R.png"];
        tag = 3;
    }
 
    isjoinMoneyUP = !isjoinMoneyUP;
    
    _awardImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _cycleImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _allImgView.image = [UIImage imageNamed:@"AnyBuy_Head_B.png"];
    
    _newlBtn.selected = YES;
    

    
    _allBtn.selected = NO;
    _awardBtn.selected = NO;
    _timeBtn.selected = NO;
    _newlBtn.titleLabel.textColor = [UIColor redColor];

    if (_delegate && [_delegate respondsToSelector:@selector(newlAction:)]) {
        [_delegate newlAction:tag];
    }

  
}

//TODO:奖励最多
- (void)awardBtnPressed{
    NSInteger  tag = 5;

    if (isawardUP) {
        _awardImgView.image = [UIImage imageNamed:@"AnyBuy_Head_up.png"];
        tag = 6;
    }else{
        _awardImgView.image = [UIImage imageNamed:@"AnyBuy_Head_R.png"];
        tag = 5;

    }

    isawardUP = !isawardUP;
    
    _joinMoneyImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _cycleImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _allImgView.image = [UIImage imageNamed:@"AnyBuy_Head_B.png"];
    _awardBtn.selected = YES;
    
    
    _allBtn.selected = NO;
    _newlBtn.selected = NO;

    _timeBtn.selected = NO;

    _awardBtn.titleLabel.textColor = [UIColor redColor];

    if (_delegate && [_delegate respondsToSelector:@selector(awardAction:)]) {
        [_delegate awardAction:tag];
    }
}

//TODO:周期
- (void)timeBtnPressed{
    NSInteger  tag = 7;

    if (iscycleUP) {
        _cycleImgView.image = [UIImage imageNamed:@"AnyBuy_Head_up.png"];
        tag = 8;

    }else{
        _cycleImgView.image = [UIImage imageNamed:@"AnyBuy_Head_R.png"];
        tag = 7;

    }
    
    iscycleUP = !iscycleUP;

    _joinMoneyImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _awardImgView.image = [UIImage imageNamed:@"AnyBuy_Head_G.png"];
    _allImgView.image = [UIImage imageNamed:@"AnyBuy_Head_B.png"];
    
    _timeBtn.selected = YES;
    
    _allBtn.selected = NO;
    _newlBtn.selected = NO;
    _awardBtn.selected = NO;

    
    _timeBtn.titleLabel.textColor = [UIColor redColor];

    if (_delegate && [_delegate respondsToSelector:@selector(timeAction:)]) {
        [_delegate timeAction:tag];
    }
}

@end
