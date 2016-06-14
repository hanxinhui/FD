//
//  PayResultCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "PayResultCell.h"
#import "FontDefine.h"

@implementation PayResultCell

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
    
    // 背景图
    _bgImgView = [[UIImageView alloc] init];
    _bgImgView.frame = CGRectMake(20, 0 , iPhoneWidth - 40, 90);
    //    _bgImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    _bgImgView.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    [self addSubview:_bgImgView];
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, iPhoneWidth - 120, 30)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _titleLab.text = @"Apple iPhone6s 16G 颜色随机";
    _titleLab.textColor = UIColorWithRGB(23, 139, 235, 1);
    [_bgImgView addSubview:_titleLab];
    
    // 人次
    _peoLab = [[MMLabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 135, 5, 45, 30)];
    _peoLab.backgroundColor = [UIColor clearColor];
    _peoLab.font = [UIFont systemFontOfSize:13];
    _peoLab.textAlignment = NSTextAlignmentRight;
    
    _peoLab.numberOfLines = 0;
    _peoLab.textColor = UIColorWithRGB(155, 155, 155, 1);
//    _peoLab.keyWordColor = UIColorWithRGB(237, 102, 26, 1);
    [_bgImgView addSubview:_peoLab];
    
//    [self setTheLab:CGRectMake(iPhoneWidth - 60, 5, 30, 30) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"人次" setFont:14 setCen:NO];
    
    // 商品期号
    [self setTheLab:CGRectMake(30, 35, 80, 25) textColor:UIColorWithRGB(82, 85, 85, 1) labText:@"商品期号:" setFont:14 setCen:NO];
    
    _dateLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, iPhoneWidth - 150, 25)];
    _dateLab.backgroundColor = [UIColor clearColor];
    _dateLab.font = [UIFont systemFontOfSize:13];
    _dateLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _dateLab.text = @"212020906";
    _dateLab.textColor = UIColorWithRGB(82, 85, 85, 1);
    
    [self addSubview:_dateLab];
    
    
    // 夺宝号码
    [self setTheLab:CGRectMake(10, 60, 80, 25) textColor:UIColorWithRGB(82, 85, 85, 1) labText:@"夺宝号码:" setFont:14 setCen:YES];
    
    //
    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, iPhoneWidth - 150, 25)];
    _numLab.backgroundColor = [UIColor clearColor];
    _numLab.font = [UIFont systemFontOfSize:13];
    _numLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _numLab.text = @"任务奖励";
    _numLab.numberOfLines = 0;
    _numLab.textColor = UIColorWithRGB(82, 85, 85, 1);
    [self addSubview:_numLab];
    
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
- (void)setSnode:(SnatchPayNode *)snode{
    if (_snode == snode) return;
    
    _snode = snode;
    
    self.titleLab.text = _snode.title;
    self.dateLab.text = _snode.datacode;
    self.peoLab.text = [NSString stringWithFormat:@"%@人次",_snode.count];
//    self.peoLab.keyWord = [NSString stringWithFormat:@"%@",_snode.count];
    self.numLab.text = _snode.wincode;
    //    self.peoLab.keyWord = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"renci"]];
    //    self.peoLab.keyWordColor = UIColorWithRGB(237, 102, 26, 1);
    
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


