//
//  SelectPickerView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SelectPickerView.h"
#import "FontDefine.h"


#define MENUHEIHT 40

@implementation SelectPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = UIColorWithRGB(242, 246, 247, 1);
        _dataArr = [NSMutableArray array];
        
    }
    return self;
}

//TODO:传人数据
- (void)setDataArr:(NSMutableArray *)dataArr{
    if (_dataArr == dataArr) {
        return;
    }
    [_dataArr removeAllObjects];
    _dataArr = nil;
    _dataArr = [NSMutableArray array];

    _dataArr = dataArr;
    
    [self commHeadInit];

}

//TODO:初始化数组
-(void)commHeadInit{
    // 确定
    UIButton *bgbtn = [[UIButton alloc] initWithFrame:CGRectMake( 0,0,iPhoneWidth,iPhoneHeight)];
    bgbtn.backgroundColor = [UIColor clearColor];
    [bgbtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    bgbtn.tag = 10000;
    [self addSubview:bgbtn];
    
    // 初始化选择器
    _selectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 180, self.frame.size.width, 180)];
    _selectPicker.backgroundColor = UIColorWithRGB(208, 213, 219, 1);
    self.selectPicker.dataSource = self;
    self.selectPicker.delegate = self;
    [self addSubview:_selectPicker];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,iPhoneHeight - _selectPicker.frame.size.height - 40,iPhoneWidth,40)];
    imgView.backgroundColor = UIColorWithRGB(242, 246, 247, 1);
    [imgView setImage:[UIImage imageNamed:@""]];
    [self addSubview:imgView];
    
    // 取消
    UIButton *cancelbtn = [[UIButton alloc] initWithFrame:CGRectMake(10.0,iPhoneHeight - _selectPicker.frame.size.height - 40,50,40)];
    cancelbtn.backgroundColor = [UIColor clearColor];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:UIColorWithRGB(89, 91, 93, 1) forState:UIControlStateNormal];
    cancelbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [cancelbtn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [cancelbtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelbtn.tag = 10001;
    [self addSubview:cancelbtn];
    
    // 确定
    UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 60,iPhoneHeight - _selectPicker.frame.size.height - 40,50,40)];
    surebtn.backgroundColor = [UIColor clearColor];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    [surebtn setTitleColor:UIColorWithRGB(89, 91, 93, 1) forState:UIControlStateNormal];
    surebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [surebtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    surebtn.tag = 10002;
    [self addSubview:surebtn];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_dataArr objectAtIndex:row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectData = [NSString stringWithFormat:@"%@",[_dataArr objectAtIndex:row]];
    NSLog(@"_selectData is ====== %@",_selectData);
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

//TODO:点击按钮
- (void)btnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 取消
        case 10000:
        case 10001:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(cancelSelectDataView)]){
                [_delegate cancelSelectDataView];
            }
            
        }
            break;
            // 确定
        case 10002:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(sureSelectStyle:dataStr:)]){
                if ([_selectData isEqualToString:@""] || _selectData.length == 0 || _selectData == nil) {
                    _selectData = [_dataArr  objectAtIndex:0];

                }
                [_delegate sureSelectStyle:self.pickerStyle dataStr:_selectData];
            }
        }
            break;
            
            
        default:
            break;
    }
}
@end
