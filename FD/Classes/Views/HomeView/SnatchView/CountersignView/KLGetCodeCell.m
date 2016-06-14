//
//  KLGetCodeCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "KLGetCodeCell.h"
#import "FontDefine.h"

@implementation KLGetCodeCell

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
    self.backgroundColor = [UIColor clearColor];
    
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10  , 40, 40 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    
    // 电话
    _phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, iPhoneWidth - 120, 30)];
    _phoneLab.backgroundColor = [UIColor clearColor];
    _phoneLab.font = [UIFont systemFontOfSize:15];
    _phoneLab.textAlignment = NSTextAlignmentLeft;
    _phoneLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_phoneLab];
    
    // 个数
    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 170, 0,150 , 30)];
    _numLab.backgroundColor = [UIColor clearColor];
    _numLab.font = [UIFont systemFontOfSize:13];
    _numLab.textAlignment = NSTextAlignmentRight;
    _numLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_numLab];
    
    
    // 时间
    _timeLab= [[UILabel alloc] initWithFrame:CGRectMake(60, 30, iPhoneWidth - 120, 30)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.font = [UIFont systemFontOfSize:13];
    _timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab.textColor = UIColorWithRGB(251, 68, 0, 1);
    [self addSubview:_timeLab];
    
    
}

//TODO:获取数据
- (void)setNode:(KLGetCodeNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.phoneLab.text = _node.Cname;
    self.numLab.text = _node.Cname;
    self.timeLab.text = _node.Cname;


    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
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


@end


