//
//  ScreenGoodsView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ScreenGoodsView.h"
#import "FontDefine.h"

#define SETFOOTHIGH         65  // 底部高度

#define MENUHEIHT 40

@implementation ScreenGoodsView

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
    
    NSMutableArray *firsts = [NSMutableArray arrayWithObjects:@"全部",@"10及以下",@"11-50",@"51-100",@"101-500",@"501及以上", nil];
    _firstArr = [NSMutableArray arrayWithObjects:@"",@"0-10",@"11-50",@"51-100",@"101-500",@"501-0", nil];
    
    UIButton *hiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    hiddenBtn.backgroundColor = [UIColor clearColor];
    hiddenBtn.alpha = 0.1;
    [hiddenBtn addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hiddenBtn];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 5, 0, iPhoneWidth/5*4, iPhoneHeight)];
    bgImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgImgView];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth / 5, 0, iPhoneWidth/5*4, 50)];
    headImgView.backgroundColor = [UIColor colorWithRed:246.00f/255.00f green:247.00f/255.00f blue:248.00f/255.00f alpha:1.0];
    [self addSubview:headImgView];
    
    //
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth / 5 + 10, 0 + 10, 30, 30)];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setImage:[UIImage imageNamed:@"Public_CloseBtn.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth -80, 0 + 10, 50, 30)];
    sureBtn.backgroundColor = [UIColor clearColor];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
    float setH = 65;
    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth / 5 + 10, setH, 100, 44)];
    namelab.backgroundColor = [UIColor clearColor];
    namelab.text = @"收      益:";
    namelab.textColor = [UIColor blackColor];
    namelab.textAlignment = NSTextAlignmentLeft;
    namelab.font = defaultFontSize(15);
    [self addSubview:namelab];
    
    ScreenScrollView *buyScrollView = [[ScreenScrollView alloc] init];
    buyScrollView.isEarn = NO;

    buyScrollView.frame = CGRectMake(iPhoneWidth / 5 + 60, setH, iPhoneWidth - (iPhoneWidth / 5 + 70), 44);
    buyScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:buyScrollView];
    buyScrollView.btnDelegate = self;
    buyScrollView.nameArray = firsts;
    buyScrollView.varTag = 0;
    buyScrollView.nowSelectTag = 0;
    [buyScrollView initWithNameButtons];
    buyScrollView.frame = CGRectMake(iPhoneWidth / 5 + 66, setH, iPhoneWidth - (iPhoneWidth / 5 + 70), buyScrollView.contentSize.height);
    
    setH = setH + buyScrollView.frame.size.height  + 10;
    
   
    
}



#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:关闭
- (void)closePressed{
    if (_delegate &&[_delegate respondsToSelector:@selector(cancelBuyView)]){
        [_delegate cancelBuyView];
    }
}

//TODO:确认
- (void)surePressed{
    if (_delegate &&[_delegate respondsToSelector:@selector(sureBuyView:)]){
        [_delegate sureBuyView:_firstStr];
    }
}


//TOOD:选择按钮
- (void)ScreenSelectBtnTag:(NSInteger )tag{
    
    _firstStr = [_firstArr objectAtIndex:tag];

}


//TODO:显示动画
- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(view.frame.size.width - self.frame.size.width, 70, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width, 70, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}
@end
