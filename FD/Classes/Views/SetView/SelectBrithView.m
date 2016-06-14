//
//  SelectBrithView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SelectBrithView.h"
#import "FontDefine.h"



@interface SelectBrithView ()

@end
@implementation SelectBrithView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = UIColorWithRGB(242, 246, 247, 1);
        [self commHeadInit];
    }
    return self;
}


//TODO:初始化数组
-(void)commHeadInit{
    // 确定
    UIButton *bgbtn = [[UIButton alloc] initWithFrame:CGRectMake( 0,0,iPhoneWidth,iPhoneHeight)];
    bgbtn.backgroundColor = [UIColor clearColor];
    [bgbtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    bgbtn.tag = 10000;
    [self addSubview:bgbtn];
    
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,iPhoneWidth,250)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minuteInterval = 5;
    NSDate *minDate = [[NSDate alloc] initWithTimeIntervalSince1970:-60*60*24*365*21 - 5*60*60*24];
    NSDate *maxDate = [[NSDate alloc] initWithTimeIntervalSince1970:60*60*24*365*35 + 8*60*60*24];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    //    [ datePicker setDate:maxDate animated:YES];
    [ self addSubview:datePicker];
    [ datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
//    datePicker.backgroundColor = UIColorWithRGB(208, 213, 219, 1);
    datePicker.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,iPhoneHeight - datePicker.frame.size.height - 40,iPhoneWidth,40)];
    imgView.backgroundColor = UIColorWithRGB(242, 246, 247, 1);
    [imgView setImage:[UIImage imageNamed:@""]];
    [self addSubview:imgView];
    
    // 取消
    UIButton *cancelbtn = [[UIButton alloc] initWithFrame:CGRectMake(10.0,iPhoneHeight - datePicker.frame.size.height - 40,50,40)];
    cancelbtn.backgroundColor = [UIColor clearColor];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:UIColorWithRGB(89, 91, 93, 1) forState:UIControlStateNormal];
    cancelbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [cancelbtn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [cancelbtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelbtn.tag = 10001;
    [self addSubview:cancelbtn];
    
    // 确定
    UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 60,iPhoneHeight - datePicker.frame.size.height - 40,50,40)];
    surebtn.backgroundColor = [UIColor clearColor];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    [surebtn setTitleColor:UIColorWithRGB(89, 91, 93, 1) forState:UIControlStateNormal];
    surebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [surebtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [surebtn addTarget:nil action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    surebtn.tag = 10002;
    [self addSubview:surebtn];
    
    datePicker.frame =CGRectMake(0.0,iPhoneHeight - datePicker.frame.size.height,iPhoneWidth,250);
}



//TODO:选择日期
-(void)dateChanged:(id)sender{
    UIDatePicker * control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSLog(@"date is %@",_date);
    /*添加你自己响应代码*/
    
    // 设定格式化格式
    // dd和DD的区别
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    _brithStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:_date]];
    if ([_brithStr hasSuffix:@"12-31"] && ![_brithStr hasPrefix:@"1949"]) {
        NSString *str1 = [_brithStr substringFromIndex:4];
        NSString *str2 = [_brithStr substringToIndex:4];
        NSInteger str3 = [str2 integerValue] - 1;
        _brithStr = [NSString stringWithFormat:@"%ld%@",(long)str3,str1];
    }
//    // 输出
//    NSLog(@"the date formate is: %@",_brithStr);
}


//TODO:点击按钮
- (void)btnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 取消
        case 10000:
        case 10001:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(cancelBrithView)]){
                [_delegate cancelBrithView];
            }
            
        }
            break;
            // 确定
        case 10002:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(sureBrith:)]){
                if (_brithStr == nil || [_brithStr isEqualToString:@""]) {
                    _brithStr = @"2004-12-31";
                }
                [_delegate sureBrith:_brithStr];
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


@end
