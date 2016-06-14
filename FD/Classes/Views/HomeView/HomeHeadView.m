//
//  HomeHeadView.m
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "HomeHeadView.h"
#import "FontDefine.h"


#define MENUHEIHT 40
#define SETWIDTH        self.frame.size.width / 4

@implementation HomeHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
    [self commHeadInit];
    }
    return self;
}

//TODO:初始化界面
- (void)commHeadInit{
    float seth = 0.0;
    // 背景
    UIImageView *bgImgView = [[UIImageView alloc] init];
    bgImgView.backgroundColor = [UIColor clearColor];
    bgImgView.frame = CGRectMake(0, -50, self.frame.size.width, self.frame.size.height +50);
    [bgImgView setImage:[UIImage imageNamed:@"Home_head_bg.png"]];
    [self addSubview:bgImgView];
    
    seth = seth + 55.0;
    // 登录||用户头像按钮
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneViewWidth - 84 ) / 2, seth, 84, 84)];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    [_headImgView setImage:[UIImage imageNamed:@"Home_head_big.png"]];
//    [_headImgView setClipsToBounds:YES];
    
    _loadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 86, 86)];
    _loadImgView.backgroundColor = [UIColor clearColor];
    [_headImgView addSubview:_loadImgView];
    //    [_homeHeadView.headImgView addSubview:_homeHeadView.loginBtn];
    [_loadImgView setImage:[UIImage imageNamed:@"Home_loading.png"]];
    _loadImgView.hidden = YES;

    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((iPhoneViewWidth - 84 ) / 2, seth, 84, 84)];
    _loginBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_loginBtn];

//    [_loginBtn bringSubviewToFront:_headImgView];
    self.headImgView.layer.masksToBounds=YES;
    self.headImgView.layer.cornerRadius=42.0; //最重要的是这个地方要设
    [_loginBtn addTarget:self action:@selector(setPressed) forControlEvents:UIControlEventTouchUpInside];

    seth = seth + 90;

    // 用户名
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, seth, iPhoneWidth - 40, 40)];
    _userNameLab.backgroundColor = [UIColor clearColor];
    _userNameLab.text = @"立即登录";
    _userNameLab.textAlignment = NSTextAlignmentCenter;
    _userNameLab.font = [UIFont boldSystemFontOfSize:30];
//    _userNameLab.textColor = UIColorWithRGB(254, 249, 57, 1);
    [self addSubview:_userNameLab];
    _userNameLab.textColor = UIColorWithRGB(255, 255, 255, 1);

    seth = seth + 50;

    // 说明
    _conLab = [[UILabel alloc] initWithFrame:CGRectMake((iPhoneWidth - 200)/2, seth, 200, 30)];
    _conLab.backgroundColor = [UIColor clearColor];
    _conLab.text = @"别人教你花钱";
    _conLab.textAlignment = NSTextAlignmentCenter;
    _conLab.font = [UIFont boldSystemFontOfSize:20];
//    _conLab.textColor = UIColorWithRGB(254, 249, 57, 1);
    _conLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [self addSubview:_conLab];
    
    // 说明
    _conpLab = [[UILabel alloc] initWithFrame:CGRectMake((iPhoneWidth - 200)/2, seth + 30, 200, 30)];
    _conpLab.backgroundColor = [UIColor clearColor];
    _conpLab.text = @"我们教你赚钱";
    _conpLab.textAlignment = NSTextAlignmentCenter;
    _conpLab.font = [UIFont boldSystemFontOfSize:20];
//    _conpLab.textColor = UIColorWithRGB(254, 249, 57, 1);
    _conpLab.textColor = UIColorWithRGB(255, 255, 255, 1);

    [self addSubview:_conpLab];
    
    UIImageView *bbgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - SETWIDTH, self.frame.size.width, SETWIDTH)];
    bbgImgView.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    [self addSubview:bbgImgView];
    
    //
//    UIImageView *ashuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SETWIDTH, self.frame.size.height - 82, 1, 56)];
//    ashuImgView.backgroundColor = UIColorWithRGB(228, 228, 228, 0.7);;
//    [self addSubview:ashuImgView];
    
    // 任务列表
    _taskbtn = [[UIButton alloc] initWithFrame:CGRectMake(0  , self.frame.size.height - SETWIDTH, SETWIDTH, SETWIDTH)];
    _taskbtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_taskbtn];
    _taskbtn.backgroundColor = UIColorWithRGB(255, 255, 255, 1);

    [_taskbtn addTarget:self action:@selector(taskPressed) forControlEvents:UIControlEventTouchUpInside];
    [_taskbtn setTitleColor:UIColorWithRGB(76, 95, 112, 1) forState:UIControlStateNormal];
    [_taskbtn setTitle:@"随时赚" forState:UIControlStateNormal];
    [_taskbtn setTitleEdgeInsets:UIEdgeInsetsMake(40.0,0.0, 0.0,0.0)];
    _taskbtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    [self setTheImg:CGRectMake( (SETWIDTH - 31)/2, self.frame.size.height - SETWIDTH+20, 31,27) imgStr:@"Home_head_works.png" bgColor:[UIColor clearColor]];


    
    //签到
    _registerbtn = [[UIButton alloc] initWithFrame:CGRectMake(SETWIDTH  , self.frame.size.height - SETWIDTH, SETWIDTH, SETWIDTH)];
    _registerbtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_registerbtn];
    [_registerbtn addTarget:self action:@selector(registerbtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_registerbtn setTitleColor:UIColorWithRGB(76, 95, 112, 1) forState:UIControlStateNormal];
    [_registerbtn setTitle:@"签到" forState:UIControlStateNormal];
    [_registerbtn setTitleEdgeInsets:UIEdgeInsetsMake(40.0,0.0, 0.0,0.0)];
    _registerbtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    

    [self setTheImg:CGRectMake(SETWIDTH+ (SETWIDTH - 31)/2, self.frame.size.height - SETWIDTH+20, 31,27) imgStr:@"Home_head_register.png" bgColor:[UIColor clearColor]];


   
    // 商品列表
    _laybtn = [[UIButton alloc] initWithFrame:CGRectMake(SETWIDTH * 2-3, self.frame.size.height - SETWIDTH, SETWIDTH, SETWIDTH)];
    _laybtn.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    [self addSubview:_laybtn];
    [_laybtn addTarget:self action:@selector(laybtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_laybtn setTitleColor:UIColorWithRGB(76, 95, 112, 1) forState:UIControlStateNormal];
    [_laybtn setTitle:@"抽疯" forState:UIControlStateNormal];
    [_laybtn setTitleEdgeInsets:UIEdgeInsetsMake(40.0,10.0, 0.0,5.0)];
    _laybtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    [self setTheImg:CGRectMake(SETWIDTH *2 + (SETWIDTH - 31)/2, self.frame.size.height - SETWIDTH+20, 31,27) imgStr:@"Home_head_lays.png" bgColor:[UIColor clearColor]];
    
    // 商品列表
    _goodsbtn = [[UIButton alloc] initWithFrame:CGRectMake(SETWIDTH *3 -1 , self.frame.size.height - SETWIDTH, SETWIDTH, SETWIDTH)];
    
    _goodsbtn.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    [self addSubview:_goodsbtn];
    [_goodsbtn addTarget:self action:@selector(goodsPressed) forControlEvents:UIControlEventTouchUpInside];

    [_goodsbtn setTitleColor:UIColorWithRGB(76, 95, 112, 1) forState:UIControlStateNormal];
    [_goodsbtn setTitle:@"随心兑" forState:UIControlStateNormal];
    [_goodsbtn setTitleEdgeInsets:UIEdgeInsetsMake(40.0,0.0, 0.0,0.0)];
    _goodsbtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    [self setTheImg:CGRectMake(SETWIDTH *3 + (SETWIDTH - 31)/2, self.frame.size.height - SETWIDTH+20, 31,27) imgStr:@"Home_head_moneys.png" bgColor:[UIColor clearColor]];


}

#pragma mark UI初始化
//TODO:任务列表
- (void)taskPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(taskListPressed)]){
        [_delegate taskListPressed];
    }
}

//TODO:签到
-(void)registerbtnPressed{
    
    if (_delegate && [_delegate respondsToSelector:@selector(registerPressed)]){
        [_delegate registerPressed];
    }
}

//TODO:商品列表
- (void)goodsPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(goodsListPressed)]){
    [_delegate goodsListPressed];
    }
}

//TODO:抽奖
- (void)laybtnPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(layPressed)]){
        [_delegate layPressed];
    }
}

//TODO:设置界面
- (void)setPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(toSetPressed)]){
        [_delegate toSetPressed];
    }
}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self addSubview:imgView];
}
@end
