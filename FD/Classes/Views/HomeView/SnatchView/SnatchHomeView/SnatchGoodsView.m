//
//  SnatchGoodsView.m
//  SnatchGoodsView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "SnatchGoodsView.h"
#import "FontDefine.h"

@interface SnatchGoodsView()

@end

@implementation SnatchGoodsView
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
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, setHeight, iPhoneWidth/2 - 30, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    _titleLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_titleLab];
    
    setHeight = setHeight + 50;

    //进度
    UILabel *proLab = [[UILabel alloc] initWithFrame:CGRectMake(10, setHeight, 75, 20)];
    proLab.backgroundColor = [UIColor clearColor];
    proLab.font = [UIFont systemFontOfSize:12];
    proLab.textAlignment = NSTextAlignmentLeft;
    proLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    proLab.text = @"开奖进度";
    [self addSubview:proLab];
    

    // 价格
    _progressLab= [[UILabel alloc] initWithFrame:CGRectMake(60, setHeight, 30, 20)];
    _progressLab.backgroundColor = [UIColor clearColor];
    _progressLab.font = [UIFont systemFontOfSize:12];
    _progressLab.textAlignment = NSTextAlignmentLeft;
    
    _progressLab.textColor = UIColorWithRGB(28, 120, 245, 1);
    [self addSubview:_progressLab];
    
    // 进度条
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(8, setHeight + 25, iPhoneWidth / 2 - 110, 10)];
    _progressView.backgroundColor = [UIColor clearColor];
    //更改进度条高度
    _progressView.transform = CGAffineTransformMakeScale(1.0f,3.5f);
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = 5;
    _progressView.trackTintColor = UIColorWithRGB(238, 238, 239, 1);
    [_progressView setTintColor:UIColorWithRGB(253, 188, 59, 1)];
    [self addSubview:_progressView];
    [_progressView setProgress:0.3];
    
    // 显示详情
    _showBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth / 2, 235)];
    _showBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_showBtn];
    [_showBtn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];

    
    // 加入清单
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 2 - 73, setHeight, 70, 30)];
    _addBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_addBtn];
    [_addBtn addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"加入清单" forState:UIControlStateNormal];
    [_addBtn setTitleColor:UIColorWithRGB(238, 116, 55, 1) forState:UIControlStateNormal];
    _addBtn.titleLabel.font = defaultFontSize(15);

    
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"Snatch_Home_Border.png"] forState:UIControlStateNormal];
}

//TODO:获取数据
- (void)setNode:(SnatchHomeListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.title;
    [_progressView setProgress:[_node.progress floatValue]/ [_node.price floatValue]];
    self.showBtn.tag = [_node.Hid integerValue];
    self.addBtn.tag = [_node.Hid integerValue];
    self.progressLab.text = [NSString stringWithFormat:@"%@%%",_node.progress];
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:_node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
}
//TODO:加入购物车
- (void)addCart:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(addCartPressed:)]) {
        [_delegate addCartPressed:sender];
    }
}
//TODO:显示详情
- (void)showDetail:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(showDetailPressed:)]) {
        [_delegate showDetailPressed:sender];
    }
}

@end
