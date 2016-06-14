//
//  AboutViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "AboutViewController.h"


@interface AboutViewController ()


@end

@implementation AboutViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.titleLable.textColor = [UIColor blackColor];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.titleLable.text = @"关于";
  
    //设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag = 100000;
    self.leftBtn = backBtn;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    setHeight = setHeight + 30;
    // icon
    [self setTheImg:CGRectMake((iPhoneWidth - 60) / 2, setHeight, 60, 60) imgStr:@"icon.png" bgColor:[UIColor clearColor]];

    setHeight = setHeight + 60;

    // 项目名称
    [self setTheLab:CGRectMake((iPhoneWidth - 100) / 2, setHeight, 100, 20) textColor:[UIColor blackColor] labText:ProjectName setFont:13 setCen:YES];

    setHeight = setHeight + 20;
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    // 版本号
    [self setTheLab:CGRectMake((iPhoneWidth - 100) / 2, setHeight, 100, 20) textColor:[UIColor blackColor] labText:currentVersion setFont:13 setCen:YES];

    setHeight = setHeight + 50;
    
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth , 45) btnTag:100001 imgStr:@""];
    [self setTheLab:CGRectMake(20, setHeight, 100, 45) textColor:[UIColor blackColor] labText:@"评分" setFont:17 setCen:NO];

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}



//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    
    
    [self setTheImg:CGRectMake(iPhoneWidth - 40, setHeight + 14, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
    
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
//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 返回
        case 100000:
        {
            [self.navigationController popViewControllerAnimated:YES];

        }
            break;
            // 评分
        case 100001:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ProjectURL]];

        }
            break;
  
        default:
            break;
    }
}

#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

@end
