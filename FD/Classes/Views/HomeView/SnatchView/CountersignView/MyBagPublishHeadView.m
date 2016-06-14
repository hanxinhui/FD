
//
//  MyBagPublishHeadView.m
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "MyBagPublishHeadView.h"
#import "FontDefine.h"

@implementation MyBagPublishHeadView

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

//TOOD:传入数据
- (void)setDataDic:(NSDictionary *)dataDic{
    if (_dataDic == dataDic) {
        return;
    }
    _dataDic = dataDic;
    if (_isJoin) {
        self.myConLab.hidden = YES;
        self.headImgView.hidden = NO;
        
        _bgImgView.frame = CGRectMake(0, 0, iPhoneWidth, 150 );
        [_bgImgView setImage:[UIImage imageNamed:@"MyCounter_bgImage.png"]];
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
        
        _bgImgView.backgroundColor = [UIColor clearColor];
        
        _nameLab.frame = CGRectMake(15, 170, iPhoneWidth - 30, 25);
        _conLab.frame = CGRectMake(15, 185, iPhoneWidth - 30, 40);
       
        _footView.frame = CGRectMake(0, 215, iPhoneWidth, 130);

    }else{
        self.myConLab.hidden = NO;
        self.headImgView.hidden = YES;
        self.nameLab.hidden = YES;
        self.goodsLab.hidden = NO;
        
        _bgImgView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
        [_bgImgView setImage:nil];
        
        _bgImgView.frame = CGRectMake(0, 0, iPhoneWidth, 300 );
        
        _myConLab.frame = CGRectMake(15, 40, iPhoneWidth - 30, 50);
        _conLab.frame = CGRectMake(15, 80, iPhoneWidth - 30, 40);
        _conLab.textColor = UIColorWithRGB(247, 165, 150, 1);
        _footView.frame = CGRectMake(0, 180, iPhoneWidth, 120);
        NSInteger kind = [[_dataDic objectForKey:@"kind"] integerValue];
        //                 kind = 1; 1 福利抢宝  2 群抢宝 3 心愿单
        
        switch (kind) {
            case 1:
                _myConLab.text = [NSString stringWithFormat:@"福利抢宝,共%@人次",[_dataDic objectForKey:@"price"]];
                
                break;
            case 2:
                _myConLab.text = [NSString stringWithFormat:@"群抢宝,共%@人次",[_dataDic objectForKey:@"price"]];
                
                break;
            case 3:
                _myConLab.text = [NSString stringWithFormat:@"心愿单,共%@人次",[_dataDic objectForKey:@"price"]];
                
                break;
            default:
                break;
        }
    }
    NSString *name = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"nickname"]];
    if ([name isEqualToString:@"<null>"]) {
        name = [_dataDic objectForKey:@"mobile"];

    }
//    if ([name isEqualToString:@""] || name.length == 0 || name == nil) {
//    }
    _nameLab.text = [NSString stringWithFormat:@"%@",name];
    _conLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"remark"]];
    _goodsLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"title"]];
    _goodsfLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"sub_title"]];
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"list_noImg.png"]];
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];

//    NSString *timeStamp2 = [_dataDic objectForKey:@"whole"];
//    long long int date1 = (long long int)[timeStamp2 intValue];
//    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
//    NSLog(@"时间戳转日期 %@  = %@", timeStamp2, date2);
    _showLab.text = [NSString stringWithFormat:@"共%@个参与人次，%@被抢光",[_dataDic objectForKey:@"price"],[_dataDic objectForKey:@"whole"]];
    float waiting = [[_dataDic objectForKey:@"waiting"] floatValue];
    if (waiting > 0) {
        countDown = waiting;

        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

    }else{
        _countdownLab.text = @"获取开奖号码中...";
    }
    

}
//TODO:初始化数据
- (void)creat{
    
    timeStart = YES;
    
    // 图片
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 150 )];
    _bgImgView.backgroundColor = [UIColor clearColor];
    [_bgImgView setImage:[UIImage imageNamed:@"MyCounter_bgImage.png"]];
    [self addSubview:_bgImgView];
    
    // 头像
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 80) / 2, 90  , 80, 80 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
   [_headImgView setImage:[UIImage imageNamed:@"Home_head_big.png"]];
    _headImgView.layer.cornerRadius = 40;
    _headImgView.layer.masksToBounds = YES;
    // 昵称
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 190, iPhoneWidth - 50, 30)];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:25];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.textColor = UIColorWithRGB(0, 0, 0, 1);
    [self addSubview:_nameLab];
    
    // 我发起的说明
    _myConLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, iPhoneWidth - 30, 50)];
    _myConLab.backgroundColor = [UIColor clearColor];
    _myConLab.font = [UIFont systemFontOfSize:25];
    _myConLab.textAlignment = NSTextAlignmentCenter;
    _myConLab.textColor = UIColorWithRGB(255, 255,255, 1);
    [self addSubview:_myConLab];
    
    
    // 说明
    _conLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, iPhoneWidth - 60, 20)];
    _conLab.backgroundColor = [UIColor clearColor];
    _conLab.font = [UIFont systemFontOfSize:13];
    _conLab.textAlignment = NSTextAlignmentCenter;
    _conLab.numberOfLines = 0;
    _conLab.textColor = UIColorWithRGB(179, 180, 181, 1);
    [self addSubview:_conLab];
    
    // 底部界面
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 185, iPhoneWidth, 130)];
    _footView.backgroundColor = [UIColor clearColor];
    [self addSubview:_footView];
    
    
    
    
    // 商品
    UIImageView *footBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0  , iPhoneWidth - 10, 100 )];
    footBgImgView.backgroundColor = [UIColor whiteColor];
    [_footView addSubview:footBgImgView];
    
    // 商品
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10  , 60, 50 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    [_footView addSubview:_goodsImgView];
    
    // 商品说明
    _goodsLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, iPhoneWidth - 110, 35)];
    _goodsLab.backgroundColor = [UIColor clearColor];
    _goodsLab.font = [UIFont systemFontOfSize:15];
    _goodsLab.textAlignment = NSTextAlignmentLeft;
//    _goodsLab.numberOfLines = 0;
    _goodsLab.textColor = UIColorWithRGB(234, 97, 84, 1);
    [_footView addSubview:_goodsLab];
    
    // 商品说明
    _goodsfLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, iPhoneWidth - 110, 35)];
    _goodsfLab.backgroundColor = [UIColor clearColor];
    _goodsfLab.font = [UIFont systemFontOfSize:13];
    _goodsfLab.textAlignment = NSTextAlignmentLeft;
//    _goodsfLab.numberOfLines = 0;
    _goodsfLab.textColor = UIColorWithRGB(149, 150, 151, 1);
    [_footView addSubview:_goodsfLab];
    
    // 显示详情
    UIButton *showBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth-100, 65, 60 , 25)];
    showBtn.backgroundColor = [UIColor clearColor];
    [_footView addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];

   //揭晓倒计时
    UIImageView *dataImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70  , iPhoneWidth, 35 )];
    dataImgView.backgroundColor = UIColorWithRGB(235, 96, 85, 1);
    [_footView addSubview:dataImgView];

    [self setTheLab:CGRectMake(10, 73, 120, 30) textColor:[UIColor whiteColor] labText:@"揭晓倒计时:" setFont:15 setCen:NO];
    
    // 倒计时
    _countdownLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 73, iPhoneWidth - 200, 30)];
    _countdownLab.backgroundColor = [UIColor clearColor];
    _countdownLab.font = [UIFont systemFontOfSize:15];
    _countdownLab.textAlignment = NSTextAlignmentLeft;
    _countdownLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [_footView addSubview:_countdownLab];
    
    _lookBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth  - 105, 77, 100, 23)];
    _lookBtn.backgroundColor = [UIColor clearColor];
    [_footView addSubview:_lookBtn];
    [_lookBtn setTitle:@"查看计算详情" forState:UIControlStateNormal];
    [_lookBtn setTitleColor:UIColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    _lookBtn.titleLabel.font = defaultFontSize(13);
    [_lookBtn addTarget:self action:@selector(showCountDetailsPressed) forControlEvents:UIControlEventTouchUpInside];
    [_lookBtn.layer setBorderWidth:1.0f];
    [_lookBtn.layer setBorderColor:UIColorWithRGB(240, 240, 240, 0.5).CGColor];

    // 商品
    UIImageView *fgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 105  , iPhoneWidth , 35 )];
    fgImgView.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    [_footView addSubview:fgImgView];
    
    //
    _showLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, iPhoneWidth - 40, 25)];
    _showLab.backgroundColor = [UIColor clearColor];
    _showLab.font = [UIFont systemFontOfSize:15];
    _showLab.textAlignment = NSTextAlignmentLeft;
    _showLab.textColor = UIColorWithRGB(158, 159, 160, 1);
    [_footView addSubview:_showLab];
    
    
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



//TODO:显示详情
- (void)showDetail:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(showGoodsDetailPressed)]) {
        [_delegate showGoodsDetailPressed];
    }
}

//TODO:显示中奖计算详情
- (void)showCountDetailsPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(showCountDetails)]) {
        [_delegate showCountDetails];
    }
}
//TODO:揭晓抽奖
- (void)publishDrawPrssed
{
    if (_delegate && [_delegate respondsToSelector:@selector(publishDraw)]) {
        [_delegate publishDraw];
    }
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
    
    NSString *timeStr =[NSString stringWithFormat:@"%@:%@:%@",xshi,fen,miao];
    _countdownLab.text = timeStr;
}

@end
