//
//  BuyDetilView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "BuyDetilView.h"
#import "FontDefine.h"

#define SETFOOTHIGH         65  // 底部高度

#define MENUHEIHT 40

@implementation BuyDetilView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//TODO:传入数据
- (void)setDnode:(BuyDetailNode *)dnode{
   
    _dnode = dnode;
    [self commHeadInit];

}

//TODO:初始化数组
-(void)commHeadInit{
    // 关闭界面
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    cancelBtn.backgroundColor = [UIColor clearColor];
//    cancelBtn.alpha = 0.3;
    [cancelBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1000;
    [self addSubview:cancelBtn];
    
    float  setY = iPhoneHeight - 300;
    [self setTheImg:CGRectMake(0, setY, iPhoneWidth, 300) imgStr:@"" bgColor:[UIColor whiteColor]];
    
    // 图片
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setY + 10, 90, 70)];
    headImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headImageView];
    headImageView.layer.masksToBounds=YES;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_dnode.src] placeholderImage:[UIImage imageNamed:@"Public_list_noImg.png"]];
    
    // 标题
    [self setTheLab:CGRectMake(110, setY , iPhoneWidth - 150, 50) textColor:[UIColor blackColor] labText:_dnode.name setFont:17 setCen:NO];
    // 说明
    [self setTheLab:CGRectMake(90, setY + 50 , iPhoneWidth - 150, 50) textColor:[UIColor grayColor] labText:_dnode.sub_name setFont:15 setCen:NO];
    // 状态
//    [self setTheImg:CGRectMake(100, setY + 66, 80, 24) imgStr:@"" bgColor:[UIColor greenColor]];
//    [self setTheImg:CGRectMake(iPhoneWidth - 40, setY + 36, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
    
    setY = setY + 90;
    
    [self setTheImg:CGRectMake(0, setY , iPhoneWidth, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(238, 238, 238, 1)];
    
    // 任务奖励
    [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"任务奖励" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(78, setY  , 120, 50) textColor:[UIColor grayColor] labText:@"（葫芦币）" setFont:13 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 140 , setY  , 120, 50) textColor:UIColorWithRGB(251, 89, 0, 1) labText:_dnode.profit setFont:17 setCen:YES];
    setY = setY + 50;

    [self setTheImg:CGRectMake(13, setY , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(238, 238, 238, 1)];
    
    // 保证金
    [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"保证金" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(63, setY  , 120, 50) textColor:[UIColor grayColor] labText:@"（葫芦币）" setFont:13 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 140 , setY  , 120, 50) textColor:UIColorWithRGB(251, 89, 0, 1) labText:_dnode.bond setFont:17 setCen:YES];
    setY = setY + 50;

    [self setTheImg:CGRectMake(13, setY , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(238, 238, 238, 1)];
    
    // 可用余额
    [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"可用余额" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(79, setY  , 120, 50) textColor:[UIColor grayColor] labText:@"（葫芦币）" setFont:13 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 140 , setY  , 120, 50) textColor:UIColorWithRGB(251, 89, 0, 1) labText:[UserDataManager sharedUserDataManager].userData.Utotal_Free setFont:17 setCen:YES];
    setY = setY + 50;
    
//    [self setTheImg:CGRectMake(13, setY , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:[UIColor grayColor]];

    float bzj = [[_dnode.bond stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
    float ye = [[[UserDataManager sharedUserDataManager].userData.Utotal_Free stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];

    UIButton *tasBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , iPhoneHeight - SETFOOTHIGH , iPhoneWidth, SETFOOTHIGH)];
    tasBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [tasBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    tasBtn.tag = 1001;
    [tasBtn setTitle:@"确定领取" forState:UIControlStateNormal];
    tasBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self addSubview:tasBtn];
    
    if (bzj > ye) {
        [tasBtn setTitle:@"余额不足,请充值" forState:UIControlStateNormal];
        [tasBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tasBtn.backgroundColor = [UIColor grayColor];
//        tasBtn.userInteractionEnabled = NO;
    }
}

//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
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
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:font];
    [self addSubview:lab];
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 关闭
        case 1000:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(cancelBuyView)]){
                [_delegate cancelBuyView];
            }
        }
            break;
            // 确定领取任务
        case 1001:{
            if (_delegate &&[_delegate respondsToSelector:@selector(sureBuyView)]){
                [_delegate sureBuyView];
            }
        }
            break;
        default:
            break;
    }
}


//TODO:显示动画
- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}

//TODO:取消界面
- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}
@end
