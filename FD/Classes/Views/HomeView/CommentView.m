//
//  CommentView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "CommentView.h"
#import "FontDefine.h"

#define SETFOOTHIGH         65  // 底部高度

#define MENUHEIHT 40

@implementation CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//TODO:初始化数组
-(void)commHeadInit{
    // 关闭界面
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    cancelBtn.backgroundColor = [UIColor clearColor];
//    cancelBtn.alpha = 0.3;
    [cancelBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1000;
    [self addSubview:cancelBtn];
    
    // 初始化评论界面
    _conTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, iPhoneHeight - 150, iPhoneWidth - 20, 100)];
    _conTextView.backgroundColor = [UIColor clearColor];
    [self addSubview:_conTextView];
    _conTextView.font = [UIFont systemFontOfSize:15];//设置字体名字和字体大小
    _conTextView.delegate = self;//设置它的委托方法
    _conTextView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _conTextView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    _conTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _conTextView.scrollEnabled = YES;//是否可以拖动
    _conTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度

    // 提交
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , iPhoneHeight - 50 , iPhoneWidth , 50)];
    sureBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [sureBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.tag = 10001;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:sureBtn];
    

    
}


#pragma mark -
#pragma mark ============ UITextViewDelegate ============
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (_delegate &&[_delegate respondsToSelector:@selector(upViewPressed)]){
        [_delegate upViewPressed];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (_delegate &&[_delegate respondsToSelector:@selector(downViewPressed)]){
        [_delegate downViewPressed];
    }
    return YES;
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 关闭
        case 1000:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(cancelComView)]){
                [_delegate cancelComView];
            }
        }
            break;
            // 确定领取任务
        case 1001:{
            if (_delegate &&[_delegate respondsToSelector:@selector(sureComView)]){
                [_delegate sureComView];
            }
        }
            break;
        default:
            break;
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
