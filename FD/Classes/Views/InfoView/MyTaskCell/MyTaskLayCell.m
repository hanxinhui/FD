//
//  MyTaskLayCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyTaskLayCell.h"
#import "FontDefine.h"

@implementation MyTaskLayCell

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
    // 图标
    float  setHigh = 5.0;
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, setHigh , 110, 110)];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(110, setHigh + 10, iPhoneWidth - 125, 45)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = defaultFontSize(14);
    _titleLab.textAlignment = NSTextAlignmentLeft;

    _titleLab.numberOfLines = 0;

    _titleLab.textColor = UIColorWithRGB(83, 83, 83, 1);
    [self addSubview:_titleLab];
    
    setHigh = setHigh + 60;
    
    // 保证金
    [self setTheLab:CGRectMake(120, setHigh, 80, 20) textColor:[UIColor lightGrayColor] labText:@"保证金" setFont:13 setCen:NO];

    setHigh = setHigh + 20;

    _marginLab = [[UILabel alloc] initWithFrame:CGRectMake(120, setHigh, 100, 30)];
    _marginLab.backgroundColor = [UIColor clearColor];
    _marginLab.font = defaultFontSize(13);
    _marginLab.textAlignment = NSTextAlignmentLeft;

    _marginLab.numberOfLines = 0;
    _marginLab.textColor = UIColorWithRGB(255, 168, 0, 1);
    [self addSubview:_marginLab];
    
    //开奖状态
    _stateBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 90, setHigh, 80, 30)];
    _stateBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_stateBtn];
    _stateBtn.userInteractionEnabled = NO;
    [_stateBtn setTitle:@"等待开奖" forState:UIControlStateNormal];
    [_stateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [_stateBtn.layer setMasksToBounds:YES];
    [_stateBtn.layer setCornerRadius:10.0];
    [_stateBtn.layer setBorderWidth:1.0];
    [_stateBtn.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    
    [_stateBtn setTitle:@"已开奖" forState:UIControlStateSelected];
    [_stateBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    
}

//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setCen:(BOOL )cen{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (cen) {
        lab.textAlignment = NSTextAlignmentCenter;
        
    }else{
        lab.textAlignment = NSTextAlignmentLeft;
        
    }
    lab.font = [UIFont systemFontOfSize:font];
    [self addSubview:lab];
}

//TODO:获取数据
- (void)setNode:(MyTaskLayCellNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = node.Btitle;
    self.conLab.text = _node.Bcon;
    self.marginLab.text = _node.Bmargin;
//    self.cycleLab.text = _node.Bcycle;

    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.Bicon] placeholderImage:[UIImage imageNamed:@"Public_list_noImg.png"]];
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


