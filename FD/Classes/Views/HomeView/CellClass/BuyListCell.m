//
//  BuyListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "BuyListCell.h"
#import "FontDefine.h"

@implementation BuyListCell

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
    lineImgView.frame = CGRectMake(0, 0 , iPhoneWidth, 10);

    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [self addSubview:lineImgView];
    self.backgroundColor = [UIColor clearColor];
    
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15 +110 / 6 , 110, 110 / 3 * 2)];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
 
    
    // 标题
    _titleLab = [[UILabel alloc] init];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;

    _titleLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_titleLab];
    
    
    // 任务奖励
    _priceLab= [[UILabel alloc] init];

    _priceLab.backgroundColor = [UIColor clearColor];
    _priceLab.font = [UIFont systemFontOfSize:15];
    _priceLab.textAlignment = NSTextAlignmentRight;
    _priceLab.numberOfLines = 0;
    _priceLab.textColor = UIColorWithRGB(251, 68, 0, 1);
    [self addSubview:_priceLab];
    

    // 任务奖励
    _pricesLab= [[UILabel alloc] init];
    _pricesLab.backgroundColor = [UIColor clearColor];
    _pricesLab.font = [UIFont systemFontOfSize:15];
    _pricesLab.textAlignment = NSTextAlignmentLeft;
    _pricesLab.text = @"任务收益";
    _pricesLab.numberOfLines = 0;
    _pricesLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_pricesLab];


    
    // 保证金
    [self setTheLab:CGRectMake(130, 78, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"保证金" setFont:13 setCen:NO];

    // 任务周期
    [self setTheLab:CGRectMake(iPhoneWidth - 80, 78, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"任务周期" setFont:13 setCen:YES];


    _marginLab = [[UILabel alloc] init];
    _marginLab.backgroundColor = [UIColor clearColor];
    _marginLab.font = [UIFont systemFontOfSize:14];
    _marginLab.textAlignment = NSTextAlignmentLeft;

    _marginLab.numberOfLines = 0;
    _marginLab.textColor = UIColorWithRGB(53, 53, 53, 1);
    [self addSubview:_marginLab];

    _cycleLab = [[UILabel alloc] init];
    _cycleLab.backgroundColor = [UIColor clearColor];
    _cycleLab.font = [UIFont systemFontOfSize:14];
    _cycleLab.textAlignment = NSTextAlignmentCenter;

    _cycleLab.numberOfLines = 0;
    _cycleLab.textColor = UIColorWithRGB(53, 53, 53, 1);
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
- (void)setNode:(BuylistNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.Btitle;
    self.priceLab.text = _node.Bmargin;
    self.marginLab.text = _node.Bmoney;
    self.cycleLab.text = [NSString stringWithFormat:@"%@天",_node.Bcycle];

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
    _headImgView.frame = CGRectMake(10, 10 +110 / 6 , 110, 110 / 3 * 2);
    _titleLab.frame = CGRectMake(130, 10  , iPhoneWidth - 140, 40);
//    _priceLab.frame = CGRectMake(130, 55, 90, 30);
//    _pricesLab.frame = CGRectMake(_priceLab.frame.origin.x + _priceLab.frame.size.width , 55, 80, 30);
    _marginLab.frame = CGRectMake(130, 92, 80, 30);
    _cycleLab.frame = CGRectMake(iPhoneWidth - 80, 92, 80, 30);
    _priceLab.frame = CGRectMake(130, 43, setWidth, 30);
    _pricesLab.frame = CGRectMake(_priceLab.frame.origin.x + setWidth + 15, 43, 80, 30);
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.Bicon] placeholderImage:[UIImage imageNamed:@"list_noImg.png"]];
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


