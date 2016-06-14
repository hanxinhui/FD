//
//  ScreenBuyView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ScreenBuyView.h"
#import "FontDefine.h"


#define SETFOOTHIGH         65  // 底部高度

#define MENUHEIHT 40

@implementation ScreenBuyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        
        self.backgroundColor = [UIColor clearColor];
        [self commHeadInit];
        
    }
    return self;
}


//TODO:初始化数组
-(void)commHeadInit{
    
    NSMutableArray *earnings = [NSMutableArray arrayWithObjects:@"全部",@"看图片",@"看视频", nil];
    _earningsArr = [NSMutableArray arrayWithObjects:@"全部",@"看图片",@"看视频", nil];
    
    NSMutableArray *deadline = [NSMutableArray arrayWithObjects:@"全部",@"1-5天",@"6-10天",@"11-20天",@"21-30天",@"30天以上", nil];
    _deadlineArr= [NSMutableArray arrayWithObjects:@"",@"1-5",@"6-10",@"11-20",@"21-30",@"30-0", nil];
    
    selectFirstTag = [[[NSUserDefaults standardUserDefaults] objectForKey:SAVE_ANYTIMEDO_SCREEN_FIRST] integerValue];
    selectSecondTag = [[[NSUserDefaults standardUserDefaults] objectForKey:SAVE_ANYTIMEDO_SCREEN_SECOND] integerValue];
    
    UIButton *hiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    hiddenBtn.backgroundColor = [UIColor  clearColor];
//    hiddenBtn.alpha = 0.5;
    [hiddenBtn addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hiddenBtn];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 5, 0, iPhoneWidth/5*4+20, iPhoneHeight)];
    bgImgView.backgroundColor = UIColorWithRGB(236, 240, 243, 1);
    [self addSubview:bgImgView];
    
    _isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:SAVE_ANYTIMEDO_SCREEN_ISYUE];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 5, 0, iPhoneWidth/5*4+20, 70)];
    headImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headImgView];
    

    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 5 + 10, 0 + 30, 50, 30)];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [closeBtn setTitleColor:UIColorWithRGB(139, 141, 144, 1) forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UILabel *chooseLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/2+25, 30, 50, 30)];
    chooseLab.text = @"筛选";
    chooseLab.font = [UIFont systemFontOfSize:20];
    [self addSubview:chooseLab];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth -50, 30, 70, 30)];
    sureBtn.backgroundColor = [UIColor clearColor];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:UIColorWithRGB(139, 141, 144, 1) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    [self setTheLineImg:70];
    
    float setH = 85;
    [self setTheLineImg:85];
    UIImageView *firstImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth/5, setH, iPhoneWidth/5*4+20, 83)];
    firstImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstImgView];
    [self setTheLineImg:setH+83];
    
//   任务类型
    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth / 5 + 10, 90, 80, 30)];
    namelab.backgroundColor = [UIColor whiteColor];
    namelab.text = @"任务类型";
    namelab.textColor = [UIColor blackColor];
    namelab.textAlignment = NSTextAlignmentLeft;
    namelab.font = defaultFontSize(15);
    [self addSubview:namelab];
    
    setH =setH + 30;
    ScreenScrollView *buyScrollView = [[ScreenScrollView alloc] init];
    buyScrollView.isEarn = YES;
    buyScrollView.frame = CGRectMake(iPhoneWidth / 5 , setH, iPhoneWidth/5*4+20, 44);
    buyScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:buyScrollView];
    buyScrollView.btnDelegate = self;
    buyScrollView.nameArray = earnings;
    buyScrollView.varTag = 0;
    buyScrollView.nowSelectTag = [[[NSUserDefaults standardUserDefaults] objectForKey:SAVE_ANYTIMEDO_SCREEN_FIRST] integerValue];
    [buyScrollView initWithNameButtons];
    buyScrollView.frame = CGRectMake(iPhoneWidth / 5, setH, iPhoneWidth - iPhoneWidth / 5+20 , buyScrollView.contentSize.height);
    
    setH = setH + buyScrollView.frame.size.height  + 24;
    
    UIImageView *secondImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth/5, setH, iPhoneWidth/5*4+20, 122)];
    secondImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:secondImgView];
    
    [self setTheLineImg:setH];
// 任务周期
    UILabel *datelab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth / 5 + 10, setH , 80, 44)];
    datelab.backgroundColor = [UIColor clearColor];
    datelab.text = @"任务周期";
    datelab.textColor = [UIColor blackColor];
    datelab.textAlignment = NSTextAlignmentLeft;
    datelab.font = defaultFontSize(15);
    [self addSubview:datelab];
//
    setH = setH+30;
    ScreenScrollView *dataScrollView = [[ScreenScrollView alloc] init];
    dataScrollView.isEarn = YES;
    dataScrollView.frame = CGRectMake(iPhoneWidth / 5, setH+30,iPhoneWidth/5*4+20, 44);
    dataScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:dataScrollView];
    dataScrollView.btnDelegate = self;
    dataScrollView.nameArray = deadline;
    dataScrollView.varTag = 1000;
    dataScrollView.nowSelectTag = [[[NSUserDefaults standardUserDefaults] objectForKey:SAVE_ANYTIMEDO_SCREEN_SECOND] integerValue];
    [dataScrollView initWithNameButtons];
    dataScrollView.frame = CGRectMake(iPhoneWidth / 5 , setH ,iPhoneWidth - iPhoneWidth / 5+20, 100);
    
    [self setTheLineImg:setH+92];
    
    setH = setH + dataScrollView.frame.size.height+5;

    [self setTheLineImg:setH+2];
    UIImageView *thirdImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth/5, setH+2, iPhoneWidth/5*4+20, 82)];
    thirdImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:thirdImgView];
    
    //保证金
    UILabel *canLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/5+10, setH+7 ,80, 30)];
    canLab.text = @"保证金";
    canLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:canLab];
    
//    葫芦币
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/5+70, setH+7, 80, 30)];
    label.text = @"(葫芦币)";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = UIColorWithRGB(60, 63, 63, 1);
    [self addSubview:label];
    
    UILabel *residueLab = [[UILabel alloc]initWithFrame:CGRectMake(iPhoneWidth/5+10, setH+42, 200, 30)];
     residueLab.text = @"只看余额可领取的任务";
    residueLab.textColor = UIColorWithRGB(139, 141, 144, 1);
    residueLab.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:residueLab];
    
    //只看余额
    _delSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(iPhoneWidth - 35, setH+42, 50, 30)];
    BOOL isON = [[NSUserDefaults standardUserDefaults] boolForKey:SAVE_ANYTIMEDO_SCREEN_ISYUE];
    _delSwitch.on = isON;
    [_delSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_delSwitch];
  
    
    [self setTheLineImg:setH+84];
    
    UIButton *clearBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(iPhoneWidth/5*2, setH+95, 160, 40);
    clearBtn.backgroundColor = [UIColor whiteColor];
    [clearBtn setTitle:@"清除选项" forState:UIControlStateNormal];
    [clearBtn setTitleColor:UIColorWithRGB(139, 141, 144, 1) forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(delClosePressed) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn.layer setBorderWidth:1.0f];
    clearBtn.layer.cornerRadius = 5.0f;
    [clearBtn.layer setBorderColor:UIColorWithRGB(160, 162, 162, 0.5).CGColor];
    
    [self addSubview:clearBtn];
}


//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth/5, sizeY - 1, iPhoneWidth/5*4+20, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.7;
    
    [self addSubview:imgView];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:关闭
- (void)closePressed{
    if (_delegate &&[_delegate respondsToSelector:@selector(cancelBuyView)]){
       [_delegate cancelBuyView];
    }
    
   
}

//TODO:清除选项
- (void)delClosePressed{
    
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SAVE_ANYTIMEDO_SCREEN_ISYUE];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:SAVE_ANYTIMEDO_SCREEN_FIRST];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:SAVE_ANYTIMEDO_SCREEN_SECOND];

    if (_delegate &&[_delegate respondsToSelector:@selector(cancelBuyView)]){
        [_delegate cancelBuyView];
    }
}

//TODO:确认
- (void)surePressed{
       if (_delegate &&[_delegate respondsToSelector:@selector(sureBuyView:cycle:isPayYE:)]){
           if (_isOpen){
               [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SAVE_ANYTIMEDO_SCREEN_ISYUE];
 
           }else{
               [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SAVE_ANYTIMEDO_SCREEN_ISYUE];

           }
           [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)selectSecondTag] forKey:SAVE_ANYTIMEDO_SCREEN_SECOND];
           [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)selectFirstTag] forKey:SAVE_ANYTIMEDO_SCREEN_FIRST];

    
           [_delegate sureBuyView:_earningsStr cycle:_deadlineStr isPayYE:_isOpen];
    }
}


//TOOD:选择按钮
- (void)ScreenSelectBtnTag:(NSInteger )tag{

    NSInteger ss = tag / 1000;
    NSInteger sTag = tag;
    
    if (ss > 0) {
        sTag = tag % 1000;
        selectSecondTag = sTag;
        _deadlineStr = [_deadlineArr objectAtIndex:sTag];
      
   
    }else{
        selectFirstTag = sTag;

        _earningsStr = [_earningsArr objectAtIndex:sTag];
        

    }
}

//TODO:手势开关
-(void)switchAction:(id)sender
{

   UISwitch *switchButton = (UISwitch*)sender;
   BOOL isButtonOn = switchButton.isOn;
    
    if (isButtonOn) {
     
        if (_delegate &&[_delegate respondsToSelector:@selector(cancelBuyView)]){
            [_delegate isCanpayYue];
        }

   }else {
       
        _isOpen = NO;
   }
    
}


//TODO:显示动画
- (void)showInView:(UIView *) view
{
 
    
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(view.frame.size.width - self.frame.size.width-20, 0, self.frame.size.width, self.frame.size.height);
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [window.subviews firstObject];
    [topView addSubview:self];
//    [view addSubview:self];
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [[NSNotificationCenter defaultCenter] postNotificationName:ANYTIMEDO_SCREEN_CANCEL object:nil];

                     }];
    
}
@end
