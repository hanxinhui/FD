//
//  FindViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "FindViewController.h"
#import "LoginViewController.h"
#import "MyTasksViewController.h"
#import "AnyTimeBuyViewController.h"
#import "ShopViewController.h"
#import "SnatchViewController.h"
#import "AppDelegate.h"
#import "ModifyDataViewController.h"
#import "BankListViewController.h"
#import "PublicWebViewController.h"
#import "RechargeableViewController.h"
#import "SignUpViewController.h"

#define PAGENUM     5

#define SETWIDTH        self.view.frame.size.width / 3

@interface FindViewController ()


@end

@implementation FindViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"发现";
  
//    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);
    self.statusLight = YES;
    [self setStatusSytle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
    // 登录成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinished) name:USER_DID_LOG_IN object:nil];
    
    setHeight = IOS7?20:0;

    [self initNavBar];
    
    setHeight = setHeight + NVARBAR_HIGHT;

    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - TARBAR_HIGHT)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
//    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];
    setHeight = 35;
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/2-43, setHeight-33, 150, 30)];
    moneyLabel.text = @"我们教您赚钱";
    moneyLabel.textColor =  UIColorWithRGB(89, 89, 89, 1);
    moneyLabel.font = [UIFont systemFontOfSize:15];
    [_mainScrollView addSubview:moneyLabel];
    
    
    setHeight =  setHeight+0.1 ;
    
    // 随时赚
    [self setTheBtn:CGRectMake(0  , setHeight , SETWIDTH,  SETWIDTH) btnTag:10000 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH/2-15, setHeight+30, 31, 27) imgStr:@"Home_head_works.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH/2-20  , setHeight+20, SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"随时赚" setFont:14];
    
        //
    UIImageView *ashuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SETWIDTH*2-0.1, setHeight, 1,  SETWIDTH*2)];
    ashuImgView.backgroundColor = [UIColor redColor];
    [_mainScrollView addSubview:ashuImgView];

    
    // 签到
    [self setTheBtn:CGRectMake(SETWIDTH+1  , setHeight , SETWIDTH,  SETWIDTH) btnTag:10002 imgStr:nil];
    
    [self setTheImg:CGRectMake(SETWIDTH*2-SETWIDTH/2-15 , setHeight+30, 31, 27) imgStr:@"Home_head_register.png" bgColor:[UIColor whiteColor]];
       
    [self setTheLab:CGRectMake(SETWIDTH*2-SETWIDTH/2-13 , setHeight+20 , SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"签到" setFont:14];

         [self setTheLab:CGRectMake(SETWIDTH*2-SETWIDTH/2-48, setHeight+SETWIDTH-30, SETWIDTH, 30) textColor:UIColorWithRGB(248, 133, 53, 1) labText:@"连续签到收益更高" setFont:12];
    
    [self setTheImg:CGRectMake(SETWIDTH*2-40, setHeight, 40, 40) imgStr:@"Icon_new.png" bgColor:[UIColor whiteColor]];
    
   
    
    //   抽疯
    [self setTheBtn:CGRectMake(SETWIDTH * 2+0.5 ,setHeight, SETWIDTH,  SETWIDTH) btnTag:10003 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH *3 -SETWIDTH/2-15, setHeight+30, 31, 27) imgStr:@"Home_head_lays.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH *3 -SETWIDTH/2-13,setHeight+20, SETWIDTH, SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"抽疯" setFont:14];
    [self setTheLineImg:setHeight+ SETWIDTH];
    
    [self setTheLab:CGRectMake(SETWIDTH *3 -SETWIDTH/2-43, setHeight+SETWIDTH-30, SETWIDTH, 30) textColor:UIColorWithRGB(248, 133, 53, 1) labText:@"一元实现大梦想" setFont:12];
     [self setTheImg:CGRectMake(SETWIDTH *3 -40, setHeight, 40, 40) imgStr:@"Icon_new.png" bgColor:[UIColor whiteColor]];
   
    //  随心兑
    [self setTheBtn:CGRectMake(0  , setHeight+ SETWIDTH , SETWIDTH-0.1,  SETWIDTH) btnTag:10001 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH/2-15, setHeight+SETWIDTH+30, 31, 27) imgStr:@"Home_head_moneys.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH/2-20 , setHeight+SETWIDTH+20 , SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"随心兑" setFont:14];

    //白底图片
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SETWIDTH+1  , setHeight+ SETWIDTH , SETWIDTH*2+0.1,  SETWIDTH)];
    img.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:img];
    
    UIImageView *shuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SETWIDTH*2-0.1, setHeight, 1,  SETWIDTH)];
    shuImgView.backgroundColor = UIColorWithRGB(232, 232, 232, 1);
    [_mainScrollView addSubview:shuImgView];

    
    UIImageView *shuImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(SETWIDTH*2-0.1, setHeight+ SETWIDTH, 1,  SETWIDTH)];
    shuImgView1.backgroundColor = UIColorWithRGB(232, 232, 232, 1);
    [_mainScrollView addSubview:shuImgView1];
    
    
    setHeight =  SETWIDTH*2+40;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/2-43, setHeight, 150, 30)];
    label.text = @"爱葫芦福利";
    label.textColor = UIColorWithRGB(89, 89, 89, 1);
    label.font = [UIFont systemFontOfSize:15];
    [_mainScrollView addSubview:label];
    
    setHeight = setHeight+30;
    // 完善资料
    [self setTheBtn:CGRectMake(0  , setHeight , SETWIDTH,  SETWIDTH) btnTag:10004 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH/2-15, setHeight+30, 31, 27) imgStr:@"Icon_MadfiyInfos.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH/2-30  , setHeight+20 , SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"完善资料" setFont:15];
    [self setTheLab:CGRectMake(SETWIDTH/2-37, setHeight+SETWIDTH-30, SETWIDTH, 30) textColor:UIColorWithRGB(248, 133, 53, 1) labText:@"送16元体验金" setFont:12];
    
    UIImageView *aashuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SETWIDTH-1, setHeight, 1, SETWIDTH)];
    aashuImgView.backgroundColor = UIColorWithRGB(232, 232, 232, 1);
    [_mainScrollView addSubview:aashuImgView];

    //首次充值
    [self setTheBtn:CGRectMake(SETWIDTH  , setHeight , SETWIDTH,  SETWIDTH) btnTag:10005 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH*2-SETWIDTH/2-15, setHeight+30, 31, 27) imgStr:@"Icon_FirstPays.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH*2-SETWIDTH/2-28  , setHeight+20 , SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"首次充值" setFont:14];
    [self setTheLab:CGRectMake(SETWIDTH*2-SETWIDTH/2-35, setHeight+SETWIDTH-30, SETWIDTH, 30) textColor:UIColorWithRGB(248, 133, 53, 1) labText:@"冲多少送多少" setFont:12];
    
    UIImageView *shuImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SETWIDTH*2-1, setHeight, 1,  SETWIDTH)];
    shuImgView2.backgroundColor = UIColorWithRGB(232, 232, 232, 1);
    [_mainScrollView addSubview:shuImgView2];

    
    //邀请好友
    [self setTheBtn:CGRectMake(SETWIDTH * 2 ,setHeight, SETWIDTH,  SETWIDTH) btnTag:10006 imgStr:nil];
    [self setTheImg:CGRectMake(SETWIDTH *3 -SETWIDTH/2-15, setHeight+30, 31, 27) imgStr:@"Icon_Friends.png" bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(SETWIDTH *3 -SETWIDTH/2-28,setHeight+20, SETWIDTH,  SETWIDTH) textColor:UIColorWithRGB(76, 95, 112, 1) labText:@"邀请好友" setFont:14];
    [self setTheLab:CGRectMake(SETWIDTH *3 -SETWIDTH/2-43, setHeight+SETWIDTH-30, SETWIDTH, 30) textColor:UIColorWithRGB(248, 133, 53, 1) labText:@"送体验金不封顶" setFont:12];
    //
    if (iPhoneHeight>480) {
        UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/2-70, iPhoneHeight-160, 150, 30)];
        endLabel.text = @"更多精彩 稍后送上";
        endLabel.textAlignment = NSTextAlignmentCenter;
        endLabel.textColor = UIColorWithRGB(169, 169, 169, 1);
        [_mainScrollView addSubview:endLabel];
    }else{
    
        UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/2-70, iPhoneHeight-75, 150, 30)];
        endLabel.text = @"更多精彩 稍后送上";
        endLabel.textAlignment = NSTextAlignmentCenter;
        endLabel.textColor = UIColorWithRGB(169, 169, 169, 1);
        [_mainScrollView addSubview:endLabel];

        
    }
    
    
    _mainScrollView.contentSize = CGSizeMake(iPhoneWidth, setHeight + 150);
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
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, sizeY - 1, iPhoneWidth , 1)];
   
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.6;
    //    imgView.backgroundColor = [UIColor redColor];
    [_mainScrollView addSubview:imgView];

}


//TODO: 获取网络数据
- (void)getHttpData{
//    _page = 1;
//    [self reqShopList:_page];
    
}

//TODO: 登录
- (void)getLoginPressed{
    app.isInfo = NO;

    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            //  随时赚
        case 10000:
        {
            AnyTimeBuyViewController *anyTimeBuyViewController = [[AnyTimeBuyViewController alloc] init];
            [self.navigationController pushViewController:anyTimeBuyViewController animated:YES];
        }
            break;
            //  随心兑
        case 10001:
        {
            ShopViewController *shopViewController = [[ShopViewController alloc] init];
            [self.navigationController pushViewController:shopViewController animated:YES];
        }
            break;
            // 签到
        case 10002:
        {
//            [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
//            [self showProgressWithString:@"即将开通,敬请期待!" hiddenAfterDelay:2];
            
            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                LoginViewController *loginv = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginv animated:YES];
                return ;
            }
            SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
            signUpViewController.signUpStyle = SignIng;
            [self.navigationController pushViewController:signUpViewController animated:YES];


        }
            break;
            //  抽疯
        case 10003:
        {
            SnatchViewController * snatchViewController = [[SnatchViewController alloc]init];
            
                        [self.navigationController pushViewController: snatchViewController animated:YES];
        }
            break;

            //  完善资料
        case 10004:
        {
            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                LoginViewController *loginv = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginv animated:YES];
                return;
            }
            
            ModifyDataViewController *modifyDataViewController = [[ModifyDataViewController alloc] init];
            [self.navigationController pushViewController:modifyDataViewController animated:YES];

        }
            break;
            //  首次充值
        case 10005:
        {
            [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                LoginViewController *loginv = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginv animated:YES];
                return;
            }
            // 跳转充值
//            BankListViewController *controller = [[BankListViewController alloc] init];
//            controller.bankStyle = BankWithPay;
//            [self.navigationController pushViewController:controller animated:YES];
            RechargeableViewController *controller = [[RechargeableViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            //  邀请好友
        case 10006:
        {
            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                LoginViewController *loginv = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginv animated:YES];
                return;
            }
//            [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];

//            [self showShareView];
            PublicWebViewController *webController = [[PublicWebViewController alloc] init];
            webController.isSnatch = NO;
            webController.webStyle = WebWithShare;
            NSString *webs = [NSString stringWithFormat:@"%@Index/invite/uid/%ld",SERVER_URL,(long)[UserDataManager sharedUserDataManager].userData.UID];
            webController.webUrl = webs;
            webController.webName = @"分享好友";
            [self.navigationController pushViewController:webController animated:YES];

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
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:                                                     NO];
}

//TODO:登录成功
- (void)loginFinished{
    if (app.isInfo) {
        [[self rdv_tabBarController] setTheViewController:2];
        
    }
}

//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_DID_LOG_IN object:nil];
    
}



- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}

@end
