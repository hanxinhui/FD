//
//  MyTaskAnyCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyTaskAnyCell.h"
#import "FontDefine.h"

@implementation MyTaskAnyCell

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
    UIImageView *lineImgView = [[UIImageView alloc] init];
    lineImgView.frame = CGRectMake(0, 0, iPhoneWidth, 10);
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [self addSubview:lineImgView];
    self.backgroundColor = [UIColor clearColor];
    
    // 图标
    float  setHigh = 10.0;
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10 +110 / 6 , 110, 110 / 3 * 2)];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(130, 10  , iPhoneWidth - 140, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;


    _titleLab.textColor = UIColorWithRGB(69, 69, 69, 1);
    [self addSubview:_titleLab];
    
    setHigh = setHigh + 32;
    
    // 任务奖励
    _priceLab= [[UILabel alloc] initWithFrame:CGRectMake(130, setHigh, 90, 30)];
    _priceLab.backgroundColor = [UIColor clearColor];
    _priceLab.font = [UIFont systemFontOfSize:17];
    _priceLab.textAlignment = NSTextAlignmentRight;

    _priceLab.numberOfLines = 0;
    _priceLab.textColor = UIColorWithRGB(251, 68, 0, 1);
    [self addSubview:_priceLab];
    
    
    // 任务奖励
    _pricesLab= [[UILabel alloc] initWithFrame:CGRectMake(_priceLab.frame.origin.x + _priceLab.frame.size.width , setHigh, 80, 30)];
    _pricesLab.backgroundColor = [UIColor clearColor];
    _pricesLab.font = [UIFont systemFontOfSize:14];
    _pricesLab.textAlignment = NSTextAlignmentLeft;
    _pricesLab.text = @"任务奖励";
    _pricesLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_pricesLab];


    setHigh = setHigh + 30;
    
    // 保证金
    [self setTheLab:CGRectMake(130, 78, 80, 20) textColor:UIColorWithRGB(134, 134, 134, 1) labText:@"保证金" setFont:15 setCen:NO];

    // 任务周期
    [self setTheLab:CGRectMake(iPhoneWidth - 120, 78, 80, 20) textColor:UIColorWithRGB(134, 134, 134, 1) labText:@"剩余" setFont:15 setCen:NO];

    setHigh = setHigh + 20;

    _marginLab = [[UILabel alloc] initWithFrame:CGRectMake(130, 92, 80, 30)];
    _marginLab.backgroundColor = [UIColor clearColor];
    _marginLab.font = [UIFont systemFontOfSize:15];
    _marginLab.textAlignment = NSTextAlignmentLeft;

    _marginLab.numberOfLines = 0;
    _marginLab.textColor = [UIColor blackColor];
    [self addSubview:_marginLab];
    
    _cycleLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 120, 92, 80, 30)];
    _cycleLab.backgroundColor = [UIColor clearColor];
    _cycleLab.font = [UIFont systemFontOfSize:15];
    _cycleLab.textAlignment = NSTextAlignmentCenter;

    _cycleLab.numberOfLines = 0;
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
- (void)setNode:(MyTaskAnyCellNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.name;
    self.priceLab.text = _node.profit;
    self.marginLab.text = _node.bond;
    self.cycleLab.text = _node.surplus;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = _priceLab.lineBreakMode;
    paragraphStyle.alignment = _priceLab.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : _priceLab.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [_priceLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, _priceLab.frame.size.height)
                                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                   attributes:attributes
                                                      context:nil].size;
    
    float setWidth = contentSize.width;
    if (setWidth > iPhoneWidth - 220 ) {
        setWidth = iPhoneWidth - 220;
    }
    _priceLab.frame = CGRectMake(130, 43, setWidth, 30);
    _pricesLab.frame = CGRectMake(_priceLab.frame.origin.x + setWidth + 5, 43, 80, 30);
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:_node.thumb] placeholderImage:[UIImage imageNamed:@"list_noImg.png"]];
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


