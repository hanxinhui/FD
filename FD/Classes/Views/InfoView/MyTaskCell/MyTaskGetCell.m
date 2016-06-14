//
//  MyTaskGetCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyTaskGetCell.h"
#import "FontDefine.h"

@implementation MyTaskGetCell

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
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, setHigh , 110, 110)];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(125, setHigh , iPhoneWidth - 135, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = defaultFontSize(14);
    _titleLab.textAlignment = NSTextAlignmentLeft;

    _titleLab.numberOfLines = 0;
    _titleLab.textColor = UIColorWithRGB(83, 83, 83, 1);
    [self addSubview:_titleLab];
    
    setHigh = setHigh + 40;
    
    // 发货状态
    _sendStateBtn = [[UIButton alloc] initWithFrame:CGRectMake(125, setHigh, 80, 30)];
    _sendStateBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_sendStateBtn];
    _sendStateBtn.userInteractionEnabled = NO;
    [_sendStateBtn.layer setMasksToBounds:NO];
    [_sendStateBtn.layer setCornerRadius:10.0];
    [_sendStateBtn.layer setBorderWidth:1.0];
    [_sendStateBtn.layer setBorderColor:[UIColorWithRGB(194, 219, 188 , 1) CGColor]];
    
    // 运送单号
    _numLab= [[UILabel alloc] initWithFrame:CGRectMake(210, setHigh, iPhoneWidth - 220, 30)];
    _numLab.backgroundColor = [UIColor clearColor];
    _numLab.font = defaultFontSize(15);
    _numLab.textAlignment = NSTextAlignmentLeft;

    _numLab.numberOfLines = 0;
    _numLab.textColor = UIColorWithRGB(255, 168, 0, 1);
    [self addSubview:_numLab];
    _numLab.hidden = YES;

    setHigh = setHigh + 30;
    
    // 保证金
    [self setTheLab:CGRectMake(125, setHigh, 80, 20) textColor:UIColorWithRGB(134, 134, 134, 1) labText:@"保证金" setFont:13 setCen:NO];

    // 任务周期
    [self setTheLab:CGRectMake(iPhoneWidth - 120, setHigh, 80, 20) textColor:UIColorWithRGB(134, 134, 134, 1) labText:@"剩余" setFont:13 setCen:NO];

    setHigh = setHigh + 20;

    _marginLab = [[UILabel alloc] initWithFrame:CGRectMake(125, setHigh, iPhoneWidth - 220, 30)];
    _marginLab.backgroundColor = [UIColor clearColor];
    _marginLab.font = defaultFontSize(13);
    _marginLab.textAlignment = NSTextAlignmentCenter;

    _marginLab.numberOfLines = 0;
    _marginLab.textColor = [UIColor blackColor];
    [self addSubview:_marginLab];
    
    _cycleLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 100, setHigh, 80, 30)];
    _cycleLab.backgroundColor = [UIColor clearColor];
    _cycleLab.font = defaultFontSize(13);
    _cycleLab.textAlignment = NSTextAlignmentLeft;

    _cycleLab.textColor = [UIColor blackColor];
    [self addSubview:_cycleLab];
    
    
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
- (void)setNode:(MyTaskGetCellNode *)node{
    if (_node == node) return;
    
    _node = node;

    self.titleLab.text = _node.name;
    NSInteger status = [_node.express_status integerValue];
    switch (status) {
            //未发货
        case 0:
        {
            [_sendStateBtn setTitle:@"已发货" forState:UIControlStateNormal];
            [_sendStateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
            break;
            //已发货
        case 1:
        {
            [_sendStateBtn setTitle:@"已发货" forState:UIControlStateNormal];
            [_sendStateBtn setTitleColor:UIColorWithRGB(251, 89, 0, 1) forState:UIControlStateNormal];
            _numLab.text = [NSString stringWithFormat:@"%@:%@",_node.express_company,_node.express_code];
            _numLab.hidden = NO;
        }
            break;
            //已签收
        case 3:
        {
            [_sendStateBtn setTitle:@"已签收" forState:UIControlStateNormal];
            [_sendStateBtn setTitleColor:UIColorWithRGB(194, 219, 188 , 1) forState:UIControlStateNormal];
            [_sendStateBtn.layer setMasksToBounds:YES];

        }
            break;
        default:
            break;
    }
    self.numLab.text = _node.express_code;
    self.marginLab.text = _node.bond;
    self.cycleLab.text = _node.surplus;

    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:_node.thumb] placeholderImage:[UIImage imageNamed:@"Public_list_noImg.png"]];
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


