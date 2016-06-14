//
//  AddAddressViewController.m
//  FD
//
//  Created by Leo xu on 14-10-21.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import "AddAddressViewController.h"
#import "ShareDataManager.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        _areaValue = areaValue;
    }
}


-(void)initNavBar

{

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.titleLable.text = @"编辑收货人";
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 50);
    leftBtn.backgroundColor = [UIColor blackColor];
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    
    self.titleLable.textColor = [UIColor blackColor];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView =NO;
    [self.view addGestureRecognizer:tapGr];
    

    [self initNavBar];
    [self initView];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    
    

}

//TODO:初始化界面
- (void)initView{
    setHight = 80.0;
    
    // 背景
    [self setBgImgView:CGRectMake(0, 0,iPhoneWidth, iPhoneHeight) imageName:@"myLogin_View_Bg.png"];
    
    // 输入收获人姓名
    [self setBgImgView:CGRectMake(80, setHight, iPhoneWidth - 100, 40) imageName:@"Public_TextField_Bg.png"];
    [self setBgImgView:CGRectMake(34, setHight+15, 21, 21) imageName:@"myLogin_setUser.png"];
    [self setLabel:CGRectMake(10, setHight, 80, 40)  labFont:13 labText:@"收货人:"];
    
    _nameTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setHight, iPhoneWidth - 106, 40)];
    _nameTextField.backgroundColor = [UIColor clearColor];
    _nameTextField.font = defaultFontSize(13);
    [self.view addSubview:_nameTextField];
    _nameTextField.textAlignment = NSTextAlignmentLeft;
    setHight = setHight + 45;
    _nameTextField.delegate = self;
    _nameTextField.textAlignment = NSTextAlignmentLeft;
    [self setTheLineImg:setHight];
    
    // 收获人手机
    [self setLabel:CGRectMake(10, setHight, 80, 40)  labFont:13 labText:@"联系方式:"];
    [self setBgImgView:CGRectMake(100, setHight, iPhoneWidth - 120, 40) imageName:@"Public_TextField_Bg.png"];
    [self setBgImgView:CGRectMake(34, setHight+10, 21, 21) imageName:@"myLogin_setPassWord.png"];
    
    _phoneTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setHight, iPhoneWidth - 106, 40)];
    _phoneTextField.backgroundColor = [UIColor clearColor];
    _phoneTextField.font = defaultFontSize(13);
    _phoneTextField.placeholder = @"";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    //    _passWordTextField.textColor = [SkinManager textColorWithName:MyLogin_PhoneWord_TextColor];
    [self.view addSubview:_phoneTextField];
    _phoneTextField.delegate = self;
    
    setHight = setHight + 45;
    [self setTheLineImg:setHight];

    
    //地区:
    [self setLabel:CGRectMake(10, setHight, 80, 40)  labFont:13 labText:@"所在地区:"];
    [self setBgImgView:CGRectMake(80, setHight, iPhoneWidth - 100, 40) imageName:@"Public_TextField_Bg.png"];

    [self setLabel:CGRectMake(iPhoneWidth-30, setHight, 40, 40) labFont:18 labText:@">"];
    
    _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(93, setHight-2, iPhoneWidth - 120, 45)];
    _addressLab.backgroundColor = [UIColor clearColor];
    _addressLab.textColor = [UIColor blackColor];
    _addressLab.textAlignment = NSTextAlignmentLeft;
//    _addressLab.text = @"北京 通州";
    _addressLab.font = defaultFontSize(13);
    [self.view addSubview:_addressLab];
    [self setBtn:CGRectMake(30, setHight, iPhoneWidth - 60, 45) imageName:@"" btnTag:10002 Color:[UIColor clearColor]];

    setHight  = setHight + 45;
    [self setTheLineImg:setHight];

    //详细地址:
    [self setLabel:CGRectMake(10, setHight, 80, 40)  labFont:13 labText:@"详细地址:"];
    [self setBgImgView:CGRectMake(80, setHight, iPhoneWidth - 100, 150) imageName:@"textViewBg.png"];

    // 正文内容
    _betterAddressTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setHight, iPhoneWidth - 106, 40)];
    _betterAddressTextField.backgroundColor = [UIColor clearColor];
    _betterAddressTextField.font = defaultFontSize(13);
    _betterAddressTextField.placeholder = @"";
    [self.view addSubview:_betterAddressTextField];
    _betterAddressTextField.delegate = self;
    _betterAddressTextField.textAlignment = NSTextAlignmentLeft;

    setHight  = setHight + 45;
    [self setTheLineImg:setHight];

    //设置默认:
    [self setLabel:CGRectMake(10, setHight+ 5, 80, 40)  labFont:13 labText:@"设置默认:"];
    [self setBgImgView:CGRectMake(80, setHight, iPhoneWidth - 100, 150) imageName:@"textViewBg.png"];
    _defSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(iPhoneWidth - 90, setHight + 5, 50, 45)];
    [_defSwitch setOn:NO];
    [_defSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_defSwitch];
    
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(iPhoneWidth - 150, setHight + 7, 130, 30);
//    [btn setTitle:@"设成默认收货地址" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
//    [btn.layer setCornerRadius:5.0];
//    [btn.layer setBorderColor:UIColorWithRGB(238, 95, 80, 1).CGColor];
//    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    btn.titleLabel.font = defaultFontSize(13);
//    [self.view addSubview:btn];
    
    [self setTheLineImg:setHight + 45];

    setHight  = setHight + 65;

    // 提交
    [self setBtn:CGRectMake(0, iPhoneHeight-50, iPhoneWidth, 50) imageName:@"myLogin_loginBg.png" btnTag:10001 Color:UIColorWithRGB(252, 132, 37, 1)];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, iPhoneHeight-50, iPhoneWidth, 50)];
    lab.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"保存";
    lab.font = defaultFontSize(18);
    [self.view addSubview:lab];

    isdef = NO;

}
//TODO:设置图片背景
- (void)setBgImgView:(CGRect )rect imageName:(NSString *)imgname{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:imgname];
    [self.view addSubview:imageView];
}

//TODO:设置提示文字
- (void)setLabel:(CGRect )rect  labFont:(float )labfont labText:(NSString *)text{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor grayColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = text;
    lab.font = defaultFontSize(labfont);
    [self.view addSubview:lab];
}

//TODO:设置按钮
- (void)setBtn:(CGRect )rect imageName:(NSString *)imgname btnTag:(NSInteger )tag Color:(UIColor *)color{
    UIButton    *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = color;
//    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnPassed:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径

    [self.view addSubview:btn];
}

//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, sizeY - 1, iPhoneWidth , 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    //    imgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imgView];
    setHight = setHight+1;

}

//TODO:设置地址数据
- (void)setAddressNode:(AddressNode *)addressNode{
    _addressNode = addressNode;
    
}

//-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
//    [_nameTextField resignFirstResponder];
//    [_phoneTextField resignFirstResponder];
//}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:按钮响应事件
- (void)btnPassed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 提交
        case 10001:
        {
            
            if (!_nameTextField.text || _nameTextField.text.length == 0) {
                [self showProgressWithString:@"请输入名称" hiddenAfterDelay:1];
                return;
            }
            if (_phoneTextField.text == nil) {
                
                [self showProgressWithString:@"手机号不能为空" hiddenAfterDelay:1];

                return;
            }
            if (![ShareDataManager isValidatePhoneNum:_phoneTextField.text]) {
                
                [self showProgressWithString:@"手机号不符合规范" hiddenAfterDelay:1];

                return;
            }

            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            
            [dict setObject:[NSNumber numberWithInt:REQ_ADDRESS_ADD] forKey:REQ_CODE];
            
            [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
        
            NSArray *array = [_cidyID componentsSeparatedByString:@","];
    

            [dict setObject:[array objectAtIndex:0] forKey:@"province"];
            [dict setObject:[array objectAtIndex:1] forKey:@"city"];
            [dict setObject:[array objectAtIndex:2] forKey:@"area"];
            [dict setObject:_betterAddressTextField.text forKey:@"addr"];
            [dict setObject:_phoneTextField.text forKey:@"mobile"];
            [dict setObject:_nameTextField.text forKey:@"consignee"];
            if (isdef) {
                [dict setObject:@"1" forKey:@"def"];

            }else{
                [dict setObject:@"0" forKey:@"def"];

            }
            if (!_isAdd){
                [dict setObject:_addressNode.AID forKey:@"id"];

            }
            [self.httpManager sendReqWithDict:dict];
            
        }
            break;
            
         // 选择添加地址
        case 10002:
        {
            if (_addressView) {
                [_addressView removeFromSuperview];
                _addressView = nil;
            }
            _addressView = [[SelectDataView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _addressView.pickerStyle = PickerWithCityArea;
            _addressView.delegate = self;
            _addressView.backgroundColor = [UIColor clearColor];
            [_addressView showInView:self.view];

        }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:左按钮点击
-(void)leftBtnAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
//TODO:取消选择地址
- (void)cancelDataView{
    [_addressView cancelPicker];
}

//TODO:确定传入地址
- (void)sureData:(NSString *)dataS dataID:(NSString *)ddID{
    [_addressView cancelPicker];
    _addressLab.text = dataS;
    _cidyID = ddID;

}
//-(void)click:(id)sender{
//    
//    UIButton *button = (UIButton *)sender;
//
//    if (button) {
//        NSLog(@"====== 设置为默认");
//        isdef = YES;
//    }else {
//        NSLog(@"====== 不设置为默认");
//        isdef = NO;
//        
//    }
//
//}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"====== 设置为默认");
        isdef = YES;
    }else {
        NSLog(@"====== 不设置为默认");
        isdef = NO;
        
    }

   }

#pragma mark -
#pragma mark ============ 网络回调 ============
//TODO:请求成功
-(void)requestFinished:(NSDictionary *)resultDict{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
        case REQ_ADDRESS_ADD:
        {
            [self showProgressWithString:@"地址添加成功" hiddenAfterDelay:1];

            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:ADD_ADDRESS_SUCCESS object:nil];
     
        }
            break;
            
            
        default:
            break;
    }
    
}

//TODO:请求失败
-(void)requestFailed:(NSDictionary *)errorDict{
    [self.progressView hide:YES];
    NSString *msg = nil;
    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
        case REQ_ADDRESS_ADD:
        {
            msg = [errorDict objectForKey:RESP_MSG];
            [self showProgressWithString:msg hiddenAfterDelay:1];

        }
            break;
        default:
            break;
    }
    
    
    
}

//TODO:关闭选择地址
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_betterAddressTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}


//TDDO:关闭键盘
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{

    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_betterAddressTextField resignFirstResponder];

}

//TODO:进入界面回调
- (void)viewWillAppear:(BOOL)animated{

    if (!_isAdd) {
        _nameTextField.text = _addressNode.consignee;
        _phoneTextField.text = _addressNode.mobile;
        _addressLab.text = _addressNode.region;
        _betterAddressTextField.text = _addressNode.addr;
        _cidyID = [NSString stringWithFormat:@"%@,%@,%@",_addressNode.province,_addressNode.city,_addressNode.area];
        if ([_addressNode.def integerValue] == 1) {
           [_defSwitch setOn:YES];
            isdef = YES;
        }else{
            [_defSwitch setOn:NO];
            isdef = NO;
        }
    }
}

//在UITextField 编辑之前调用方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    isMore = NO;

    moreHigh =iPhoneHeight - textField.frame.origin.y - 45;
    if ( moreHigh< 250){
//        moreHigh = 350 - moreHigh;

        [self animateTextField:textField up: YES];
        isMore = YES;
    }
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (isMore){
        isMore = NO;
        [self animateTextField: textField up: NO];
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    isMore = NO;
    
    moreHigh =iPhoneHeight - textView.frame.origin.y - 150;
    if ( moreHigh< 250){
//        moreHigh = 250 - moreHigh;

        [self animateTextField:nil up: YES];
        isMore = YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (isMore){
        isMore = NO;

        [self animateTextField:nil up: NO];
    }
}

//视图上移的方法
- (void)animateTextField: (UITextField *) textField up: (BOOL) up
{
    //设置视图上移的距离，单位像素
    const int movementDistance = 250 - moreHigh; // tweak as needed
    //三目运算，判定是否需要上移视图或者不变
    int movement = (up ? -movementDistance : movementDistance);
    //设置动画的名字
    [UIView beginAnimations: @"Animation" context: nil];
    //设置动画的开始移动位置
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置动画的间隔时间
    [UIView setAnimationDuration: 0.20];
    //设置视图移动的位移
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //设置动画结束
    [UIView commitAnimations];
}
@end

