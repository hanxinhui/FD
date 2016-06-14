//
//  ShopTabarView.m
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ShopTabarView.h"
#import "FontDefine.h"


#define MENUHEIHT 40

@implementation ShopTabarView

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
    //头部底图
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 60)];
    headImgView.backgroundColor = UIColorWithRGB(249, 249, 249, 1);
    [headImgView setImage:[UIImage imageNamed:@""]];
    [self addSubview:headImgView];
    
    // 综合排序
    _allBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    _allBtn.backgroundColor = [UIColor clearColor];
    [_allBtn setTitle:@"综合排序" forState:UIControlStateNormal];
    _allBtn.titleLabel.font = defaultFontSize(17);
    [_allBtn setTitleColor:UIColorWithRGB(38, 38, 37, 1) forState:UIControlStateNormal];
    [_allBtn setTitleColor:UIColorWithRGB(255, 255, 255, 1) forState:UIControlStateSelected];
    [_allBtn addTarget:self action:@selector(allPressed) forControlEvents:UIControlEventTouchUpInside];
    [_allBtn setBackgroundImage:[UIImage imageNamed:@"a.png"] forState:UIControlStateNormal];
    [_allBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateHighlighted];
    [_allBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateSelected];
    [self addSubview:_allBtn];
    _allBtn.selected = YES;                         
    
    // 最新上线
    _newlBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 4, 0, iPhoneWidth / 4, 60)];
    _newlBtn.backgroundColor = [UIColor clearColor];
    [_newlBtn setTitle:@"最新上线" forState:UIControlStateNormal];
    _newlBtn.titleLabel.font = defaultFontSize(17);
    [_newlBtn setTitleColor:UIColorWithRGB(38, 38, 37, 1) forState:UIControlStateNormal];
    [_newlBtn setTitleColor:UIColorWithRGB(255, 255, 255, 1) forState:UIControlStateSelected];
    [_newlBtn setBackgroundImage:[UIImage imageNamed:@"a.png"] forState:UIControlStateNormal];
    [_newlBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateHighlighted];
    [_newlBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateSelected];
    [_newlBtn addTarget:self action:@selector(newlBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_newlBtn];
    
    // 奖励最多
    _awardBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 2, 0, iPhoneWidth / 4, 60)];
    _awardBtn.backgroundColor = [UIColor clearColor];
    [_awardBtn setTitle:@"奖励最多" forState:UIControlStateNormal];
    _awardBtn.titleLabel.font = defaultFontSize(13);
    [_awardBtn setTitleColor:UIColorWithRGB(38, 38, 37, 1) forState:UIControlStateNormal];
    [_awardBtn setTitleColor:UIColorWithRGB(255, 255, 255, 1) forState:UIControlStateSelected];
    [_awardBtn setBackgroundImage:[UIImage imageNamed:@"a.png"] forState:UIControlStateNormal];
    [_awardBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateHighlighted];
    [_awardBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateSelected];
    [_awardBtn addTarget:self action:@selector(awardBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_awardBtn];

    // 时间最长
    _timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 4 *3, 0, iPhoneWidth / 4, 60)];
    _timeBtn.backgroundColor = [UIColor clearColor];
    [_timeBtn setTitle:@"时间最长" forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = defaultFontSize(13);
    [_timeBtn setTitleColor:UIColorWithRGB(38, 38, 37, 1) forState:UIControlStateNormal];
    [_timeBtn setTitleColor:UIColorWithRGB(255, 255, 255, 1) forState:UIControlStateSelected];
    [_timeBtn setBackgroundImage:[UIImage imageNamed:@"a.png"] forState:UIControlStateNormal];
    [_timeBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateHighlighted];
    [_timeBtn setBackgroundImage:[UIImage imageNamed:@"Task_Buy_Grey.png"] forState:UIControlStateSelected];
    [_timeBtn addTarget:self action:@selector(timeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeBtn];

 
}

#pragma mark - 其他辅助功能
#pragma mark
//TODO:综合排序
- (void)allPressed{
    _newlBtn.selected = NO;
    _awardBtn.selected = NO;
    _timeBtn.selected = NO;
    _allBtn.selected = YES;

    if (_delegate && [_delegate respondsToSelector:@selector(allAction)]) {
        [_delegate allAction];
    }
}

//TODO:最新上线
- (void)newlBtnPressed{
    _newlBtn.selected = YES;
    _allBtn.selected = NO;
    _awardBtn.selected = NO;
    _timeBtn.selected = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(newlAction)]) {
        [_delegate newlAction];
    }
}

//TODO:奖励最多
- (void)awardBtnPressed{
    _allBtn.selected = NO;
    _newlBtn.selected = NO;
    _awardBtn.selected = YES;
    _timeBtn.selected = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(awardAction)]) {
        [_delegate awardAction];
    }
}

//TODO:时间最长
- (void)timeBtnPressed{
    _allBtn.selected = NO;
    _newlBtn.selected = NO;
    _awardBtn.selected = NO;
    _timeBtn.selected = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(timeAction)]) {
        [_delegate timeAction];
    }
}

@end
