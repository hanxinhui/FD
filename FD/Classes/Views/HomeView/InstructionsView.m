//
//  InstructionsView.m
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "InstructionsView.h"
#import "FontDefine.h"


@implementation InstructionsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self commHeadInit];
    }
    return self;
}


//TODO:初始化数组
-(void)commHeadInit{
    // 关闭界面
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.alpha = 0.3;
    [cancelBtn addTarget:self action:@selector(toBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1000;
    [self addSubview:cancelBtn];
    
    float  setY = iPhoneHeight - 150;
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setY, iPhoneWidth, 50)];
    headImgView.backgroundColor = [UIColor colorWithRed:246.00f/255.00f green:247.00f/255.00f blue:248.00f/255.00f alpha:1.0];
    [self addSubview:headImgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, setY, iPhoneWidth, 50)];
    lab.backgroundColor = [UIColor clearColor];
    [self addSubview:lab];
    lab.textColor = [UIColor blackColor];
    lab.text = @"玩法说明";
    lab.font = [UIFont systemFontOfSize:17];
    lab.textAlignment = NSTextAlignmentCenter;
    
    //
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, setY + 10, 30, 30)];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setImage:[UIImage imageNamed:@"Public_CloseBtn.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(toBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    setY  = setY + 50;
    
    _insTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, setY , iPhoneWidth, 100)];
    _insTextView.backgroundColor = [UIColor whiteColor];
    _insTextView.font = [UIFont systemFontOfSize:15];//设置字体名字和字体大小
    _insTextView.delegate = self;//设置它的委托方法
    _insTextView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _insTextView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    _insTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _insTextView.scrollEnabled = YES;//是否可以拖动
    _insTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self addSubview:_insTextView];
    _insTextView.userInteractionEnabled = NO;
    _insTextView.editable = NO;
    
    
}

- (void)setInsInt:(NSInteger)insInt{
    _insInt = insInt;
    switch (_insInt) {
        case 0:
            _insTextView.text = @"   您可以挑选您喜欢的任务参加，在规定的日期内完成任务就可以获得相应的葫芦币奖励！获得的葫芦币可以提现，也可以在随心兑中兑换您需要的商品！";
            break;
        case 1:
            _insTextView.text = @"   您可以参加随时赚任务赚取葫芦币进行兑换，也可以直接充值进行兑换！";
            break;
        default:
            break;
    }
}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:点击按钮
- (void)toBtnPressed{
    if (_delegate &&[_delegate respondsToSelector:@selector(cancelInsView)]){
        [_delegate cancelInsView];
    }
}

//TODO:显示动画
- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
}

//TODO:取消界面
- (void)cancelPicker
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
