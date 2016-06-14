


//
//  WelFareGetSearchGoodsView.m
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "WelFareGetSearchGoodsView.h"
#import "FontDefine.h"

@implementation WelFareGetSearchGoodsView


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
    float setHeight = 15;
    // 图片
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, setHeight  , iPhoneWidth/2 - 30, 130 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    
   
    [self addSubview:_goodsImgView];
    
    setHeight = setHeight + 130;
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5, setHeight, iPhoneWidth/2 - 30, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    _titleLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_titleLab];
    
    setHeight = setHeight + 55;
    
    //进度
    UILabel *proLab = [[UILabel alloc] initWithFrame:CGRectMake(5, setHeight, 75, 20)];
    proLab.backgroundColor = [UIColor clearColor];
    proLab.font = [UIFont systemFontOfSize:15];
    proLab.textAlignment = NSTextAlignmentLeft;
    proLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    proLab.text =@"价值: ￥";
    [self addSubview:proLab];
    
    if (iPhoneWidth>320) {
        // 价格
        _moneyLab= [[UILabel alloc] initWithFrame:CGRectMake(60, setHeight, iPhoneWidth - 220, 20)];
        _moneyLab.backgroundColor = [UIColor clearColor];
        _moneyLab.font = [UIFont systemFontOfSize:15];
        _moneyLab.textAlignment = NSTextAlignmentLeft;
        _moneyLab.textColor = UIColorWithRGB(155, 155, 155, 1);
        [self addSubview:_moneyLab];
    }else{
        
        // 价格
        _moneyLab= [[UILabel alloc] initWithFrame:CGRectMake(55, setHeight, iPhoneWidth - 220, 20)];
        _moneyLab.backgroundColor = [UIColor clearColor];
        _moneyLab.font = [UIFont systemFontOfSize:12];
        _moneyLab.textAlignment = NSTextAlignmentLeft;
        _moneyLab.textColor = UIColorWithRGB(155, 155, 155, 1);
        [self addSubview:_moneyLab];

        
    }
    


    // 加入清单
   _chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 2 - 68, setHeight, 65, 25)];
     _chooseBtn.backgroundColor = [UIColor clearColor];
    [self addSubview: _chooseBtn];
    [ _chooseBtn addTarget:self action:@selector(chooseBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [ _chooseBtn setTitle:@"选择商品" forState:UIControlStateNormal];
    [ _chooseBtn setTitleColor:UIColorWithRGB(233, 81, 88, 1) forState:UIControlStateNormal];
     _chooseBtn.titleLabel.font = defaultFontSize(13);
    
    
    [ _chooseBtn setBackgroundImage:[UIImage imageNamed:@"Snatch_Home_Border.png"] forState:UIControlStateNormal];

}

//TODO:获取数据
- (void)setNode:(SnatchHomeListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.title;
    self.moneyLab.text = _node.price;
    
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
}

//TODO:选择商品
- (void)chooseBtnPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag  = btn.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(chooseGoods:)]) {
        [_delegate chooseGoods:tag];
    }
}

@end
