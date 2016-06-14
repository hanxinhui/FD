//
//  PayResultHeadView.m
//  PayResultHeadView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "PayResultHeadView.h"
#import "FontDefine.h"

@interface PayResultHeadView()

@end

@implementation PayResultHeadView
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
    float setHeight = 0;
    UIImageView *bgIMgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 150)];
    bgIMgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgIMgView];
    
    // 标题
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, setHeight, iPhoneWidth - 30, 100)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    // leoxu delete
    titleLab.text = @"恭喜您，参与成功!\n请等待系统为您揭晓!";
    titleLab.numberOfLines = 0;
    titleLab.textColor = UIColorWithRGB(153, 154, 154, 1);
    [self addSubview:titleLab];

    setHeight = setHeight + 100;
    

    // 继续夺宝
   UIButton *goonBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth / 2 - 30, 35)];
    goonBtn.backgroundColor = UIColorWithRGB(253, 109, 18, 1);
    [self addSubview:goonBtn];
    [goonBtn addTarget:self action:@selector(goonSnatch) forControlEvents:UIControlEventTouchUpInside];
    [goonBtn setTitle:@"继续夺宝" forState:UIControlStateNormal];
    [goonBtn setTitleColor:UIColorWithRGB(255, 234, 217, 1) forState:UIControlStateNormal];
    goonBtn.titleLabel.font = defaultFontSize(15);
//    [goonBtn.layer setMasksToBounds:NO];
//    [goonBtn.layer setCornerRadius:8.0];
//    [goonBtn.layer setBorderWidth:2.0];
//    [goonBtn.layer setBorderColor:[UIColorWithRGB(253, 188, 59, 1) CGColor]];
    
    
    // 查看夺宝记录
    UIButton *toSnatchBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 2 + 5, setHeight, iPhoneWidth / 2 - 30, 35)];
    toSnatchBtn.backgroundColor = UIColorWithRGB(225, 226, 227, 1);
    [self addSubview:toSnatchBtn];
    [toSnatchBtn addTarget:self action:@selector(toSnatchRecord) forControlEvents:UIControlEventTouchUpInside];
    [toSnatchBtn setTitle:@"查看夺宝记录" forState:UIControlStateNormal];
    [toSnatchBtn setTitleColor:UIColorWithRGB(71, 72, 72, 1) forState:UIControlStateNormal];
    toSnatchBtn.titleLabel.font = defaultFontSize(15);
//    [toSnatchBtn.layer setMasksToBounds:NO];
//    [toSnatchBtn.layer setCornerRadius:8.0];
//    [toSnatchBtn.layer setBorderWidth:2.0];
//    [toSnatchBtn.layer setBorderColor:[UIColorWithRGB(253, 188, 59, 1) CGColor]];
    
    setHeight = setHeight + 50;

    // 底部说明
    _footLab = [[MMLabel alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 25)];
    _footLab.backgroundColor = [UIColor clearColor];
    _footLab.font = defaultFontSize(14);
    _footLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_footLab];
//    _footLab.keyWordColor=UIColorWithRGB(236, 92, 75, 0.8);
    _footLab.textColor = UIColorWithRGB(158, 160, 160, 1);
//    _footLab.text = @"您成功参与了1件商品共2人次夺宝,信息如下:";
//    _footLab.keyWord = @"1";
//    _footLab.keyWord = @"2";

    
}


//TODO:继续夺宝
- (void)goonSnatch{
    if (_delegate && [_delegate respondsToSelector:@selector(goonSnatchPressed)]) {
        [_delegate goonSnatchPressed];
    }
}
//TODO:查看夺宝记录
- (void)toSnatchRecord{
    if (_delegate && [_delegate respondsToSelector:@selector(toSnatchRecordPressed)]) {
        [_delegate toSnatchRecordPressed];
    }
}

@end
