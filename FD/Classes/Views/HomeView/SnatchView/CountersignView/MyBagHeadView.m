//
//  MyBagHeadView.m
//  MyBagHeadView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "MyBagHeadView.h"
#import "FontDefine.h"

@interface MyBagHeadView()

@end

@implementation MyBagHeadView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor clearColor];
        [self creat];
    }
    return self;
}

//TODO:初始化数据
- (void)creat{
    float setHeight = 15;
    // 图片
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 80)/ 2, setHeight  , 80, 80 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_goodsImgView];
    [_goodsImgView setImage:[UIImage imageNamed:@"Home_head_big.png"]];
    // 头像设置圆形
    _goodsImgView.layer.cornerRadius = 40;
    _goodsImgView.layer.masksToBounds = YES;

    setHeight = setHeight + 100;
    // 标题
    _titleLab = [[MMLabel alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 25)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = defaultFontSize(14);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLab];
    _titleLab.keyWordColor=UIColorWithRGB(236, 92, 75, 0.8);
    _titleLab.textColor = UIColorWithRGB(158, 160, 160, 1);
    _titleLab.text = @"抢到13个抢宝，价值";

    _titleLab.keyWord=@"徐海洋";

    setHeight = setHeight + 25;

    // 总价格
    _moneyLab = [[MMLabel alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _moneyLab.backgroundColor = [UIColor clearColor];
    _moneyLab.textColor = UIColorWithRGB(236, 92, 75, 1);

    _moneyLab.font = defaultFontSize(30);
    _moneyLab.keyWordColor=UIColorWithRGB(236, 92, 75, 0.8);

    _moneyLab.keyWordFont = defaultFontSize(13);
    _moneyLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_moneyLab];
    _moneyLab.text = @"6988元";

    _moneyLab.keyWord=@"元";

    setHeight = setHeight + 40;
    
 }


@end
