//
//  SnatchClassifyListCell.m
//  FD
//
//  Created by leoxu on 15/12/16.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "SnatchClassifyListCell.h"
#import "FontDefine.h"

@implementation SnatchClassifyListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creat];
    }
    return self;
}
//TODO:初始化数据
- (void)creat{
    
    float setHeight = 15;
    // 图片
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight  , 60, 90 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_goodsImgView];
    
    if (iPhoneWidth>320) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(110, setHeight, iPhoneWidth - 180, 60)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.font = [UIFont systemFontOfSize:20];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 0;
        //    _titleLab.lineBreakMode = NSLineBreakByWordWrapping;
        
        _titleLab.textColor = UIColorWithRGB(37, 38, 38, 1);
        [self addSubview:_titleLab];
        
    }else{
        // 标题
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(110, setHeight-10, iPhoneWidth - 120, 60)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.font = [UIFont systemFontOfSize:18];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 0;
        //    _titleLab.lineBreakMode = NSLineBreakByWordWrapping;
        
        _titleLab.textColor = UIColorWithRGB(37, 38, 38, 1);
        [self addSubview:_titleLab];
    }
    
    
    setHeight = setHeight+70;
    // 进度条
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(110, setHeight, iPhoneWidth/2  - 60, 40)];
    _progressView.backgroundColor = [UIColor clearColor];
    //更改进度条高度
    _progressView.transform = CGAffineTransformMakeScale(1.0f,3.5f);
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = 5;
    _progressView.trackTintColor = UIColorWithRGB(238, 238, 239, 1);
    [_progressView setTintColor:UIColorWithRGB(253, 188, 59, 1)];
    [self addSubview:_progressView];
//    [_progressView setProgress:0.3];
    
    setHeight = setHeight-17;
    // 加入清单
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth  - 100, setHeight, 80, 35)];
    _addBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_addBtn];
    [_addBtn setTitle:@"加入清单" forState:UIControlStateNormal];
    [_addBtn setTitleColor:UIColorWithRGB(192, 40, 43, 1) forState:UIControlStateNormal];
    _addBtn.titleLabel.font = defaultFontSize(15);
    [_addBtn.layer setMasksToBounds:NO];
    [_addBtn.layer setCornerRadius:8.0];
    [_addBtn.layer setBorderWidth:2.0];
    [_addBtn.layer setBorderColor:[UIColorWithRGB(192, 40, 43, 1) CGColor]];
    [_addBtn addTarget:self action:@selector(addCartPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    setHeight = setHeight+40;
    // // 总需
    [self setTheLab:CGRectMake(110, setHeight, 40, 20) textColor:UIColorWithRGB(104, 106, 106, 1) labText:@"总需" setFont:14 setCen:NO];
    
    //总需
    _needLab = [[UILabel alloc] initWithFrame:CGRectMake(140, setHeight, 75, 20)];
    
    
    _needLab.backgroundColor = [UIColor clearColor];
    _needLab.font = [UIFont systemFontOfSize:15];
    _needLab.textAlignment = NSTextAlignmentLeft;
    _needLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_needLab];
    
    //    //剩余
    [self setTheLab:CGRectMake(150, setHeight, 80, 20) textColor:UIColorWithRGB(104, 106, 106, 1) labText:@"剩余" setFont:14 setCen:YES];
    //剩余
    _residueLab = [[UILabel alloc] initWithFrame:CGRectMake(230, setHeight, 75, 20)];
    _residueLab.backgroundColor = [UIColor clearColor];
    _residueLab.font = [UIFont systemFontOfSize:15];
    _residueLab.textAlignment = NSTextAlignmentLeft;
    _residueLab.textColor = UIColorWithRGB(0, 118, 235, 1);
    [self addSubview:_residueLab];
    
    // 显示详情
    _showBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth-100 , 140)];
    _showBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_showBtn];
    [_showBtn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    

    
}

//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setCen:(BOOL )cen{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (cen) {
        lab.textAlignment = NSTextAlignmentRight;
        
    }else{
        lab.textAlignment = NSTextAlignmentLeft;
        
    }
    lab.font = [UIFont systemFontOfSize:font];
    [self addSubview:lab];
}


//TODO:获取数据
- (void)setNode:(SnatchHomeListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.title;
    [_progressView setProgress:[_node.progress integerValue]/ [_node.price integerValue]];
    _addBtn.tag = [_node.Hid integerValue];
    self.needLab.text = _node.price;
    self.residueLab.text = [NSString stringWithFormat:@"%ld",[_node.price integerValue] - [_node.progress integerValue]];
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"Public_List_NoImg.png"]];
    
     self.showBtn.tag = [_node.Hid integerValue];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
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
- (void)showDetail:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(showDetail:)]) {
        [_delegate showDetail:sender];
    }
}


@end
