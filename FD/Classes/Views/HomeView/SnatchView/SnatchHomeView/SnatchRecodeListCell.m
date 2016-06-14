//
//  SnatchRecodeListCell.m
//  FD
//
//  Created by leoxu on 15/12/16.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "SnatchRecodeListCell.h"
#import "FontDefine.h"

@implementation SnatchRecodeListCell  


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
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setHeight+10  ,80, 80 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_goodsImgView];
    
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setHeight, iPhoneWidth/2+50, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    //    _titleLab.lineBreakMode = NSLineBreakByWordWrapping;
    
    _titleLab.textColor = UIColorWithRGB(90, 92, 92, 1);
    [self addSubview:_titleLab];
    
    setHeight = setHeight+50;
    
    //期号
    [self setTheLab:CGRectMake(100, setHeight, 40, 20) textColor:UIColorWithRGB(90, 92, 92, 1) labText:@"期号: " setFont:14 setCen:NO];
    
    _issueLab = [[UILabel alloc] initWithFrame:CGRectMake(140, setHeight, 100, 20)];
    
    _issueLab.backgroundColor = [UIColor clearColor];
    _issueLab.font = [UIFont systemFontOfSize:14];
    _issueLab.textAlignment = NSTextAlignmentLeft;

    _issueLab.textColor = UIColorWithRGB(0, 118, 235, 1);
    [self addSubview:_issueLab];
    
    setHeight = setHeight+25;
    
    // 总需
    [self setTheLab:CGRectMake(100, setHeight, 40, 20) textColor:UIColorWithRGB(90, 92, 92, 1) labText:@"总需: " setFont:14 setCen:NO];
    
    _needLab = [[UILabel alloc] initWithFrame:CGRectMake(140, setHeight, 75, 20)];
    
    _needLab.backgroundColor = [UIColor clearColor];
    _needLab.font = [UIFont systemFontOfSize:14];
    _needLab.textAlignment = NSTextAlignmentLeft;

    _needLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_needLab];
    setHeight = setHeight+25;
    
    //本期参与
    [self setTheLab:CGRectMake(100, setHeight, 90, 20) textColor:UIColorWithRGB(90, 92, 92, 1) labText:@"本期参与: " setFont:14 setCen:NO];
    
    _joinLab = [[MMLabel alloc] initWithFrame:CGRectMake(170, setHeight, 75, 20)];
    
    _joinLab.backgroundColor = [UIColor clearColor];
    _joinLab.font = [UIFont systemFontOfSize:14];
    _joinLab.textAlignment = NSTextAlignmentLeft;
    _joinLab.textColor = UIColorWithRGB(73,76, 75, 1);
    _joinLab.keyWordColor = UIColorWithRGB(235, 103, 0, 1);
    
    [self addSubview: _joinLab];
    
    
    //查看详情
    _detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth  - 80, setHeight-7, 80, 35)];
    _detailBtn.backgroundColor = [UIColor clearColor];
    [self addSubview: _detailBtn];
    [ _detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [ _detailBtn setTitleColor:UIColorWithRGB(5, 117, 237, 1) forState:UIControlStateNormal];
    [_detailBtn addTarget:self action:@selector(lookDetailPressed:) forControlEvents:UIControlEventTouchUpInside];
    _detailBtn.titleLabel.font = defaultFontSize(15);
    
    UIImageView  *bgImage= [[ UIImageView alloc]initWithFrame:CGRectMake(100, 135, iPhoneWidth  - 105, 110)];
    bgImage.backgroundColor = UIColorWithRGB(245, 246, 247, 1);
    
    [self addSubview:bgImage];
    
    setHeight = setHeight+35;
    
    //    获得者
    [self setTheLab:CGRectMake(105, setHeight, 90, 20) textColor:UIColorWithRGB(130,132, 132, 1) labText:@"获得者: " setFont:14 setCen:NO];
    
    _awardLab = [[UILabel alloc] initWithFrame:CGRectMake(160, setHeight, 150, 20)];
    
    _awardLab.backgroundColor = [UIColor clearColor];
     _awardLab.font = [UIFont systemFontOfSize:14];
     _awardLab.textAlignment = NSTextAlignmentLeft;
     _awardLab.textColor = UIColorWithRGB(0, 118, 235, 1);
     [self addSubview:_awardLab];
        
    //本期参与
    [self setTheLab:CGRectMake(105, 170, 90, 20) textColor:UIColorWithRGB(130,132, 132, 1) labText:@"本期参与: " setFont:14 setCen:NO];
    _allJoinLab = [[MMLabel alloc] initWithFrame:CGRectMake(170, 170, 75, 20)];
    
    _allJoinLab.backgroundColor = [UIColor clearColor];
    _allJoinLab.font = [UIFont systemFontOfSize:14];
    _allJoinLab.textAlignment = NSTextAlignmentLeft;
    _allJoinLab.textColor = UIColorWithRGB(73,76, 75, 1);
    _allJoinLab.keyWordColor = UIColorWithRGB(235, 103, 0, 1);
    [self addSubview:  _allJoinLab];
    

    
    //  幸运号码
    [self setTheLab:CGRectMake(105, 195, 90, 20) textColor:UIColorWithRGB(130,132, 132, 1) labText:@"幸运号码: " setFont:14 setCen:NO];
    
    
    _luckyLab = [[UILabel alloc] initWithFrame:CGRectMake(170, 195, 75, 20)];
    
    _luckyLab.backgroundColor = [UIColor clearColor];
    _luckyLab.font = [UIFont systemFontOfSize:14];
    _luckyLab.textAlignment = NSTextAlignmentLeft;
    _luckyLab.textColor = UIColorWithRGB(235, 103, 0, 1);
    [self addSubview:  _luckyLab];
    
    //揭晓时间
    [self setTheLab:CGRectMake(105, 220, 90, 20) textColor:UIColorWithRGB(130,132, 132, 1) labText:@"揭晓时间: " setFont:14 setCen:NO];
    
    
    _dataLab = [[UILabel alloc] initWithFrame:CGRectMake(170, 220, 180, 20)];
    
    _dataLab.backgroundColor = [UIColor clearColor];
    _dataLab.font = [UIFont systemFontOfSize:14];
    _dataLab.textAlignment = NSTextAlignmentLeft;
    _dataLab.textColor = UIColorWithRGB(73, 76,75, 1);
    [self addSubview: _dataLab];
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
- (void)setNode:(SnatchRecordListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    
    self.titleLab.text = _node.title;
    self.issueLab.text = _node.code;
    self.joinLab.text = [NSString stringWithFormat:@"%@ 人次",_node.count];
    self.joinLab.keyWord = [NSString stringWithFormat:@"%@",_node.count];
    
   
    self.awardLab.text = _node.nickname;
    
    self.allJoinLab.text = [NSString stringWithFormat:@"%@ 人次",_node.wincount];
    self.allJoinLab.keyWord = [NSString stringWithFormat:@"%@",_node.wincount];
    
    self.luckyLab.text = _node.luck_code;
    self.dataLab.text = _node.luck_time;
    _detailBtn.tag = [_node.wid integerValue];

    _needLab.text = [NSString stringWithFormat:@"%@人次",_node.price];
    
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
