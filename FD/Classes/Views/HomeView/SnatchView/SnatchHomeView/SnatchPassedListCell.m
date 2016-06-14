//
//  SnatchPassedListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SnatchPassedListCell.h"
#import "FontDefine.h"

@implementation SnatchPassedListCell

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
    float seth = 0;
    // 图标
    UIImageView *lineImgView = [[UIImageView alloc] init];
    lineImgView.frame = CGRectMake(0, seth , iPhoneWidth, 10);
    
    lineImgView.backgroundColor = UIColorWithRGB(240, 239, 236, 1);
    [self addSubview:lineImgView];
    self.backgroundColor = [UIColor clearColor];
    
    // 下图标
    UIImageView *lineImg = [[UIImageView alloc] init];
    lineImg.frame = CGRectMake(0, seth+10 , iPhoneWidth, 1);
    lineImg.backgroundColor = UIColorWithRGB(206, 207, 211, 1);
    [self addSubview:lineImg];
    self.backgroundColor = [UIColor clearColor];
    
    // 期数
    _periodsLab = [[UILabel alloc] initWithFrame:CGRectMake(10, seth+20, iPhoneWidth - 30, 30)];
    _periodsLab.backgroundColor = [UIColor clearColor];
    _periodsLab.font = [UIFont systemFontOfSize:13];
    _periodsLab.textAlignment = NSTextAlignmentLeft;
    _periodsLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_periodsLab];
    
    // 揭晓时间
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth / 2-40, seth+20, iPhoneWidth / 2+20 , 30)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.font = [UIFont systemFontOfSize:13];
    _timeLab.textAlignment = NSTextAlignmentLeft;

    _timeLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_timeLab];
    
    
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.frame = CGRectMake(iPhoneWidth-15, seth+28, 10 , 15);
    rightImg.image = [UIImage imageNamed:@"My_right.png"];
    self.backgroundColor = [UIColor clearColor];

    [self addSubview:rightImg];
    
    seth = seth + 50;
    // 图标
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, seth-8, iPhoneWidth-15, 20);
    label.text = @"........................................................................................";
    label.textColor = UIColorWithRGB(147, 148, 149, 1);
    [self addSubview:label];
    
    seth = seth + 20;

    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, seth  , 45, 45 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    
    // 获奖者
    [self setTheLab:CGRectMake(75, seth, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"获奖者:" setFont:15 setCen:NO];

    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(135, seth, iPhoneWidth - 160, 20)];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textAlignment = NSTextAlignmentLeft;
    _nameLab.textColor = UIColorWithRGB(1, 113, 218, 1);
    [self addSubview:_nameLab];
    
    seth = seth + 23;

    // 用户ID
    [self setTheLab:CGRectMake(75, seth, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"用户ID:" setFont:15 setCen:NO];
    
    _idLab = [[UILabel alloc] initWithFrame:CGRectMake(135, seth, iPhoneWidth - 160, 20)];
    _idLab.backgroundColor = [UIColor clearColor];
    _idLab.font = [UIFont systemFontOfSize:15];
    _idLab.textAlignment = NSTextAlignmentLeft;

    _idLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_idLab];
    
    seth = seth + 23;
    
    
    // 幸运号码
    [self setTheLab:CGRectMake(75, seth, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"幸运号码:" setFont:15 setCen:NO];
    
    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(145, seth, iPhoneWidth - 160, 20)];
    _numLab.backgroundColor = [UIColor clearColor];
    _numLab.font = [UIFont systemFontOfSize:15];
    _numLab.textAlignment = NSTextAlignmentLeft;
    _numLab.textColor = UIColorWithRGB(231, 90, 0, 1);
    [self addSubview:_numLab];
    
    seth = seth + 23;
    
    // 本期参与
    [self setTheLab:CGRectMake(75, seth, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"本期参与:" setFont:15 setCen:NO];
    
    _countLab = [[MMLabel alloc] initWithFrame:CGRectMake(145, seth, iPhoneWidth - 160, 20)];
    _countLab.backgroundColor = [UIColor clearColor];
    _countLab.font = [UIFont systemFontOfSize:15];
    _countLab.textAlignment = NSTextAlignmentLeft;
    _countLab.textColor = UIColorWithRGB(75, 75, 75, 1);
     _countLab.keyWordColor = UIColorWithRGB(231, 90, 0, 1);
    [self addSubview:_countLab];
    
    
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
- (void)setNode:(PassedSnatchNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    _periodsLab.text = [NSString stringWithFormat:@"第%@期",_node.code ];
    _timeLab.text = [NSString stringWithFormat:@"揭晓时间：%@",_node.luck_time ];

    _nameLab.text = _node.nickname;
    _idLab.text = [NSString stringWithFormat:@"%@(唯一不变标识)",_node.uid ];
    _numLab.text = _node.luck_code;
    _countLab.text = [NSString stringWithFormat:@"%@人次",_node.winnerCount ];
     _countLab.keyWord = [NSString stringWithFormat:@"%@",_node.winnerCount ];



    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.avatar] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];
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


