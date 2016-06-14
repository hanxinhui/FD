//
//  PropertyListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "PropertyListCell.h"
#import "FontDefine.h"

@implementation PropertyListCell

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
    float  setHigh = 0.0;

    self.backgroundColor = [UIColor whiteColor];
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, setHigh , 120, 45)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = defaultFontSize(17);
    _titleLab.textAlignment = NSTextAlignmentLeft;

    _titleLab.textColor = [UIColor blackColor];
    [self addSubview:_titleLab];
    
    // 时间
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 200, 35)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.font = [UIFont systemFontOfSize:13];
    _timeLab.textAlignment = NSTextAlignmentLeft;

    _timeLab.textColor = [UIColor lightGrayColor];
    [self addSubview:_timeLab];
    // 任务奖励
    _priceLab= [[UILabel alloc] initWithFrame:CGRectMake(150, 0, iPhoneWidth - 160, 70)];
    _priceLab.backgroundColor = [UIColor clearColor];
    _priceLab.font = defaultFontSize(17);
    _priceLab.textAlignment = NSTextAlignmentRight;

    _priceLab.textColor = UIColorWithRGB(255, 168, 0, 1);
    [self addSubview:_priceLab];
    

    
    

 
    

    
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
- (void)setNode:(PropertyListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.pdesc;
    self.timeLab.text = _node.ptime;
    self.priceLab.text = _node.pmoney;
    
    if ([_node.pmoney hasPrefix:@"-"]) {
        self.priceLab.textColor = UIColorWithRGB(70, 154, 19, 0.8);
        
    }else{
        self.priceLab.textColor = UIColorWithRGB(203, 15, 27, 0.8);
        
    }

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


