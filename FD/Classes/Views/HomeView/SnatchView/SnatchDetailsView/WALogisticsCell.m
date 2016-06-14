//
//  WALogisticsCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WALogisticsCell.h"
#import "FontDefine.h"

@implementation WALogisticsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self creat];
    }
    return self;
}


//TODO:初始化数据
- (void)creat{
    float setHeight = 0;
       
    setHeight = 45;
    
    // 图标
    UIImageView *zlineImgView = [[UIImageView alloc] init];
    zlineImgView.frame = CGRectMake(10, setHeight , iPhoneWidth-20, 1);
    
    zlineImgView.backgroundColor = UIColorWithRGB(217, 217, 217, 1);
    [self addSubview:zlineImgView];
    
    [self setTheLab:CGRectMake(15, 10, iPhoneWidth - 30, 25) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"物流信息:" setFont:16 setCen:NO];
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, setHeight+5 , iPhoneWidth - 40, 30)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _titleLab.text = @"我是一个菠菜,菠菜,菠菜,菠菜,菠菜;我是一个菠萝,菠萝,菠萝,菠萝一二傻123啊，我是一个菠菜,菠菜,菠菜,菠菜,菠菜;我是一个菠萝,菠萝,菠萝,菠萝一二傻123啊";
    //    _titleLab.numberOfLines = 0;
    
    _titleLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_titleLab];
    
    setHeight = setHeight + 37;
    
    // 物流公司
   [self setTheLab:CGRectMake(30, setHeight, 100, 25) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"物流公司:" setFont:16 setCen:NO];
    
    _companyLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setHeight, iPhoneWidth - 120, 25)];
    _companyLab.backgroundColor = [UIColor clearColor];
    _companyLab.font = [UIFont systemFontOfSize:16];
    _companyLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _companyLab.text = @"申通";
    _companyLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_companyLab];
    
    setHeight = setHeight + 35;
    
    // 运单号
    [self setTheLab:CGRectMake(30, setHeight, 80, 25) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"运单号:" setFont:16 setCen:NO];
    
    //
    _codeLab = [[UILabel alloc] initWithFrame:CGRectMake(90, setHeight, iPhoneWidth - 100, 25)];
    _codeLab.backgroundColor = [UIColor clearColor];
    _codeLab.font = [UIFont systemFontOfSize:16];
    _codeLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _codeLab.text = @"398767577001";
    _codeLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_codeLab];
    
    
    
    
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
- (void)setNode:(WinningAffirmNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.title;
   self.companyLab.text = _node.express_type;
   self.codeLab.text = _node.express_code;
    
}

- (void)awakeFromNib
{
    // Initialization code
}


@end


