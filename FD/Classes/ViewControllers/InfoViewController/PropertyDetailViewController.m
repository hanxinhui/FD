//
//  PropertyDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "PropertyDetailViewController.h"


@interface PropertyDetailViewController ()


@end

@implementation PropertyDetailViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"详情";
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);

    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
}

//TODO:传入数据
- (void)setPnode:(PropertyListNode *)pnode{
    if (_pnode == pnode)return;
    _pnode = pnode;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1.0);
    setHeight = IOS7?20:0;

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    // 流水号
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 65) imgStr:@"" bgColor:UIColorWithRGB(248, 248, 248, 1)];
    
    [self setTheLab:CGRectMake(15, setHeight, 100, 65) textColor:[UIColor blackColor] labText:@"流水号" setFont:17 setCen:NO];
    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(115, setHeight, iPhoneWidth - 130, 65)];
    _numLab.backgroundColor = [UIColor clearColor];
    _numLab.text = _pnode.pcode;
    _numLab.textColor = [UIColor blackColor];
    _numLab.textAlignment = NSTextAlignmentRight;
    _numLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_numLab];
    
    setHeight = setHeight + 65;
    [self setTheImg:CGRectMake(15, setHeight - 1, iPhoneWidth, 1) imgStr:@"" bgColor:UIColorWithRGB(234, 234, 234, 2)];

    // 备注
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 65) imgStr:@"" bgColor:UIColorWithRGB(248, 248, 248, 1)];
    
    [self setTheLab:CGRectMake(15, setHeight, 100, 65) textColor:[UIColor blackColor] labText:@"备注" setFont:17 setCen:NO];
    _comLab = [[UILabel alloc] initWithFrame:CGRectMake(115, setHeight, iPhoneWidth - 130, 65)];
    _comLab.backgroundColor = [UIColor clearColor];
    _comLab.text = _pnode.pdesc;
    _comLab.textAlignment = NSTextAlignmentRight;
    _comLab.textColor = [UIColor blackColor];
    _comLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_comLab];
    
    setHeight = setHeight + 65;
    [self setTheImg:CGRectMake(15, setHeight - 1, iPhoneWidth, 1) imgStr:@"" bgColor:UIColorWithRGB(234, 234, 234, 2)];
    
    // 金额
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 65) imgStr:@"" bgColor:UIColorWithRGB(248, 248, 248, 1)];
    
    [self setTheLab:CGRectMake(15, setHeight, 130, 65) textColor:[UIColor blackColor] labText:@"金额（葫芦币）" setFont:17 setCen:NO];
    _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(115, setHeight, iPhoneWidth - 130, 65)];
    _moneyLab.backgroundColor = [UIColor clearColor];
    _moneyLab.text = _pnode.pmoney;
    _moneyLab.textColor = [UIColor blackColor];
    _moneyLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_moneyLab];
    _moneyLab.textAlignment = NSTextAlignmentRight;

    setHeight = setHeight + 65;
    [self setTheImg:CGRectMake(15, setHeight - 1, iPhoneWidth, 1) imgStr:@"" bgColor:UIColorWithRGB(234, 234, 234, 2)];
    
    // 时间
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 65) imgStr:@"" bgColor:UIColorWithRGB(248, 248, 248, 1)];
    
    [self setTheLab:CGRectMake(15, setHeight, 100, 65) textColor:[UIColor blackColor] labText:@"时间" setFont:17 setCen:NO];
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(115, setHeight, iPhoneWidth - 130, 65)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.text = _pnode.ptime;
    _timeLab.textColor = [UIColor blackColor];
    _timeLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_timeLab];
    _timeLab.textAlignment = NSTextAlignmentRight;

    setHeight = setHeight + 65;
    [self setTheImg:CGRectMake(15, setHeight - 1, iPhoneWidth , 1) imgStr:@"" bgColor:UIColorWithRGB(234, 234, 234, 2)];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}



//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self.view addSubview:imgView];
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
    [self.view addSubview:lab];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
