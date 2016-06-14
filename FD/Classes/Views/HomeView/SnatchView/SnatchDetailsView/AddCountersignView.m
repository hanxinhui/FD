//
//  AddCountersignView.m
//  FD
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "AddCountersignView.h"
#import "FontDefine.h"

@interface AddCountersignView()

@end

@implementation AddCountersignView
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

//TODO:传入数据
- (void)setDNode:(SnatchDetailNode *)dNode{
    if (_dNode == dNode) {
        return;
    }
    _dNode = dNode;
    NSString *showStr = [NSString stringWithFormat:@"参与人次必须是%@的倍数",_dNode.step];
    _showLab.text = showStr;
    _numTextField.text = _dNode.start;
    _showLab.keyWord= _dNode.step;

}
//TODO:初始化数据
- (void)creat{
    _isShowKeyP  = NO;

    // 关闭界面
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight - 200)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    //    cancelBtn.alpha = 0.3;
    [cancelBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 100000;
    [self addSubview:cancelBtn];
    
    float setHeight = iPhoneHeight - 200;

    // 图片
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight , iPhoneWidth, 250)];
    headImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headImageView];
    
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 40) imgStr:@"" bgColor:UIColorWithRGB(241, 242, 243, 1)];
    [self setTheLab:CGRectMake(20, setHeight+5, iPhoneWidth - 50, 35) textColor:UIColorWithRGB(148, 149,150, 1) labText:@"人次期数选择" setFont:13 setCen:NO];
    [self setTheBtn:CGRectMake(iPhoneWidth - 30, setHeight + 15, 10, 10) btnTag:100001 imgStr:@"Public_CloseBtn_B.png"];
    
    setHeight = setHeight + 40;
    
    [self setTheLab:CGRectMake(20, setHeight, iPhoneWidth - 50, 35) textColor:UIColorWithRGB(148, 149, 150, 1) labText:@"参与人次" setFont:14 setCen:NO];
    
    setHeight = setHeight + 35;
    
    
    
    
    UIButton *borderBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, setHeight, 144 +(iPhoneWidth - 320)/2, 38)];
    borderBtn.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    [borderBtn.layer setMasksToBounds:YES];
    [borderBtn.layer setCornerRadius:5.0];
    [borderBtn.layer setBorderWidth:1.0];
    [borderBtn.layer setBorderColor:[UIColorWithRGB(173, 174, 175, 1) CGColor]];
    [self addSubview:borderBtn];
    
    //减少
     [self setTheBtn:CGRectMake(30, setHeight , 42, 36) btnTag:100002 imgStr:@"ShoppingCart_LessBtn.png"];
    
    UIImageView *linImg = [[UIImageView alloc]initWithFrame:CGRectMake(70, setHeight, 1, 38)];
    linImg.backgroundColor = UIColorWithRGB(218, 219, 219, 1);
    [self addSubview:linImg];
    
    // 填写人次
    _numTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, setHeight, 60+ (iPhoneWidth - 320)/ 2, 38)];
    _numTextField.backgroundColor = [UIColor clearColor];
    _numTextField.delegate = self;
    _numTextField.textAlignment = NSTextAlignmentCenter;
    _numTextField.textColor = UIColorWithRGB(204, 35, 67, 1);
    _numTextField.text = @"1";
    _numTextField.font = defaultFontSize(15);
    [self addSubview:_numTextField];
    _numTextField.keyboardType = UIKeyboardTypeNumberPad;
    
  
    UIImageView *lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(135+(iPhoneWidth - 320)/ 2, setHeight, 1, 38)];
    lineImg.backgroundColor = UIColorWithRGB(218, 219, 219, 1);
    [self addSubview:lineImg];
    
    
  //增加
   [self setTheBtn:CGRectMake(135 + (iPhoneWidth - 320)/ 2, setHeight , 42, 38) btnTag:100003 imgStr:@"ShoppingCart_AddBtn.png"];

    setHeight = setHeight + 45;
    
    // 显示内容
    _showLab = [[MMLabel alloc] initWithFrame:CGRectMake(30, setHeight , iPhoneWidth - 60, 30)];
    _showLab.backgroundColor = [UIColor clearColor];
    _showLab.textColor = UIColorWithRGB(204, 35, 67, 1);
    _showLab.textAlignment = NSTextAlignmentLeft;
    _showLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:_showLab];

    setHeight = setHeight + 30;

    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 1) imgStr:@"" bgColor:UIColorWithRGB(236, 238, 238, 1)];
    
    setHeight = setHeight + 10;

    // 夺宝
    UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake(60, setHeight-5, iPhoneWidth - 120, 40)];
    surebtn.backgroundColor = UIColorWithRGB(253, 109, 18, 1);
    [surebtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [surebtn setTitle:@"1元抢宝" forState:UIControlStateNormal];
    [ surebtn.layer setMasksToBounds:YES];
    [ surebtn.layer setCornerRadius:5.0];
    
    surebtn.titleLabel.textColor = [UIColor whiteColor];
    surebtn.tag = 100004;
    [self addSubview:surebtn];
    

   
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
    [self addSubview:lab];
}




//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self addSubview:imgView];
}

//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
    
    
}

//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 关闭
        case 100000:
        case 100001:
        {
            if (_isShowKeyP){
                [self downPView];
            }else {
                if (_delegate &&[_delegate respondsToSelector:@selector(cancelAddView)]){
                    [_delegate cancelAddView];
                }
            }
           
        }
            break;
                // 减少
        case 100002:{
            if (_delegate &&[_delegate respondsToSelector:@selector(lessNumSnatch)]){
                [_delegate lessNumSnatch];
            }
        }
            break;
            // 增加
        case 100003:{
            if (_delegate &&[_delegate respondsToSelector:@selector(addNumSnatch)]){
                
                [_delegate addNumSnatch];
            }
        }
            break;
            // 确认夺宝
        case 100004:{
            if (_delegate &&[_delegate respondsToSelector:@selector(addSnatch:)]){
                [_delegate addSnatch:[_numTextField.text integerValue]];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - 屏幕上弹
-( void )textFieldDidBeginEditing:(UITextField *)textField
{
    //键盘高度216
    
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.frame = CGRectMake(0.0f, -250.0f, self.frame.size.width, self.frame.size.height); //64-216
    
    
    [UIView commitAnimations];
    _isShowKeyP = YES;
    
   
}

#pragma mark -屏幕恢复
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self downPView];
}

//TODO:判断输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"string ==== %@",string);
//    NSLog(@"textField ==== %@",textField.text);
//    NSLog(@"range ==== %lu",(unsigned long)range.length);
    NSString *str;
    if (range.length == 0) {
        str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }else{
        str = [textField.text substringToIndex:textField.text.length - 1];

    }
    NSInteger money = [str integerValue];
    
    if (_dNode.less  < money) {
        if (_delegate &&[_delegate respondsToSelector:@selector(showAlertMsgPressed:)]){
            
            [_delegate showAlertMsgPressed:@"已经超过最大可选数量"];
            _numTextField.text = [NSString stringWithFormat:@"%ld",(long)_dNode.less];
            return NO;

        }
    }
    if (money == 0){
        if (_delegate &&[_delegate respondsToSelector:@selector(showAlertMsgPressed:)]){
            
            [_delegate showAlertMsgPressed:@"可选数量不可为空"];
            _numTextField.text = [NSString stringWithFormat:@"%@",_dNode.step];
            return NO;
        }
        
    }

    
    return YES;
    
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
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width,  self.frame.size.height);
                         
                                                 }
                     completion:^(BOOL finished){

                           [self removeFromSuperview];
                         
                     }];
    
}

//TOOD:界面下移
- (void)downPView{
    _isShowKeyP  = NO;
    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height); //64-216
    
    [UIView commitAnimations];
    [_numTextField resignFirstResponder];
}

@end
