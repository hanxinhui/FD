//
//  ShowViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ShowViewController.h"


#define SETFOOTHIGH         65  // 底部高度

@interface ShowViewController ()


@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    setHeight = IOS7?20:0;
    
    NSString *help1;
    NSString *help2;
    NSString *help3;
    NSString *help4;
    
    // 4/4S
    if (iPhoneWidth == 320 && iPhoneHeight<500) {
        help1 = @"help_I4_1";
        help2 = @"help_I4_2";
        help3 = @"help_I4_3";
        help4 = @"help_I4_4";
    }
    else if(iPhone5){
        help1 = @"help_I5_1";
        help2 = @"help_I5_2";
        help3 = @"help_I5_3";
        help4 = @"help_I5_4";
    }
    else if(iPhone6){
        help1 = @"help_I6_1";
        help2 = @"help_I6_2";
        help3 = @"help_I6_3";
        help4 = @"help_I6_4";
    }
    else if(iPhone6plus){
        help1 = @"help_I6P_1";
        help2 = @"help_I6P_2";
        help3 = @"help_I6P_3";
        help4 = @"help_I6P_4";
    }
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:help1];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:help2];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:help3];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:help4];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    
    [intro setDelegate:self];
    intro.isHelp = YES;
    [intro showInView:self.view animateDuration:0.0];
   
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}



#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)introDidFinish {
    NSLog(@"Intro callback");
    [self backPressed];
}
@end
