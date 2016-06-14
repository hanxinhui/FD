//
//  WelFareGetSearchListCell.m
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "WelFareGetSearchListCell.h"
#import "FontDefine.h"

@implementation WelFareGetSearchListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setGoodsView];// 设置展示界面
    }
    return self;
}

//TODO:初始化界面
- (void)setGoodsView{
    
    _firstGoodsView = [[WelFareGetSearchGoodsView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/2, 235)];
    _firstGoodsView.backgroundColor = [UIColor clearColor];
    [self addSubview:_firstGoodsView];
    _firstGoodsView.delegate = self;
    
    UIImageView *lImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 2, 0, 1, 235)];
    lImgView.backgroundColor = UIColorWithRGB(228, 228, 228, 0.7);;
    [self addSubview:lImgView];
    
    _secondGoodsView = [[WelFareGetSearchGoodsView alloc] initWithFrame:CGRectMake(iPhoneWidth/2, 0, iPhoneWidth/2, 235)];
    _secondGoodsView.backgroundColor = [UIColor clearColor];
    [self addSubview:_secondGoodsView];
    _secondGoodsView.delegate = self;
    
}


//TODO:选择产品
- (void)chooseGoods:(NSInteger )tag{
    if (_delegate && [_delegate respondsToSelector:@selector(chooseGoodsPreesd:)]) {
        [_delegate chooseGoodsPreesd:tag];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
