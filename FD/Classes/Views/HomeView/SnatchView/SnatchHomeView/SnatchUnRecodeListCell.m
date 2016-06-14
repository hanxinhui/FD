//
//  SnatchUnRecodeListCell.m
//  FD
//
//  Created by leoxu on 15/12/16.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "SnatchUnRecodeListCell.h"
#import "FontDefine.h"

@implementation SnatchUnRecodeListCell


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
    
    float setHeight = 10;
    
    // 图片
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setHeight+20  , 80 ,80 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_goodsImgView];
    
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setHeight+20, iPhoneWidth/2+50, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
       _titleLab.numberOfLines = 0;
    
    _titleLab.textColor = UIColorWithRGB(90,92,92,1);
    [self addSubview:_titleLab];
    
    setHeight = setHeight +60;
    //    期号
    [self setTheLab:CGRectMake(100, setHeight, 40, 20) textColor:UIColorWithRGB(90,92,92,1) labText:@"期号: " setFont:14 setCen:NO];
    
    _issueLab = [[UILabel alloc] initWithFrame:CGRectMake(140, setHeight, 80, 20)];
    
    _issueLab.backgroundColor = [UIColor clearColor];
    _issueLab.font = [UIFont systemFontOfSize:14];
    _issueLab.textAlignment = NSTextAlignmentLeft;
    _issueLab.textColor = UIColorWithRGB(90,92,92,1);
    [self addSubview:_issueLab];
    
    setHeight = setHeight +40;
    // 进度条
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(100, setHeight, iPhoneWidth/2 -15 , 80)];
    _progressView.backgroundColor = [UIColor clearColor];
    //更改进度条高度
    _progressView.transform = CGAffineTransformMakeScale(1.0f,3.5f);
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = 5;
    _progressView.trackTintColor = UIColorWithRGB(238, 238, 239, 1);
    [_progressView setTintColor:UIColorWithRGB(253, 188, 59, 1)];
    [self addSubview:_progressView];
    [_progressView setProgress:0.3];
    
    setHeight = setHeight +30;
    // 总需
    
    _needLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setHeight, 75, 20)];
    
    _needLab.backgroundColor = [UIColor clearColor];
    _needLab.font = [UIFont systemFontOfSize:14];
    _needLab.textAlignment = NSTextAlignmentLeft;
    _needLab.text = @"688";
    _needLab.textColor = UIColorWithRGB(90,92,92,1);
    [self addSubview:_needLab];
    
    
    //剩余
    [self setTheLab:CGRectMake(iPhoneWidth - 120, setHeight, 40, 20) textColor:UIColorWithRGB(90,92,92,1) labText:@"剩余" setFont:14 setCen:YES];
    //剩余
    _residueLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 80, setHeight, 75, 20)];
    _residueLab.backgroundColor = [UIColor clearColor];
    _residueLab.font = [UIFont systemFontOfSize:14];
    _residueLab.textAlignment = NSTextAlignmentLeft;
    _residueLab.textColor = UIColorWithRGB(0, 118, 235, 1);
    [self addSubview:_residueLab];
    
    setHeight = setHeight +30;
    //本期参与
    [self setTheLab:CGRectMake(100, setHeight, 90, 20) textColor:UIColorWithRGB(90,92,92,1) labText:@"本期参与 : " setFont:14 setCen:NO];
    
    _joinLab = [[MMLabel alloc] initWithFrame:CGRectMake(170, setHeight, 75, 20)];
    
    _joinLab.backgroundColor = [UIColor clearColor];
    _joinLab.font = [UIFont systemFontOfSize:14];
    _joinLab.textAlignment = NSTextAlignmentLeft;
    _joinLab.textColor = UIColorWithRGB(90,92,92,1);
    _joinLab.keyWordColor = UIColorWithRGB(235, 103, 0, 1);
    [self addSubview: _joinLab];
    
    
    //查看详情
    _detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth  - 80, setHeight-8, 80, 35)];
    _detailBtn.backgroundColor = [UIColor clearColor];
    [self addSubview: _detailBtn];
    [ _detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [ _detailBtn setTitleColor:UIColorWithRGB(5, 117, 237, 1) forState:UIControlStateNormal];
    [_detailBtn addTarget:self action:@selector(lookDetailPressed:) forControlEvents:UIControlEventTouchUpInside];
    _detailBtn.titleLabel.font = defaultFontSize(15);
    
    
    
    setHeight = setHeight +30;

    
    _showLab = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight, iPhoneWidth - 80, 20)];
    
    _showLab.backgroundColor = [UIColor clearColor];
    _showLab.font = [UIFont systemFontOfSize:17];
    _showLab.textAlignment = NSTextAlignmentRight;
    _showLab.textColor = UIColorWithRGB(235, 103, 0, 1);
    [self addSubview: _showLab];
    _showLab.text = @"正在揭晓中,请耐心等待";
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

//TODO:传入数据
- (void)setNode:(SnatchRecordListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.title;
//    self.needLab.text = _node.price;
    self.issueLab.text = _node.code;
    self.joinLab.text = [NSString stringWithFormat:@"%@人次",_node.progress];
    self.joinLab.keyWord = [NSString stringWithFormat:@"%@",_node.progress];
    _detailBtn.tag = [_node.wid integerValue];

    
    self.progressView.progress = [_node.progress integerValue] % [_node.price integerValue];
    self.needLab.text = [NSString stringWithFormat:@"总需%@",_node.price];
    
    self.residueLab.text = [NSString stringWithFormat:@"%ld",[_node.price integerValue] - [_node.progress integerValue]];
    
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//TODO:查看详情
- (void)lookDetailPressed:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(lookDetail:)]) {
        [_delegate lookDetail:sender];
    }
}

@end
