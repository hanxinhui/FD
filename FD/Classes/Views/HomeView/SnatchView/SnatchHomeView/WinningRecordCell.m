//
//  WinningRecordCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WinningRecordCell.h"
#import "FontDefine.h"

@implementation WinningRecordCell

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
    float setHeight = 0;
    // 图标
    UIImageView *lineImgView = [[UIImageView alloc] init];
    lineImgView.frame = CGRectMake(0, 0 , iPhoneWidth, 1);
    
    lineImgView.backgroundColor = UIColorWithRGB(228, 228, 228, 1);
    [self addSubview:lineImgView];
    self.backgroundColor = [UIColor whiteColor];
    
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10  , 90, 90 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, iPhoneWidth - 120, 50)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _titleLab.text = @"我是一个菠菜,菠菜,菠菜,菠菜,菠菜;我是一个菠萝,菠萝,菠萝,菠萝一二傻123啊，我是一个菠菜,菠菜,菠菜,菠菜,菠菜;我是一个菠萝,菠萝,菠萝,菠萝一二傻123啊";
    _titleLab.numberOfLines = 0;
    _titleLab.textColor = UIColorWithRGB(70, 70, 70, 1);
    [self addSubview:_titleLab];
    
    setHeight = 50;
    // 期号
    [self setTheLab:CGRectMake(110, setHeight, 50, 25) textColor:UIColorWithRGB(88, 88, 88, 1) labText:@"期号:" setFont:14 setCen:NO];
    
    _datanumLab= [[UILabel alloc] initWithFrame:CGRectMake(150, setHeight, iPhoneWidth - 170, 25)];
    _datanumLab.backgroundColor = [UIColor clearColor];
    _datanumLab.font = [UIFont systemFontOfSize:13];
    _datanumLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _datanumLab.text = @"201515151";
    _datanumLab.textColor = UIColorWithRGB(0, 118, 235, 1);
    [self addSubview:_datanumLab];
    
    setHeight = setHeight + 25;

    // 总需
    [self setTheLab:CGRectMake(110, setHeight, 50, 25) textColor:UIColorWithRGB(88, 88, 88, 1) labText:@"总需:" setFont:14 setCen:NO];
    
    //
    _allPeoLab= [[UILabel alloc] initWithFrame:CGRectMake(150, setHeight, iPhoneWidth - 170, 25)];
    _allPeoLab.backgroundColor = [UIColor clearColor];
    _allPeoLab.font = [UIFont systemFontOfSize:13];
    _allPeoLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _allPeoLab.text = @"35人次";
    _allPeoLab.textColor = UIColorWithRGB(88, 88, 88, 1);
    [self addSubview:_allPeoLab];
    
    setHeight = setHeight + 25;
    
    // 幸运号码
    [self setTheLab:CGRectMake(110, setHeight, 100, 25) textColor:UIColorWithRGB(88, 88, 88, 1) labText:@"幸运号码:" setFont:14 setCen:NO];
    
    //
    _lucknumLab = [[UILabel alloc] initWithFrame:CGRectMake(180, setHeight, iPhoneWidth - 170, 25)];
    _lucknumLab.backgroundColor = [UIColor clearColor];
    _lucknumLab.font = [UIFont systemFontOfSize:13];
    _lucknumLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _lucknumLab.text = @"10000015";
    _lucknumLab.textColor = UIColorWithRGB(253, 130, 74, 1);
    [self addSubview:_lucknumLab];
    
    setHeight = setHeight + 25;
    
    // 本期参与
    [self setTheLab:CGRectMake(110, setHeight, 100, 25) textColor:UIColorWithRGB(88,88, 88, 1) labText:@"本期参与:" setFont:14 setCen:NO];
    
    //
    _inpeoLab= [[MMLabel alloc] initWithFrame:CGRectMake(180, setHeight, iPhoneWidth - 170, 25)];
    _inpeoLab.backgroundColor = [UIColor clearColor];
    _inpeoLab.font = [UIFont systemFontOfSize:13];
    _inpeoLab.textAlignment = NSTextAlignmentLeft;
    _inpeoLab.textColor = UIColorWithRGB(88, 88, 88, 1);
     _inpeoLab.keyWordColor = UIColorWithRGB(253, 130, 74, 1);
    [self addSubview:_inpeoLab];
    
    
    setHeight = setHeight + 25;
    
    // 揭晓时间
    [self setTheLab:CGRectMake(110, setHeight, 80, 25) textColor:UIColorWithRGB(88, 88, 88, 1) labText:@"揭晓时间:" setFont:14 setCen:NO];
    
    //
    _timelab= [[UILabel alloc] initWithFrame:CGRectMake(180, setHeight, iPhoneWidth - 190, 25)];
    _timelab.backgroundColor = [UIColor clearColor];
    _timelab.font = [UIFont systemFontOfSize:13];
    _timelab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _timelab.text = @"2016-01-06 16:31:55";
    _timelab.textColor = UIColorWithRGB(253, 130, 74, 1);
    [self addSubview:_timelab];
    
    
    setHeight = setHeight + 25;
    
    // 图标
    UIImageView *slineImgView = [[UIImageView alloc] init];
    slineImgView.frame = CGRectMake(10, setHeight , iPhoneWidth-20, 1);
    
    slineImgView.backgroundColor = UIColorWithRGB(231, 231, 231, 1);
    [self addSubview:slineImgView];

    //
    _explainlab= [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth  - 90, setHeight+7, 100, 30)];
    _explainlab.backgroundColor = [UIColor clearColor];
    _explainlab.font = [UIFont systemFontOfSize:13];
    _explainlab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
//   _explainlab.text = @"等待奖品派发";
    _explainlab.textColor = UIColorWithRGB(253, 130, 74, 1);
    [self addSubview:_explainlab];
    
    //确认收货地址
    _sureAddressBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth  - 110, setHeight+7, 100, 30)];
    _sureAddressBtn.backgroundColor = UIColorWithRGB(232, 94, 30, 1);
    [self addSubview: _sureAddressBtn];
    [ _sureAddressBtn setTitle:@"确认收货地址" forState:UIControlStateNormal];
    [ _sureAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureAddressBtn.titleLabel.font = defaultFontSize(13);
    _sureAddressBtn.layer.masksToBounds=YES;
    _sureAddressBtn.layer.cornerRadius=3;
    [_sureAddressBtn addTarget:self action:@selector(doAnyBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    setHeight = setHeight+44;
    
    UIImageView *lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 1)];
    lineImg.backgroundColor = UIColorWithRGB(228, 228, 228, 1);
    [self addSubview:lineImg];

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
- (void)setNode:(WinningRecordNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.title;
    self.datanumLab.text = _node.code;
    self.lucknumLab.text = _node.luck_code;
    self.timelab.text = _node.luck_time;
//    self.explainlab.text = _node.Cname;

    switch (_node.status) {
            // 状态-1 已过期 0待填写地址 1等待商品派发 2已发货 3 已签收
        case -1:
        {
            self.sureAddressBtn.hidden = YES;
            self.explainlab.hidden = NO;
            self.explainlab.text = @"已过期";
//            self.explainlab.textColor = UIColorWithRGB(253, 130, 74, 1);
            self.explainlab.textColor = [UIColor lightGrayColor];

        }
            break;
        case 0:
        {
            self.sureAddressBtn.hidden = NO;
            self.explainlab.hidden = YES;
            [self.sureAddressBtn setTitle:@"确认收货地址" forState:UIControlStateNormal];

        }
            break;
        case 1:
        {
            self.sureAddressBtn.hidden = YES;
            self.explainlab.hidden = NO;
            self.explainlab.text = @"等待商品派发";
            self.explainlab.textColor = UIColorWithRGB(254, 127, 81, 1);
            
        }
            break;
        case 2:
        {
            self.sureAddressBtn.hidden = NO;
            self.explainlab.hidden = YES;
            [self.sureAddressBtn setTitle:@"确认收货" forState:UIControlStateNormal];
      
        }
            break;
        case 3:
        {
            self.sureAddressBtn.hidden = NO;
            self.explainlab.hidden = YES;
            [self.sureAddressBtn setTitle:@"我要晒单" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    _allPeoLab.text = [NSString stringWithFormat:@"%@人次",_node.price];
   self.inpeoLab.text = [NSString stringWithFormat:@"%@人次",_node.count];
     self.inpeoLab.keyWord = [NSString stringWithFormat:@"%@",_node.count];

    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
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

//TODO:点击事件
- (void)doAnyBtnPressed:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(doAnyPressed:)]) {
        [_delegate doAnyPressed:sender];
    }
}
@end


