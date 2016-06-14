//
//  BaseViewController.m
//  FD
//
//  Created by leo xu on 14-10-16.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import "BaseViewController.h"
#import "SDImageCache.h"
#import "AppDelegate.h"

//hud size
#define HUD_SIZE CGSizeMake(150, 50)


@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self initTitleLabel];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initTitleLabel];
    }
    return self;
}

-(void)initTitleLabel
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = [UIFont boldSystemFontOfSize:21];
//        _titleLable.textColor = UIColorWithRGB(242, 237, 202, 1);
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)viewDidLoad
{
    if (IOS7) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    float py = (IOS7)?20:0;
    
    //背景图
    _backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _backgroundView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:_backgroundView atIndex:0];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    //标题头
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, py, iPhoneWidth, NVARBAR_HIGHT)];
    _titleLable.frame = CGRectMake(70, 0, iPhoneWidth-140, NVARBAR_HIGHT);
//    _headerView.image = [UIImage imageNamed:@"Public_Top_Bg.png"];
    _headerBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, NVARBAR_HIGHT+py)];
    _headerBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headerBgView];
    _headerView.userInteractionEnabled = YES;
    [self.view addSubview:_headerView];
    _headerView.backgroundColor = UIColorWithRGB(25, 125, 218, 0.8);
    _dlineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _headerView.frame.size.height-1, iPhoneWidth, 1)];
    _dlineImgView.backgroundColor = UIColorWithRGB(230, 230, 231, 1);
    [_headerView addSubview:_dlineImgView];
    
    [_headerView addSubview:_titleLable];
    
    if (IOS7) [self initStatusBar];
    
    
    _progressView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressView];
    self.progressView.minSize = HUD_SIZE;
    [self.view bringSubviewToFront:self.progressView];

    _MSGprogressView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.MSGprogressView];
    self.MSGprogressView.minSize = HUD_SIZE;
    [self.view bringSubviewToFront:self.MSGprogressView];

//    _msgProgressView = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:self.msgProgressView];
//    self.progressView.mode = MBProgressHUDModeText;
//    self.progressView.minSize = HUD_LABEL_SIZE;

    
    _httpManager = [[HTTPManager alloc]init];
    _httpManager.delegate = self;
    
    [self exclusiveTouchContols:self.view];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            subView.exclusiveTouch = YES;
        }
    }
    
}

-(void)dealloc
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

-(void)viewWillAppear:(BOOL)animated
{

}


-(void)exclusiveTouchContols:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            subView.exclusiveTouch = YES;
        }
        else
            [self exclusiveTouchContols:subView];
    }
}




- (void)initStatusBar
{
    _statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 20)];
//    _statusBarView.backgroundColor = _statusColor;
    _statusBarView.backgroundColor = [UIColor clearColor];

    _statusBarView.backgroundColor = UIColorWithRGB(25, 125, 218, 0.8);

    [self.view addSubview:_statusBarView];
}

- (void)setStatusColor:(UIColor *)statusColor
{
    if (statusColor == _statusColor) return;
    _statusColor = statusColor;
    _statusBarView.backgroundColor = _statusColor;
}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return (self.statusLight)?UIStatusBarStyleLightContent:UIStatusBarStyleLightContent;
//}


- (void)setStatusSytle
{
    [[SystemStateManager sharedSystemStateManager] setStatusBarColor:self.statusColor];
    if (_statusLight) {
        [[SystemStateManager sharedSystemStateManager] setstatusBarLight];
    }
    else
        [[SystemStateManager sharedSystemStateManager] setstatusBarDark];
    if ([SystemStateManager sharedSystemStateManager].isIOS7) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}


-(void)setLeftBtn:(UIButton *)leftBtn
{
    if (_leftBtn == leftBtn) return;
    [_leftBtn removeFromSuperview];
    _leftBtn = leftBtn;
    leftBtn.exclusiveTouch = YES;
    leftBtn.frame = CGRectMake(0, (NVARBAR_HIGHT-leftBtn.frame.size.height)/2, leftBtn.frame.size.width, leftBtn.frame.size.height);
    _leftBtn.backgroundColor = [UIColor clearColor];
    [_headerView addSubview:leftBtn];
}

-(void)setRightBtn:(UIButton *)rightBtn
{
    if (_rightBtn == rightBtn) return;
    [_rightBtn removeFromSuperview];
    _rightBtn = rightBtn;
    rightBtn.exclusiveTouch = YES;
    rightBtn.frame = CGRectMake(iPhoneWidth - rightBtn.frame.size.width, (NVARBAR_HIGHT-rightBtn.frame.size.height)/2, rightBtn.frame.size.width, rightBtn.frame.size.height);
    [_headerView addSubview:rightBtn];
}

-(void)setheaderViewFrame:(CGRect)frame
{
    _headerView.frame = frame;
    _leftBtn.frame = CGRectMake(0, (frame.size.height-_leftBtn.frame.size.height)/2, _leftBtn.frame.size.width, _leftBtn.frame.size.height);
    _rightBtn.frame = CGRectMake(iPhoneWidth - _rightBtn.frame.size.width, (frame.size.height-_rightBtn.frame.size.height)/2, _rightBtn.frame.size.width, _rightBtn.frame.size.height);
    _titleLable.frame = CGRectMake(70, 0, iPhoneWidth-140, frame.size.height);
}


-(void)setProgressViewLoadingStyle
{
    self.progressView.mode = MBProgressHUDModeIndeterminate;
    self.progressView.labelText = @"正在加载";
    self.progressView.minSize = HUD_SIZE;
}



//TODO:显示progress
-(void)showProgressWithString:(NSString *)string hiddenAfterDelay:(float)delay
{
    self.MSGprogressView.mode = MBProgressHUDModeText;
    self.MSGprogressView.labelText = string;
    self.MSGprogressView.minSize = HUD_LABEL_SIZE;
    [self.view bringSubviewToFront:self.MSGprogressView];
    [self.view bringSubviewToFront:self.leftBtn];
//    [self.view addSubview:self.MSGprogressView];
    [self.MSGprogressView show:YES];
    [self.MSGprogressView hide:YES afterDelay:delay];
}



//TODO:显示分享
- (void)showShareView{
    NSArray *shareButtonTitleArray = [[NSArray alloc] init];
    NSArray *shareButtonImageNameArray = [[NSArray alloc] init];
    shareButtonTitleArray = @[@"微信好友",@"微信朋友圈",@"短信"];
    shareButtonImageNameArray = @[@"sns_icon_2",@"sns_icon_3",@"sns_icon_4"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享链接" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];

}


@end
