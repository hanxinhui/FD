//
//  WAStatusCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "WAStatusCell.h"
#import "FontDefine.h"

@implementation WAStatusCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


//TODO:初始化数据
- (void)creat{
    float setH = 0;
    
    // 奖品状态
    [self setTheLab:CGRectMake(15, setH, iPhoneWidth - 30, 45) textColor:UIColorWithRGB(43, 43, 43, 1) labText:@"奖品状态" setFont:16 setCen:NO];
    
    setH = 45;
    [self setTheImg:CGRectMake(10, setH, iPhoneWidth - 20, 1) imgStr:@"" bgColor:UIColorWithRGB(217, 217, 217, 1)];
    
    [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_gray.png" bgColor:[UIColor clearColor]];
    
    [self setTheLab:CGRectMake(70, setH, iPhoneWidth - 90, 45) textColor:UIColorWithRGB(76, 76, 76, 1) labText:@"获得奖品" setFont:14 setCen:NO];

    // 获得奖品时间
    _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth / 2+25, setH, iPhoneWidth / 2 - 32, 45)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.textColor = UIColorWithRGB(76, 76, 76, 1);
    _timeLab.font = [UIFont systemFontOfSize:14];
    _timeLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_timeLab];

    
    [self setTheImg:CGRectMake(35, setH + 31 , 1, 15) imgStr:@"winning_shu_done.png" bgColor:UIColorWithRGB(179, 179, 179, 1)];
    
    [self setTheImg:CGRectMake(50, setH+45, iPhoneWidth-60 , 1) imgStr:@"" bgColor:UIColorWithRGB(217, 217, 217, 1)];

    
    setH = setH + 45;

    [self setTheImg:CGRectMake(35, setH+1  , 1, 13) imgStr:@"winning_shu_done.png" bgColor:UIColorWithRGB(179, 179, 179, 1)];
    
    NSInteger isSetAddress = _node.status ;

    if (isSetAddress == 0) {
      
     [self setTheImg:CGRectMake(35, setH + 30  , 1, 45) imgStr:@"winning_xu_done.png" bgColor:[UIColor clearColor]];
       [self setTheImg:CGRectMake(26, setH+10, 20, 20) imgStr:@"winning_yuan_red.png" bgColor:[UIColor clearColor]];
        [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(252, 91, 17, 1) labText:@"确认收货地址" setFont:14 setCen:NO];
        [self setTheBtn:CGRectMake(iPhoneWidth  - 100, setH + 5, 90, 35) btnTag:100001 titleName:@"选择地址"];
    }
    if (isSetAddress > 0){
        [self setTheImg:CGRectMake(35, setH + 30  , 1, 30) imgStr:@"" bgColor:UIColorWithRGB(179, 179, 179, 1)];
        [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_gray.png" bgColor:[UIColor clearColor]];
        [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(76, 76, 76, 1) labText:@"确认收货地址" setFont:14 setCen:NO];
        
    //  确认地址时间
        _addressTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth / 2+10, setH, iPhoneWidth / 2 - 20, 45)];
        _addressTimeLab.backgroundColor = [UIColor clearColor];
        _addressTimeLab.textColor = UIColorWithRGB(76, 76, 76, 1);
        _addressTimeLab.font = [UIFont systemFontOfSize:14];
        _addressTimeLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:_addressTimeLab];

    }

    setH = setH + 45;
    [self setTheImg:CGRectMake(50, setH, iPhoneWidth-60 , 1) imgStr:@"" bgColor:UIColorWithRGB(217, 217, 217, 1)];


    if (isSetAddress > 1){
        [self setTheImg:CGRectMake(35, setH + 30  , 1, 30) imgStr:@"" bgColor:UIColorWithRGB(179, 179, 179, 1)];
        [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_gray.png" bgColor:[UIColor clearColor]];
        [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(76, 76, 76, 1) labText:@"奖品派发" setFont:14 setCen:NO];
        
      // 奖品派发时间
        _expressTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth / 2+10, setH, iPhoneWidth / 2 - 20, 45)];
         _expressTimeLab.backgroundColor = [UIColor clearColor];
         _expressTimeLab.textColor = UIColorWithRGB(76, 76, 76, 1);
         _expressTimeLab.font = [UIFont systemFontOfSize:14];
         _expressTimeLab.textAlignment = NSTextAlignmentRight;
        [self addSubview: _expressTimeLab];


    }else{
        if (isSetAddress == 1) {
            
            [self setTheImg:CGRectMake(35, setH + 30  , 1, 30) imgStr:@"winning_xu_done.png" bgColor:[UIColor clearColor]];
            [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_red.png" bgColor:[UIColor clearColor]];
            [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(252, 91, 17, 1) labText:@"奖品派发" setFont:14 setCen:NO];
            [self setTheLab:CGRectMake(iPhoneWidth / 2+10, setH, iPhoneWidth / 2 - 20, 45) textColor:UIColorWithRGB(76, 76, 76, 1) labText:@"奖品备货中..." setFont:14 setCen:YES];
        }else{
            
            [self setTheImg:CGRectMake(35, setH + 30  , 1, 30) imgStr:@"winning_xu_done.png" bgColor:[UIColor clearColor]];
            [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(192, 192, 192, 1) labText:@"奖品派发" setFont:14 setCen:NO];
            [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_white.png" bgColor:[UIColor clearColor]];

        }
    }
    
    setH = setH + 45;
    [self setTheImg:CGRectMake(50, setH, iPhoneWidth - 60, 1) imgStr:@"" bgColor:UIColorWithRGB(217, 217, 217, 1)];

    if (isSetAddress > 2){
        [self setTheImg:CGRectMake(35, setH + 30  , 1, 30) imgStr:@"" bgColor:UIColorWithRGB(179, 179, 179, 1)];
        [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_gray.png" bgColor:[UIColor clearColor]];
        [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(76, 76, 76, 1) labText:@"确认收货" setFont:14 setCen:NO];
        
        // 确认收货时间
        _finishTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth / 2+10, setH, iPhoneWidth / 2 - 20, 45)];
         _finishTimeLab.backgroundColor = [UIColor clearColor];
         _finishTimeLab.textColor = UIColorWithRGB(76, 76, 76, 1);
         _finishTimeLab.font = [UIFont systemFontOfSize:14];
         _finishTimeLab.textAlignment = NSTextAlignmentRight;
//        [self addSubview: _finishTimeLab];

        
    }else{
        if (isSetAddress == 2) {
            
            [self setTheImg:CGRectMake(35, setH + 30  , 1, 30) imgStr:@"winning_xu_done.png" bgColor:[UIColor clearColor]];
            [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_red.png" bgColor:[UIColor clearColor]];
            [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(252, 91, 17, 1) labText:@"确认收货" setFont:14 setCen:NO];
            [self setTheBtn:CGRectMake(iPhoneWidth  - 100, setH + 5, 90, 35) btnTag:100002 titleName:@"确认收货"];


        }else{
            
             [self setTheImg:CGRectMake(35, setH + 30  , 1, 30) imgStr:@"winning_xu_done.png" bgColor:[UIColor clearColor]];
            
            [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(192, 192, 192, 1) labText:@"确认收货" setFont:14 setCen:NO];
            [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_white.png" bgColor:[UIColor clearColor]];
        }
    }
    
    setH = setH + 45;
    [self setTheImg:CGRectMake(50, setH, iPhoneWidth - 60, 1) imgStr:@"" bgColor:UIColorWithRGB(217, 217, 217, 1)];
    
    if (isSetAddress > 3){

        [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_gray.png" bgColor:[UIColor clearColor]];
        [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(76, 76, 76, 1) labText:@"已签收" setFont:14 setCen:NO];
        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth / 2+10, setH, iPhoneWidth / 2 - 20, 45)];
        _timeLab.backgroundColor = [UIColor clearColor];
        _timeLab.textColor = UIColorWithRGB(76, 76, 76, 1);
        _timeLab.font = [UIFont systemFontOfSize:14];
        _timeLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:_timeLab];


        
    }else{
        if (isSetAddress == 3) {
            
            [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_red.png" bgColor:[UIColor clearColor]];
            [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(252, 91, 17, 1) labText:@"已签收" setFont:14 setCen:NO];
            
            [self setTheBtn:CGRectMake(iPhoneWidth  - 100, setH + 5, 90, 35) btnTag:100003 titleName:@"我要晒单"];
        }else{
            
            [self setTheLab:CGRectMake(70, setH, iPhoneWidth  - 120, 45) textColor:UIColorWithRGB(192, 192, 192, 1) labText:@"已签收" setFont:14 setCen:NO];
             [self setTheImg:CGRectMake(26, setH +13, 20, 20) imgStr:@"winning_yuan_white.png" bgColor:[UIColor clearColor]];

        }
    }
    
    setH = setH + 45;
    [self setTheImg:CGRectMake(0, setH, iPhoneWidth, 10) imgStr:@"" bgColor:UIColorWithRGB(247, 247, 247, 1)];
    
    [self setTheLineImg:setH];
    [self setTheLineImg:setH+10];
}

//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag titleName:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = UIColorWithRGB(232, 102, 33, 1);;
    [btn setTitle:name forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    
    btn.titleLabel.font = defaultFontSize(15);
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=3;

    [self addSubview:btn];
    
}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self addSubview:imgView];
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
- (void)setNode:(WinningAffirmNode*)node{
    if (_node == node) return;
    
    _node = node;
    
 
    
    [self creat];
    self.timeLab.text = [[NSString stringWithFormat:@"%@",_node.luck_time]substringToIndex:16];
    self.addressTimeLab.text = _node.address_time;
    self.expressTimeLab.text = _node.express_time;
    self.finishTimeLab.text = _node.finish_time;

}
//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, sizeY - 1, iPhoneWidth, 1)];
    imgView.backgroundColor = UIColorWithRGB(217, 217, 217, 1);
    
    
    [self addSubview:imgView];
}


- (void)awakeFromNib
{
    // Initialization code
}


//TODO:响应事件
- (void)toBtnPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 新增地址
        case 100001:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(doAnyPressed:)]) {
                [_delegate doAnyPressed:sender];
            }
        }
            break;
            // 确认收货
        case 100002:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(doAnyPressed:)]) {
                [_delegate doAnyPressed:sender];
            }
        }
            break;
            // 我要晒单
        case 100003:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(doAnyPressed:)]) {
                [_delegate doAnyPressed:sender];
            }
        }
            break;
        default:
            break;
    }
}

@end


