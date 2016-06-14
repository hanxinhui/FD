//
//  SnatchHomeCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SnatchHomeCell.h"
#import "FontDefine.h"

@implementation SnatchHomeCell

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
    _firstGoodsView = [[SnatchGoodsView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth/2, 235)];
    _firstGoodsView.backgroundColor = [UIColor clearColor];
    [self addSubview:_firstGoodsView];
    _firstGoodsView.delegate = self;
    
    UIImageView *lImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 2, 0, 1, 235)];
    lImgView.backgroundColor = UIColorWithRGB(228, 228, 228, 0.7);;
    [self addSubview:lImgView];
    
    _secondGoodsView = [[SnatchGoodsView alloc] initWithFrame:CGRectMake(iPhoneWidth/2, 0, iPhoneWidth/2, 235)];
    _secondGoodsView.backgroundColor = [UIColor clearColor];
    [self addSubview:_secondGoodsView];
    _secondGoodsView.delegate = self;

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//TODO:加入购物车
- (void)addCartPressed:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(addCart:)]) {
        [_delegate addCart:sender];
    }
}

//TODO:详情
- (void)showDetailPressed:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(showDetail:)]) {
        [_delegate showDetail:sender];
    }
}
@end


