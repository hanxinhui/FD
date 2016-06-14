//
//  WAGoodsCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WAGoodsCell.h"
#import "FontDefine.h"

@implementation WAGoodsCell

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
    [self setTheLineImg:setHeight];
    // 图标
    UIImageView *lineImgView = [[UIImageView alloc] init];
    lineImgView.frame = CGRectMake(0, setHeight , iPhoneWidth, 10);
    
    lineImgView.backgroundColor = UIColorWithRGB(247, 247, 247, 1);
    [self addSubview:lineImgView];
     [self setTheLineImg:setHeight+10];

    [self setTheLab:CGRectMake(15, 10, iPhoneWidth - 30, 45) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"奖品信息" setFont:16 setCen:NO];
   

    setHeight = 55;
    
    // 图标
    UIImageView *zlineImgView = [[UIImageView alloc] init];
    zlineImgView.frame = CGRectMake(10, setHeight , iPhoneWidth-20, 1);
    
    zlineImgView.backgroundColor = UIColorWithRGB(217, 217, 217, 1);
    [self addSubview:zlineImgView];
    self.backgroundColor = [UIColor clearColor];
    
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setHeight + 20  , 90, 90 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(120, setHeight+20 , iPhoneWidth - 120, 50)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _titleLab.text = @"我是一个菠菜,菠菜,菠菜,菠菜,菠菜;我是一个菠萝,菠萝,菠萝,菠萝一二傻123啊，我是一个菠菜,菠菜,菠菜,菠菜,菠菜;我是一个菠萝,菠萝,菠萝,菠萝一二傻123啊";
    _titleLab.numberOfLines = 0;
    _titleLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_titleLab];
    
    setHeight = 130;
    // 期号
    [self setTheLab:CGRectMake(103, setHeight, 50, 25) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"期号:" setFont:14 setCen:YES];
    
    _datanumLab= [[UILabel alloc] initWithFrame:CGRectMake(160, setHeight, iPhoneWidth - 170, 25)];
    _datanumLab.backgroundColor = [UIColor clearColor];
    _datanumLab.font = [UIFont systemFontOfSize:14];
    _datanumLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _datanumLab.text = @"201515151";
    _datanumLab.textColor = UIColorWithRGB(0, 118, 235, 1);
    [self addSubview:_datanumLab];
    
    setHeight = setHeight + 25;
    
    // 总需
    [self setTheLab:CGRectMake(120, setHeight, 50, 25) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"总需:" setFont:14 setCen:NO];
    
    //
    _allPeoLab= [[UILabel alloc] initWithFrame:CGRectMake(160, setHeight, iPhoneWidth - 170, 25)];
    _allPeoLab.backgroundColor = [UIColor clearColor];
    _allPeoLab.font = [UIFont systemFontOfSize:14];
    _allPeoLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _allPeoLab.text = @"35人次";
    _allPeoLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_allPeoLab];
    
    setHeight = setHeight + 25;
    
    // 幸运号码
    [self setTheLab:CGRectMake(120, setHeight, 100, 25) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"幸运号码:" setFont:14 setCen:NO];
    
    //
    _lucknumLab = [[UILabel alloc] initWithFrame:CGRectMake(180, setHeight, iPhoneWidth - 170, 25)];
    _lucknumLab.backgroundColor = [UIColor clearColor];
    _lucknumLab.font = [UIFont systemFontOfSize:14];
    _lucknumLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _lucknumLab.text = @"10000015";
    _lucknumLab.textColor = UIColorWithRGB(253, 130, 74, 1);
    [self addSubview:_lucknumLab];
    
    setHeight = setHeight + 25;
    
    // 本期参与
    [self setTheLab:CGRectMake(120, setHeight, 100, 25) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"本期参与:" setFont:14 setCen:NO];
    
    //
    _inpeoLab= [[MMLabel alloc] initWithFrame:CGRectMake(180, setHeight, iPhoneWidth - 170, 25)];
    _inpeoLab.backgroundColor = [UIColor clearColor];
    _inpeoLab.font = [UIFont systemFontOfSize:14];
    _inpeoLab.textAlignment = NSTextAlignmentLeft;
       _inpeoLab.textColor = UIColorWithRGB(72, 72, 72, 1);
     _inpeoLab.keyWordColor = UIColorWithRGB(253, 130, 74, 1);
    [self addSubview:_inpeoLab];
    
    
    setHeight = setHeight + 25;
    
    // 揭晓时间
    [self setTheLab:CGRectMake(120, setHeight, 100, 25) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"揭晓时间:" setFont:14 setCen:NO];
    
    //
    _timelab= [[UILabel alloc] initWithFrame:CGRectMake(180,setHeight, iPhoneWidth - 170, 25)];
    _timelab.backgroundColor = [UIColor clearColor];
    _timelab.font = [UIFont systemFontOfSize:14];
    _timelab.textAlignment = NSTextAlignmentLeft;
    
    _timelab.textColor = UIColorWithRGB(253, 130, 74, 1);
    [self addSubview:_timelab];
    
    
    setHeight = setHeight + 45;
    
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
    self.datanumLab.text = _node.time;
    self.lucknumLab.text = _node.luck_code;
    self.timelab.text = _node.luck_time;
    
    _allPeoLab.text = [NSString stringWithFormat:@"%@人次",_node.price];
    _inpeoLab.text = [NSString stringWithFormat:@"%@人次",_node.count];
    _inpeoLab.keyWord = [NSString stringWithFormat:@"%@",_node.count];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
}

//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, sizeY - 1, iPhoneWidth, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    
    
    [self addSubview:imgView];
}


- (void)awakeFromNib
{
    // Initialization code
}




@end


