//
//  GoodsDetilView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "GoodsDetilView.h"
#import "FontDefine.h"
#import "SkuNode.h"

#define SETFOOTHIGH         65  // 底部高度

#define MENUHEIHT 40

@implementation GoodsDetilView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//TODO:传入数据
- (void)setDnode:(GoodsDetailNode *)dnode{
   
    _dnode = dnode;
    [self commHeadInit];

}

//TODO:初始化数组
-(void)commHeadInit{
    _isShowKeyP  = NO;

    // 关闭界面
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight - 300)];
    cancelBtn.backgroundColor = [UIColor clearColor];
//    cancelBtn.alpha = 0.3;
    [cancelBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1000;
    [self addSubview:cancelBtn];
    // 判断是实物还是虚拟商品
    float  setY;
    if (_dnode.sku.count > 0) {
        setY = iPhoneHeight - 350;
        [self setTheImg:CGRectMake(0, setY, iPhoneWidth, 350) imgStr:@"" bgColor:[UIColor whiteColor]];


    }else{
        setY = iPhoneHeight - 300;
        [self setTheImg:CGRectMake(0, setY, iPhoneWidth, 350) imgStr:@"" bgColor:[UIColor whiteColor]];

    }
    
    
    // 图片
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setY + 10, 90, 70)];
    headImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headImageView];
    headImageView.layer.masksToBounds=YES;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_dnode.thumb] placeholderImage:[UIImage imageNamed:@"Public_list_noImg.png"]];
    
    // 标题
    [self setTheLab:CGRectMake(110, setY , iPhoneWidth - 150, 50) textColor:[UIColor blackColor] labText:_dnode.name setFont:17 setCen:NO];
    // 说明
    [self setTheLab:CGRectMake(110, setY + 50 , iPhoneWidth - 150, 50) textColor:[UIColor grayColor] labText:_dnode.desc setFont:15 setCen:NO];
    // 状态
//    [self setTheImg:CGRectMake(100, setY + 66, 80, 24) imgStr:@"" bgColor:[UIColor greenColor]];
//    [self setTheImg:CGRectMake(iPhoneWidth - 40, setY + 36, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
    
    setY = setY + 90;
    
    [self setTheImg:CGRectMake(0, setY , iPhoneWidth, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(238, 238, 238, 1)];
    if (_dnode.sku.count > 0) {
        // 属性
        [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"属性" setFont:17 setCen:NO];
        _btnScrollView = [[SkuBtnScrollView alloc] init];
        _btnScrollView.frame = CGRectMake(70, setY+3, iPhoneWidth - 90 , 44);
        _btnScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_btnScrollView];
        _btnScrollView.btnDelegate = self;
        _btnScrollView.nameArray = _dnode.sku;
        _btnScrollView.varTag = 1;
        _btnScrollView.nowSelectTag = 0;
        [_btnScrollView initWithNameButtons];

        setY = setY + 50;
        
        [self setTheImg:CGRectMake(13, setY , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(238, 238, 238, 1)];

    }
    
    // 任务奖励
    [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"兑换价格" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(78, setY  , 120, 50) textColor:[UIColor grayColor] labText:@"（葫芦币）" setFont:13 setCen:NO];
    
    _piceLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 140 , setY  , 120, 50)];
    _piceLab.backgroundColor = [UIColor clearColor];
    _piceLab.text = _dnode.price;
    _piceLab.textColor = UIColorWithRGB(251, 89, 0, 1);
    _piceLab.textAlignment = NSTextAlignmentRight;
    _piceLab.font = [UIFont systemFontOfSize:17];
    [self addSubview:_piceLab];
    
    setY = setY + 50;

    [self setTheImg:CGRectMake(13, setY , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(238, 238, 238, 1)];
    
    // 保证金
    [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"可用余额" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(78, setY  , 120, 50) textColor:[UIColor grayColor] labText:@"（葫芦币）" setFont:13 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 140 , setY  , 120, 50) textColor:UIColorWithRGB(251, 89, 0, 1) labText:[UserDataManager sharedUserDataManager].userData.Utotal_Free  setFont:17 setCen:YES];
    setY = setY + 50;

    [self setTheImg:CGRectMake(13, setY , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(238, 238, 238, 1)];
    NSInteger is_virtual = [_dnode.is_virtual integerValue];
    switch (is_virtual) {
            // 实物
        case 0:
        {
            // 收货地址
            [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"收货地址" setFont:17 setCen:NO];
            
            _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setY, iPhoneWidth - 120, 50)];
            _addressLab.backgroundColor = [UIColor clearColor];
            _addressLab.text = @"请选择";
            _addressLab.textColor = UIColorWithRGB(251, 89, 0, 1);
            _addressLab.textAlignment = NSTextAlignmentRight;
            _addressLab.numberOfLines = 0;
            _addressLab.font = [UIFont systemFontOfSize:15];
            [self addSubview:_addressLab];
            
            _addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , setY , iPhoneWidth, 50)];
            _addressBtn.backgroundColor = [UIColor clearColor];
            [_addressBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            _addressBtn.tag = 1002;
            [self addSubview:_addressBtn];

        }
            break;
            // 话费
        case 1:
        {
            // 手机号
            [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"手机号" setFont:17 setCen:NO];
            
            _pTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setY, iPhoneWidth - 106, 50)];
            _pTextField.backgroundColor = [UIColor clearColor];
            _pTextField.font = defaultFontSize(13);
            [self addSubview:_pTextField];
            _pTextField.delegate = self;
            _pTextField.textAlignment = NSTextAlignmentRight;
            _pTextField.placeholder = @"请输入手机号";

        }
            break;
            // Q币
        case 2:
        {
           
            // QQ号
            [self setTheLab:CGRectMake(13, setY  , 120, 50) textColor:[UIColor blackColor] labText:@"QQ" setFont:17 setCen:NO];
            
            _pTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setY, iPhoneWidth - 106, 50)];
            _pTextField.backgroundColor = [UIColor clearColor];
            _pTextField.font = defaultFontSize(13);
            _pTextField.placeholder = @"请输入QQ号";
            [self addSubview:_pTextField];
            _pTextField.delegate = self;
            _pTextField.textAlignment = NSTextAlignmentRight;
        }
            break;
        default:
            break;
    }
    
    setY = setY + 50;
    
//    [self setTheImg:CGRectMake(13, setY , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:[UIColor grayColor]];

    float bzj = [[_dnode.price stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
    float ye = [[[UserDataManager sharedUserDataManager].userData.Utotal_Free stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];

    UIButton *tasBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , iPhoneHeight - SETFOOTHIGH , iPhoneWidth, SETFOOTHIGH)];
    tasBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [tasBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    tasBtn.tag = 1001;
    tasBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [tasBtn setTitle:@"确定兑换" forState:UIControlStateNormal];

    [self addSubview:tasBtn];
    
    if (bzj > ye) {
        [tasBtn setTitle:@"余额不足,请充值" forState:UIControlStateNormal];
        [tasBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tasBtn.backgroundColor = [UIColor grayColor];
//        tasBtn.userInteractionEnabled = NO;
    }
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

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self addSubview:imgView];
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
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:font];
    [self addSubview:lab];
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
            if (_isShowKeyP) {
                [_pTextField resignFirstResponder];
                _isShowKeyP = NO;
            }else{
                if (_delegate &&[_delegate respondsToSelector:@selector(cancelBuyView)]){
                    [_delegate cancelBuyView];
                }
            }
         
        }
            break;
            // 确定领取任务
        case 1001:{
            if (_delegate &&[_delegate respondsToSelector:@selector(sureBuyView)]){
                [_delegate sureBuyView];
            }
        }
            break;
            // 选择地址
        case 1002:{
            if (_delegate &&[_delegate respondsToSelector:@selector(toAddressView)]){
                [_delegate toAddressView];
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

//TODO:当前选择
- (void)selectBtnTag:(id)sender{
    UIButton *btn =  (UIButton *)sender;
    NSInteger tag = btn.tag - 1;
    SkuNode *node = [_dnode.sku objectAtIndex:tag];
    _piceLab.text = node.price;
    if (_delegate && [_delegate respondsToSelector:@selector(selectSku:)]) {
        [_delegate selectSku:[node.sid integerValue]];
    }
}
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    _isShowKeyP  = NO;
    return YES;
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
    self.frame = CGRectMake(0.0f, -216.0f, self.frame.size.width, self.frame.size.height); //64-216
    
    [UIView commitAnimations];
    _isShowKeyP = YES;
}

#pragma mark -屏幕恢复
-( void )textFieldDidEndEditing:(UITextField *)textField
{
    _isShowKeyP  = NO;
    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height); //64-216
    
    [UIView commitAnimations];
}





@end
