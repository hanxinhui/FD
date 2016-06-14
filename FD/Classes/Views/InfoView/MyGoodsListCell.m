//
//  MyGoodsListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyGoodsListCell.h"
#import "FontDefine.h"

@implementation MyGoodsListCell

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
    lineImgView.frame = CGRectMake(0, 0 , iPhoneWidth, 5);
    
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [self addSubview:lineImgView];
    self.backgroundColor = [UIColor clearColor];
    
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15  , 90, 90 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, iPhoneWidth - 120, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont boldSystemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;

    //    _titleLab.numberOfLines = 0;
    
    _titleLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_titleLab];
    
    // 详情
    _desLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, iPhoneWidth - 120, 40)];
    _desLab.backgroundColor = [UIColor clearColor];
    _desLab.font = [UIFont systemFontOfSize:13];
    _desLab.textAlignment = NSTextAlignmentLeft;

    _desLab.numberOfLines = 0;
    _desLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_desLab];
    
    // 兑换价格
    [self setTheLab:CGRectMake(110, 65, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"兑换价格" setFont:14 setCen:NO];
    // 价格
    _priceLab= [[UILabel alloc] initWithFrame:CGRectMake(110, 85, iPhoneWidth - 220, 20)];
    _priceLab.backgroundColor = [UIColor clearColor];
    _priceLab.font = [UIFont systemFontOfSize:13];
    _priceLab.textAlignment = NSTextAlignmentLeft;

    _priceLab.numberOfLines = 0;
    _priceLab.textColor = UIColorWithRGB(251, 68, 0, 1);
    [self addSubview:_priceLab];
    

    // 库存
    [self setTheLab:CGRectMake(iPhoneWidth - 100, 65, 80, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"兑换时间" setFont:14 setCen:YES];

    // 任务奖励
    _stockLab= [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 200, 85, 180, 20)];
    _stockLab.backgroundColor = [UIColor clearColor];
    _stockLab.font = [UIFont systemFontOfSize:13];
    _stockLab.textAlignment = NSTextAlignmentRight;

    _stockLab.numberOfLines = 0;
    _stockLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_stockLab];
    
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
- (void)setNode:(MyGoodsListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.name;;
    self.desLab.text = _node.status_msg;
    self.priceLab.text = _node.price;
    self.stockLab.text = _node.createtime;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"Public_list_noImg.png"]];
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


