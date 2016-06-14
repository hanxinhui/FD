//
//  MySnatchViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MySnatchViewController.h"
#import "FontDefine.h"
#import "SnatchRecordListViewController.h"
#import "MyCountersignViewController.h"
#import "CountersignViewController.h"
#import "WinningRecordViewController.h"
#import "ShowMyViewController.h"


#define SETFOOTHIGH         50  // 底部高度

#define SETWIDTH        self.view.frame.size.width / 3

@interface MySnatchViewController ()


@end

@implementation MySnatchViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"我的抽疯";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - TARBAR_HIGHT)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];
    setHeight =  20;
    
    [self setTheLineImg:setHeight ];

    
    
   // 抽疯记录
    [self setTheBtn:CGRectMake(0  , setHeight , SETWIDTH,  SETWIDTH) btnTag:10000 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH/2-10, setHeight+25, 28, 35) imgStr:@"MySnatch_record.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH/2-25  , setHeight+20, SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"抽疯记录" setFont:14];

    
    UIImageView *ashuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth/3, setHeight+1, 1, SETWIDTH*2)];
    ashuImgView.backgroundColor = UIColorWithRGB(232, 232, 232, 0.7);
    [_mainScrollView addSubview:ashuImgView];
  
      // 中奖记录
    [self setTheBtn:CGRectMake(SETWIDTH+1  , setHeight , SETWIDTH,  SETWIDTH) btnTag:10001 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH*2-SETWIDTH/2-10 , setHeight+25, 28, 35) imgStr:@"MySnatch_Winning.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH*2-SETWIDTH/2-25 , setHeight+20 , SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"中奖记录" setFont:14];
    
    
    UIImageView *shuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth/3*2, setHeight+1, 1, SETWIDTH)];
    shuImgView.backgroundColor = UIColorWithRGB(232, 232, 232, 0.7);
    [_mainScrollView addSubview:shuImgView];
    
    
   //    我的晒单
    [self setTheBtn:CGRectMake(SETWIDTH * 2+1 ,setHeight, SETWIDTH,  SETWIDTH) btnTag:10002 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH *3 -SETWIDTH/2-15, setHeight+30, 35, 30) imgStr:@"MySnatch_Show.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH *3 -SETWIDTH/2-25,setHeight+20, SETWIDTH, SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"我的晒单" setFont:14];
    
    [self setTheLineImg:setHeight+SETWIDTH];
    

    
    //   暗号抽疯
    [self setTheBtn:CGRectMake(0  , setHeight+SETWIDTH , SETWIDTH,  SETWIDTH) btnTag:10003 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH/2-15, setHeight+SETWIDTH+28, 34, 32) imgStr:@"MySnatch_Command.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH/2-25 , setHeight+SETWIDTH+20 , SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"暗号抽疯" setFont:14];
    [self setLineImg:setHeight+SETWIDTH*2];
    
    
}

//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [_mainScrollView addSubview:btn];
    
    
    
    
}


//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [_mainScrollView addSubview:imgView];
}
//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  {
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    lab.textAlignment = NSTextAlignmentLeft;
    
    lab.font = [UIFont systemFontOfSize:font];
    [_mainScrollView addSubview:lab];
}


//TODO:设置横线
- (void)setLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, sizeY - 1, iPhoneWidth/3 , 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    
    [_mainScrollView addSubview:imgView];
    
}
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, sizeY - 1, iPhoneWidth , 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [_mainScrollView addSubview:imgView];
    
}

//TODO:点击事件
- (void)toBtnPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 夺宝记录
        case 10000:
        {
            SnatchRecordListViewController *recode = [[SnatchRecordListViewController alloc]init];
            
            [self.navigationController pushViewController: recode animated:YES];
        }
            break;
            // 中奖记录
        case 10001:{
            WinningRecordViewController *winningRecordViewController = [[WinningRecordViewController alloc] init];
            [self.navigationController pushViewController:winningRecordViewController animated:YES];
            
        }
            break;
            // 我的晒单
        case 10002:{
            ShowMyViewController *showMyViewController = [[ShowMyViewController alloc] init];
            showMyViewController.goodsid = @"0";
            [self.navigationController pushViewController:showMyViewController animated:YES];
        }
            break;
            // 口令抢宝
        case 10003:{
            
            CountersignViewController *countersignViewController = [[CountersignViewController alloc] init];
            [self.navigationController pushViewController:countersignViewController animated:YES];
            
        }
            break;
        default:
            break;
    }
}






#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetFavList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DETAIL] forKey:REQ_CODE];
//  
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
//    [dict setObject:_goodID forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
//    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
//            // 详情
//        case REQ_ANYTIMEBUY_DETAIL:
//        {
//            self.jsonString = [resultDict objectForKey:RESP_CONTENT];
//            
//
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    [self.progressView hide:YES];
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
//    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
//            // 详情
//        case REQ_ANYTIMEBUY_DETAIL:{
//        }
//            break;
//            
//        default:
//            break;
//    }
    
    
}

@end
