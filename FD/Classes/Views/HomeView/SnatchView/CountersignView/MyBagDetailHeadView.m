//
//  MyBagDetailHeadView.m
//  MyBagDetailHeadView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "MyBagDetailHeadView.h"
#import "FontDefine.h"

@interface MyBagDetailHeadView()

@end

@implementation MyBagDetailHeadView
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

//TODO:是否传入
- (void)setIsJoin:(BOOL)isJoin{
    _isJoin = isJoin;
    
}

//TODO:是否取消
- (void)setIsCancel:(BOOL)isCancel{
    _isCancel = isCancel;
    
}

//TOOD:传入数据
- (void)setDataDic:(NSDictionary *)dataDic{
    if (_dataDic == dataDic) {
        return;
    }
    _dataDic = dataDic;
    
 
    if (_isJoin){
        _headImgView.hidden = NO;
        _goodsfLab.hidden = NO;
        _myconLab.hidden = YES;
        _bgImgView.frame = CGRectMake(0, 0, iPhoneWidth, 150 );
        [_bgImgView setImage:[UIImage imageNamed:@"MyCounter_bgImage.png"]];
        _bgImgView.backgroundColor = [UIColor clearColor];
        // 4S
        if (iPhoneWidth==320 && iPhoneHeight <500) {
            
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
            _bgImgView.frame = CGRectMake(0, -10 ,320, 150);
            
            
        }
        // 5/5S
        if (iPhoneWidth == 320 && iPhoneHeight >500) {
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
            _bgImgView.frame = CGRectMake(0, -90 ,320, 221);
            
            
        }
        // 6/6s
        if (iPhoneWidth == 375) {
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_375.png"];
            _bgImgView.frame = CGRectMake(0, -110 , 375, 259);
            
        }
        // 6P/6SP
        
        if (iPhoneWidth == 414) {
            _bgImgView.frame = CGRectMake(0, -140 , 414, 286);
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_414.png"];
            
        }
        
        _headImgView.frame = CGRectMake((iPhoneWidth - 90) / 2, 80  , 90, 90 );
        _nameLab.frame = CGRectMake(15, 170, iPhoneWidth - 30, 25);
        _conLab.frame = CGRectMake(15, 185, iPhoneWidth - 30, 40);
        _footView.frame = CGRectMake(0, 225, iPhoneWidth, 140);

        
    }else{
       
        _myconLab.hidden = NO;
        _nameLab.hidden = YES;
        _headImgView.hidden = YES;
        _goodsfLab.hidden = NO;
        _bgImgView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
        [_bgImgView setImage:nil];
        
        _bgImgView.frame = CGRectMake(0, 0, iPhoneWidth, 280 );
       
        
        _myconLab.frame = CGRectMake(15, 40, iPhoneWidth - 30, 50);
        
        _conLab.frame = CGRectMake(15, 80, iPhoneWidth - 30, 40);
        _conLab.textColor = UIColorWithRGB(247, 165, 150, 1);
        _footView.frame = CGRectMake(0, 160, iPhoneWidth, 140);
        NSInteger kind = [[_dataDic objectForKey:@"kind"] integerValue];
        //                 kind = 1; 1 福利抢宝  2 群抢宝 3 心愿单
        
        switch (kind) {
            case 1:
                _myconLab.text = [NSString stringWithFormat:@"福利抢宝,共%@人次",[_dataDic objectForKey:@"price"]];
                
                break;
            case 2:
                _myconLab.text = [NSString stringWithFormat:@"群抢宝,共%@人次",[_dataDic objectForKey:@"price"]];
                
                break;
            case 3:
                _myconLab.text = [NSString stringWithFormat:@"心愿单,共%@人次",[_dataDic objectForKey:@"price"]];
                
                break;
            default:
                break;
        }
    }
    _conLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"remark"]];
    NSString *name = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"nickname"]];
    if ([name isEqualToString:@"<null>"]) {
        name = [_dataDic objectForKey:@"mobile"];
        
    }
    _nameLab.text = [NSString stringWithFormat:@"%@",name];
    _goodsLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"title"]];
    _goodsfLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"sub_title"]];
    _joinLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"progress"]];
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"list_noImg.png"]];
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];

    _goodsfLab.text = [_dataDic objectForKey:@"sub_title"];

    NSInteger less = [[_dataDic objectForKey:@"price"] integerValue] - [[_dataDic objectForKey:@"progress"] integerValue];
    _remainLab.text = [NSString stringWithFormat:@"%ld",(long)less];
    float  presss =  [[_dataDic objectForKey:@"progress"] floatValue] / [[_dataDic objectForKey:@"price"] floatValue];
    [_progressView setProgress:presss];
    
    _addPayBtn.hidden = YES;
 
    switch (_counStyle) {
            // 福利抢宝
        case WelfareCoun:
        {
            _footshowConLab.hidden = YES;
            _countdownLab.hidden = YES;
            _footConLab.hidden = NO;

            if (_isCancel){
                if (_isJoin) {
                    _footConLab.text = @"本次抢宝由于24小时内未达到指定参与人次，系统自动取消本次抢宝！";
                }else{
                    _footConLab.text = @"本次抢宝由于24小时内未达到指定参与人次，系统自动取消本次抢宝，商品金额退回您的爱葫芦账户中，详见账户明细！";
                    
                }
                _footImgView.frame = CGRectMake(0, _footImgView.frame.origin.y, iPhoneWidth, 60);
                _footConLab.frame = CGRectMake(10, 0, iPhoneWidth- 20, 60);
                
                
            }else
            {
                _footConLab.text = [NSString stringWithFormat:@"共%@/%@个参与人次",[_dataDic objectForKey:@"progress"],[_dataDic objectForKey:@"price"]];
      

            }
        }
            break;
            // 群抢宝
        case GroupCoun:
        {
            

            _footshowConLab.hidden = YES;
            _countdownLab.hidden = YES;
            _footConLab.hidden = NO;
            _addPayBtn.hidden = NO;
            _footConLab.text = [NSString stringWithFormat:@"共%@/%@个参与人次",[_dataDic objectForKey:@"progress"],[_dataDic objectForKey:@"price"]];
            if (_isCancel){
                if (_isJoin) {
                    _footConLab.text = @"本次抢宝由于24小时内未达到指定参与人次，系统自动取消本次抢宝！";
                }else{
                    _footConLab.text = @"本次抢宝由于24小时内未达到指定参与人次，系统自动取消本次抢宝，商品金额退回您的爱葫芦账户中，详见账户明细！";
                    
                }
                _footImgView.frame = CGRectMake(0, _footImgView.frame.origin.y, iPhoneWidth, 60);
                _footConLab.frame = CGRectMake(10, 0, iPhoneWidth- 20, 60);
                _addPayBtn.hidden = YES;
            }

            float waiting = [[_dataDic objectForKey:@"waiting"] floatValue];
//            if (waiting > 0) {
//                countDown = waiting;
//                _footConLab.hidden = NO;
//
//                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
//                
//            }else{
//                _footConLab.hidden = YES;
//                _countdownLab.text = @"获取开奖号码中...";
//                _addPayBtn.hidden = YES;
//
//            }
        }
            break;
        default:
            break;
    }
    


}

//TODO:初始化数据
- (void)creat{
    timeStart = YES;

    // 图片
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 150 )];
    [self addSubview:_bgImgView];
    [_bgImgView setImage:[UIImage imageNamed:@"MyCounter_bgImage.png"]];
    

    
    // 头像
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 90) / 2, 80  , 90, 90 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    [_headImgView setImage:[UIImage imageNamed:@"Home_head_big.png"]];
    
    _headImgView.layer.cornerRadius = 45;
    _headImgView.layer.masksToBounds = YES;

    // 昵称
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, iPhoneWidth - 30, 25)];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:20];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.textColor = UIColorWithRGB(0, 0, 0, 1);
    [self addSubview:_nameLab];
    
    //我发起说明
    _myconLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, iPhoneWidth - 30, 50)];
    _myconLab.backgroundColor = [UIColor clearColor];
    _myconLab.font = [UIFont systemFontOfSize:25];
    _myconLab.textAlignment = NSTextAlignmentCenter;
    _myconLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [self addSubview:_myconLab];
    
    
    // 说明
    _conLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 105, iPhoneWidth - 60, 40)];
    _conLab.backgroundColor = [UIColor clearColor];
    _conLab.font = [UIFont systemFontOfSize:15];
    _conLab.textAlignment = NSTextAlignmentCenter;
    _conLab.numberOfLines = 0;
    _conLab.textColor = UIColorWithRGB(179, 181, 181, 1);
    [self addSubview:_conLab];
    

    // 底部界面
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 235, iPhoneWidth, 120)];
    _footView.backgroundColor = [UIColor clearColor];
    [self addSubview:_footView];
    
    // 商品
    UIImageView *footBGImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, iPhoneWidth - 10, 100 )];
    footBGImgView.backgroundColor = [UIColor whiteColor];
    [_footView addSubview:footBGImgView];
    
    // 商品
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15  , 70, 60 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    [_footView addSubview:_goodsImgView];

    // 商品说明
    _goodsLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, iPhoneWidth - 130, 30)];
    _goodsLab.backgroundColor = [UIColor clearColor];
    _goodsLab.font = [UIFont systemFontOfSize:15];
    _goodsLab.textAlignment = NSTextAlignmentLeft;

//    _goodsLab.numberOfLines = 0;
    _goodsLab.textColor = UIColorWithRGB(234, 97, 84, 1);
    [_footView addSubview:_goodsLab];
    
    // 商品说明
    _goodsfLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, iPhoneWidth - 130, 30)];
    _goodsfLab.backgroundColor = [UIColor clearColor];
    _goodsfLab.font = [UIFont systemFontOfSize:13];
    _goodsfLab.textAlignment = NSTextAlignmentLeft;
//    _goodsfLab.numberOfLines = 0;
    _goodsfLab.textColor = UIColorWithRGB(75, 75, 75, 1);
   [_footView addSubview:_goodsfLab];
    
    
    
    // 进度条
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(90, 60 , iPhoneWidth -100 , 10)];
    _progressView.backgroundColor = [UIColor clearColor];
    //更改进度条高度
    _progressView.transform = CGAffineTransformMakeScale(1.0f,3.5f);
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = 5;
    _progressView.trackTintColor = UIColorWithRGB(238, 238, 239, 1);
    [_progressView setTintColor:UIColorWithRGB(235, 97, 84, 1)];
    [_footView addSubview:_progressView];
    [_progressView setProgress:0.3];
    
    // 已经参与
    _joinLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 65 , 100, 15)];
    _joinLab.backgroundColor = [UIColor clearColor];
    _joinLab.font = [UIFont systemFontOfSize:13];
    _joinLab.textAlignment = NSTextAlignmentLeft;
    _joinLab.textColor = UIColorWithRGB(0, 0, 0, 1);
    [_footView addSubview: _joinLab];
    
    // 剩余
    _remainLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 90, 65 , 80, 15)];
    _remainLab.backgroundColor = [UIColor clearColor];
    _remainLab.font = [UIFont systemFontOfSize:13];
    _remainLab.textAlignment = NSTextAlignmentRight;
    _remainLab.textColor = UIColorWithRGB(0, 0, 0, 1);
    [_footView addSubview: _remainLab];

    [self setTheLab:CGRectMake(90, 80 , 100, 15) textColor:UIColorWithRGB(90, 92, 92, 1) labText:@"已参与人次" setFont:11 setCen:NO];
    
    [self setTheLab:CGRectMake(iPhoneWidth - 90, 80 , 80, 15) textColor:UIColorWithRGB(90, 92, 92, 1) labText:@"剩余人次" setFont:11 setCen:YES];
    
    // 显示详情
   _showBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 0  , iPhoneWidth - 10, 100 )];
    _showBtn.backgroundColor = [UIColor clearColor];
    [_footView addSubview:_showBtn];
    [_showBtn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    _footImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110  , iPhoneWidth , 30 )];
    _footImgView.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    [_footView addSubview:_footImgView];
    
    //
    _footshowConLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, iPhoneWidth - 30, 30)];
    _footshowConLab.backgroundColor = [UIColor clearColor];
    _footshowConLab.font = [UIFont systemFontOfSize:15];
    _footshowConLab.textAlignment = NSTextAlignmentLeft;
    _footshowConLab.textColor = UIColorWithRGB(156, 157, 158, 1);
    _footshowConLab.text = @"关闭时间:";
    _footshowConLab.numberOfLines = 0;
    [_footImgView addSubview:_footshowConLab];
    
    // 倒计时
    _countdownLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 73, iPhoneWidth - 220, 25)];
    _countdownLab.backgroundColor = [UIColor clearColor];
    _countdownLab.font = [UIFont systemFontOfSize:12];
    _countdownLab.textAlignment = NSTextAlignmentLeft;
    _countdownLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [_footView addSubview:_countdownLab];
    
    //
    _footConLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, iPhoneWidth - 30, 30)];
    _footConLab.backgroundColor = [UIColor clearColor];
    _footConLab.font = [UIFont systemFontOfSize:15];
    _footConLab.textAlignment = NSTextAlignmentLeft;
    _footConLab.textColor = UIColorWithRGB(156, 157, 158, 1);
    _footConLab.numberOfLines = 0;
    [_footImgView addSubview:_footConLab];
    
    // 群抢宝 立即参与
    _addPayBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 90, 112  , 80, 26 )];
    _addPayBtn.backgroundColor = UIColorWithRGB(240, 94, 75, 1);
//    _addPayBtn.backgroundColor = [UIColor clearColor];
    [_addPayBtn setTitle:@"立即参与" forState:UIControlStateNormal];
    _addPayBtn.titleLabel.textColor = [UIColor clearColor];
    _addPayBtn.titleLabel.font = defaultFontSize(16);
    [_footView addSubview:_addPayBtn];
    [_addPayBtn addTarget:self action:@selector(addPayBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_addPayBtn.layer setMasksToBounds:YES];
    [_addPayBtn.layer setCornerRadius:2];
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
    [_footView addSubview:lab];
}


//TODO:倒计时
- (void)timerFireMethod:(NSTimer *)theTimer
{
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间...
    NSDate *today = [NSDate date];    //得到当前时间
    
    NSDate *date = [NSDate dateWithTimeInterval:countDown sinceDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    static int year;
    static int month;
    static int day;
    static int hour;
    static int minute;
    static int second;
    if(timeStart) {//从NSDate中取出年月日，时分秒，但是只能取一次
        year = [[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[dateString substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[dateString substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[dateString substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStart= NO;
    }
    
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    NSDate *todate = [cal dateFromComponents:endTime]; //把目标时间装载入date
    
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    NSString *xshi = [NSString stringWithFormat:@"%ld", (long)[d hour]];
    if([d hour] < 10) {
        xshi = [NSString stringWithFormat:@"0%ld",(long)[d hour]];
    }
    
    NSString *fen = [NSString stringWithFormat:@"%ld", (long)[d minute]];
    if([d minute] < 10) {
        fen = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%ld", (long)[d second]];
    if([d second] < 10) {
        miao = [NSString stringWithFormat:@"0%ld",(long)[d second]];
    }
    
    if([d second] > 0) {
        
        //计时尚未结束，do_something
        
    } else if([d second] == 0) {
        
        //计时1分钟结束，do_something
        
    } else{
        //揭晓抽奖
        [self publishDrawPrssed];
        [_timer invalidate];
        //        [theTimer invalidate];
    }
    
    NSString *timeStr =[NSString stringWithFormat:@"%@时:%@分:%@秒",xshi,fen,miao];
    _countdownLab.text = timeStr;
}

//TODO:揭晓抽奖
- (void)publishDrawPrssed
{
    if (_delegate && [_delegate respondsToSelector:@selector(publishDraw)]) {
        [_delegate publishDraw];
    }
}

//TODO:显示详情
- (void)showDetail:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(showGoodsDetailPressed)]) {
        [_delegate showGoodsDetailPressed];
    }
}

//TODO:立即参与
-(void)addPayBtnPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(payNowPressed)]) {
        [_delegate payNowPressed];
    }
}

@end
