//
//  WAAddressCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WAAddressCell.h"
#import "FontDefine.h"

@implementation WAAddressCell

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
    [self setTheLab:CGRectMake(15, 10, iPhoneWidth - 30, 45) textColor:UIColorWithRGB(72, 72, 72, 1) labText:@"地址信息" setFont:16 setCen:NO];
    
    setHeight = 55;

    // 图标
    UIImageView *zlineImgView = [[UIImageView alloc] init];
    zlineImgView.frame = CGRectMake(10, setHeight , iPhoneWidth-20, 1);
    
    zlineImgView.backgroundColor = UIColorWithRGB(217, 217, 217, 1);
    [self addSubview:zlineImgView];
    
    
    // 姓名
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(30, setHeight+10 , iPhoneWidth - 40, 30)];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _nameLab.text = @"摆渡人";
    _nameLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_nameLab];
    
    // 联系方式
    _phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth /2, setHeight+10, iPhoneWidth /2 - 20, 25)];
    _phoneLab.backgroundColor = [UIColor clearColor];
    _phoneLab.font = [UIFont systemFontOfSize:15];
    _phoneLab.textAlignment = NSTextAlignmentRight;
    // leoxu delete
    _phoneLab.text = @"15051874043";
    _phoneLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_phoneLab];
    
    setHeight = setHeight + 25;

    // 地址
    _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 95, iPhoneWidth - 40, 40)];
    _addressLab.backgroundColor = [UIColor clearColor];
    _addressLab.font = [UIFont systemFontOfSize:15];
    _addressLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _addressLab.text = @"江苏省南京市幸福区幸福路上幸福之家";
    _addressLab.numberOfLines = 0;
    _addressLab.textColor = UIColorWithRGB(72, 72, 72, 1);
    [self addSubview:_addressLab];
    


    
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
    
    self.nameLab.text = _node.consignee;
    self.phoneLab.text = _node.mobile;
    self.addressLab.text = _node.address;

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


