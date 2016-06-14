//
//  BankBranchViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "WithdrawViewController.h"


#define CELLHIGH   45

@interface WithdrawViewController ()


@end

@implementation WithdrawViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.text = @"提现";
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn] ;
    
    
}

//TODO:获取银行信息
- (void)setBankNode:(MyBankListNode *)bankNode{
    _bankNode = bankNode;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = UIColorWithRGB(239, 239, 239, 1);
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT ;
    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - 50)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];

    _drawArr = [NSMutableArray array];
    canTX = YES;
    [self setTheLineImg:setHeight];
    setHeight = 10;

    // 地址选择
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth , CELLHIGH) imageName:@"myLogin_setUser.png"];
    [self setLabel:CGRectMake(10, setHeight, 80, CELLHIGH)  labFont:15 labText:@"省市城市"];
    _cityTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setHeight, iPhoneWidth - 106, CELLHIGH)];
    _cityTextField.backgroundColor = [UIColor clearColor];
    _cityTextField.font = defaultFontSize(14);
    _cityTextField.placeholder = @"点击选择";
    [_mainScrollView addSubview:_cityTextField];
    _cityTextField.textAlignment = NSTextAlignmentRight;
    //    _cityTextField.delegate = self;
    [self setBtn:CGRectMake(93, setHeight, iPhoneWidth - 106, CELLHIGH) imageName:@"" btnTag:10000 Color:[UIColor clearColor]];
    setHeight = setHeight + CELLHIGH;
    [self setTheLineImg:setHeight];
    _cityTextField.text = [NSString stringWithFormat:@"%@ %@",_bankNode.province,_bankNode.city];
    _provinceStr = _bankNode.province;
    _cityStr = _bankNode.city;
    
    // 关键字
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth , CELLHIGH) imageName:@"myLogin_setUser.png"];
    [self setLabel:CGRectMake(10, setHeight, 80, CELLHIGH)  labFont:15 labText:@"网点关键字"];
    _keyTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setHeight, iPhoneWidth - 106, CELLHIGH)];
    _keyTextField.backgroundColor = [UIColor clearColor];
    _keyTextField.font = defaultFontSize(14);
    _keyTextField.placeholder = @"输入关键字（可不填）";
    [_mainScrollView addSubview:_keyTextField];
    _keyTextField.textAlignment = NSTextAlignmentRight;
    setHeight = setHeight + CELLHIGH;
    [self setTheLineImg:setHeight];
    
    // 银行网点
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth , CELLHIGH) imageName:@"myLogin_setUser.png"];
    [self setLabel:CGRectMake(10, setHeight, 80, CELLHIGH)  labFont:15 labText:@"银行网点"];
    _pointTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setHeight, iPhoneWidth - 106, CELLHIGH)];
    _pointTextField.backgroundColor = [UIColor clearColor];
    _pointTextField.font = defaultFontSize(14);
    _pointTextField.placeholder = @"点击选择";
    [_mainScrollView addSubview:_pointTextField];
    _pointTextField.textAlignment = NSTextAlignmentRight;
    //    _cityTextField.delegate = self;
    [self setBtn:CGRectMake(93, setHeight, iPhoneWidth - 106, CELLHIGH) imageName:@"" btnTag:10001 Color:[UIColor clearColor]];
    setHeight = setHeight + CELLHIGH;
    [self setTheLineImg:setHeight];
    _pointTextField.text = _bankNode.point;

    setHeight = setHeight + 30;
    
    // 提现金额
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth , CELLHIGH) imageName:@"myLogin_setUser.png"];
    [self setLabel:CGRectMake(10, setHeight, 80, CELLHIGH)  labFont:15 labText:@"提现金额"];
    _moneyTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(93, setHeight, iPhoneWidth - 106, CELLHIGH)];
    _moneyTextField.backgroundColor = [UIColor clearColor];
    _moneyTextField.font = defaultFontSize(14);
    _moneyTextField.placeholder = @"输入金额";
    [_mainScrollView addSubview:_moneyTextField];
    _moneyTextField.textAlignment = NSTextAlignmentRight;
    _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _moneyTextField.delegate = self;
    setHeight = setHeight + CELLHIGH;
    [self setTheLineImg:setHeight];
    
    // 提现金额
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth , CELLHIGH) imageName:@"myLogin_setUser.png"];
    [self setLabel:CGRectMake(10, setHeight, 80, CELLHIGH)  labFont:15 labText:@"手续费"];
    
    // 提现扣手续费提示
    _withholdingLab = [[UILabel alloc] initWithFrame:CGRectMake(93, setHeight, iPhoneWidth - 106, CELLHIGH)];
    _withholdingLab.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_withholdingLab];
    _withholdingLab.font = [UIFont systemFontOfSize:14];
    _withholdingLab.textColor = [UIColor lightGrayColor];
    _withholdingLab.text = @"手续费率0.7%,最低2元,最高25元";
    _withholdingLab.textAlignment = NSTextAlignmentLeft;
    setHeight = setHeight + CELLHIGH;
    [self setTheLineImg:setHeight];
    
   
    setHeight = setHeight + 10;

    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth , 370) imageName:@"myLogin_setUser.png"];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, setHeight, iPhoneWidth - 20, 370)];
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = UIColorWithRGB(102, 102, 102, 1);
    textView.text = @"注意事项:\n1. 在您申请提现前，请先实名绑定银行卡并且设置交易密码；\n2. 收到您的提现请求后，我们将在1个工作日（双休日或法定节假日顺延）处理您的提现申请，请您注意查收；\n3. 为了防止信用卡套现的恶意金融行为，提现将收取 0.7% 的交易手续费，最低2元、最高25元每笔；\n4. 为保障您的账户资金安全，申请提现时，您选择的银行卡开户名必须与您在爱葫芦账户实名认证一致，否则提现申请将不予受理；\n5. 提现时，您不能选择将资金提现至信用卡账户，请您选择银行储蓄卡账户提交提现申请；\n6. 严禁利用爱葫芦网进行套现、洗钱、匿名转账，对于频繁的非正常投资为目的的资金充提行为，一经发现，爱葫芦网将通过原充值渠道进行资金清退，已收取手续费将不予返还；\n7. 下列情况下，已收取手续费将不予返还：用户提供的银行卡非本人银行卡，被银行退回；用户申请提现的银行卡非借记卡，与银行名称不符，或卡号明显异常，被银行退回；用户没有提供提现操作必要的支行信息，且爱葫芦网无法与之取得联系的。";
    textView.userInteractionEnabled = NO;
    textView.editable = NO;
    textView.font = defaultFontSize(14);
    [_mainScrollView addSubview:textView];
    
    setHeight =  setHeight + 420;

    _mainScrollView.contentSize = CGSizeMake(iPhoneWidth, setHeight );

    // 提现
    UIButton *withDrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    withDrawBtn.frame = CGRectMake(0, iPhoneHeight - 50, iPhoneWidth , 50);
    withDrawBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [withDrawBtn setTitle:@"确定" forState:UIControlStateNormal];
    [withDrawBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [withDrawBtn addTarget:self action:@selector(verifyPWD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:withDrawBtn];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


//TODO:关闭键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_keyTextField resignFirstResponder];
    [_moneyTextField resignFirstResponder];
}

//TODO:设置按钮
- (void)setBtn:(CGRect )rect imageName:(NSString *)imgname btnTag:(NSInteger )tag Color:(UIColor *)color{
    UIButton    *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = color;
    //    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnPassed:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    
    [_mainScrollView addSubview:btn];
}

//TODO:设置图片背景
- (void)setBgImgView:(CGRect )rect imageName:(NSString *)imgname{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.image = [UIImage imageNamed:imgname];
    [_mainScrollView addSubview:imageView];
}

//TODO:设置提示文字
- (void)setLabel:(CGRect )rect  labFont:(float )labfont labText:(NSString *)text{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = text;
    lab.font = defaultFontSize(labfont);
    [_mainScrollView addSubview:lab];
}

//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, sizeY - 1, iPhoneWidth , 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    //    imgView.backgroundColor = [UIColor redColor];
    [_mainScrollView addSubview:imgView];
    setHeight = setHeight+1;
    
}

//TODO:输入关键字
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_cityTextField.text isEqualToString:@""] || _cityTextField.text.length == 0  || _cityTextField.text == nil){
        [self showProgressWithString:@"您尚未选择省市" hiddenAfterDelay:1];
        return;
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _moneyTextField) {
        NSString *moneyS = [NSString stringWithFormat:@"%@%@",textField.text,string];
        NSLog(@"moneyS=======  %@",moneyS);
        if ([string isEqualToString:@""] || string.length == 0 || string == nil) {
            moneyS = [moneyS substringToIndex:moneyS.length - 1];

        }
        if ([moneyS isEqualToString:@""] || moneyS.length == 0 || moneyS == nil) {
            _withholdingLab.textColor = [UIColor lightGrayColor];
            _withholdingLab.text = @"手续费率0.7%,最低2元,最高25元";
            
        }else{
            NSString *showstr;
            float cmoney = [moneyS floatValue];
            if (cmoney > 20 || cmoney == 20) {
                cmoney = cmoney / 1000 * 7;
                
                if (cmoney > 25) {
                    cmoney = 25.00;
                }
                if (cmoney < 2) {
                    cmoney = 2.00;
                }
                canTX = YES;
                showstr = [NSString stringWithFormat:@"￥%.2f",cmoney];
                _withholdingLab.textColor = [UIColor redColor];
                _withholdingLab.textAlignment = NSTextAlignmentRight;
                
            }else{
                canTX = NO;
                showstr = @"每次提取金额不得小于20元";
                _withholdingLab.textColor = [UIColor lightGrayColor];
                _withholdingLab.textAlignment = NSTextAlignmentLeft;

            }
            _withholdingLab.text = showstr;
        }

    }
    return YES;

}
//TODO:结束输入
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == _moneyTextField && _moneyTextField.text.length > 0){
        NSString *showstr;
        float cmoney = [_moneyTextField.text floatValue];
        if (cmoney > 20 || cmoney == 20) {
            cmoney = cmoney / 1000 * 7;
            
            if (cmoney > 25) {
                cmoney = 25.00;
            }
            if (cmoney < 2) {
                cmoney = 2.00;
            }
            canTX = YES;
            showstr = [NSString stringWithFormat:@"￥%.2f元",cmoney];
            _withholdingLab.textColor = [UIColor lightGrayColor];

        }else{
            canTX = NO;
            showstr = @"每次提取金额不得小于20元";
            _withholdingLab.textColor = [UIColor lightGrayColor];

        }
        _withholdingLab.text = showstr;
        
    }
    return YES;
}
#pragma mark ============ 网络请求 ============
//TODO:获取银行网点
- (void)reqGetBranch{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_BANK_BRANCH] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_provinceStr forKey:@"province"];
    [dict setObject:_cityStr forKey:@"city"];
    //    [dict setObject:_bankNode.bankcode forKey:@"name"];
    [dict setObject:_bankNode.bankcode forKey:@"name"];
    [dict setObject:_keyTextField.text forKey:@"keywords"];
    
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:验证支付密码
- (void)verifyPWD{
    if ([_pointTextField.text isEqualToString:@""] || _pointTextField.text == nil || _pointTextField.text.length == 0) {
        [self showProgressWithString:@"请选择网点" hiddenAfterDelay:1];
        return;
    }
    if ([_moneyTextField.text isEqualToString:@""] || _moneyTextField.text == nil || _moneyTextField.text.length == 0) {
        [self showProgressWithString:@"请输入提现金额" hiddenAfterDelay:1];
        [_moneyTextField becomeFirstResponder];
        return;
    }
    if (!canTX) {
        [self showProgressWithString:@"每次提取金额不得小于20元" hiddenAfterDelay:1];
        return;
    }
    _withholdingLab.hidden = NO;
    
    
    if (self.stAlertView) {
        _stAlertView = nil;
    }
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"请输入支付密码"
                                                  message:nil
                                            textFieldHint:nil
                                           textFieldValue:nil
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定"
                        
                                        cancelButtonBlock:^{
                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您确定取消" delegate:self cancelButtonTitle:@"是的" otherButtonTitles:@"点错了", nil];
                                            [alertView show];
                                            
                                        } otherButtonBlock:^(NSString * result){
                                            NSString *opas = [MHCommonTool stringToShaValue:result];
                                            [self reqWithDraw:opas];
                                        }];
    
}

//TODO:UIAlertView 事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"取消"] || [str isEqualToString:@"点错了"]) {
        [self verifyPWD];
        
    }
    if ([str isEqualToString:@"是的"] ) {
        [_moneyTextField becomeFirstResponder];
    }
}

//TODO:提现
- (void)reqWithDraw:(NSString *)pd{
    
    // 判断支付密码是否正确
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MONEY_APPLY] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_provinceStr forKey:@"province"];
    [dict setObject:_cityStr forKey:@"city"];
    [dict setObject:_moneyTextField.text forKey:@"money"];
    //    [dict setObject:_bankNode.bank forKey:@"bank"];
    [dict setObject:_bankNode.bank forKey:@"bank"];
    [dict setObject:_pointTextField.text forKey:@"point"];
    //    [dict setObject:_bankNode.cardno forKey:@"cardno"];
    [dict setObject:_bankNode.cardno forKey:@"cardno"];
    [dict setObject:_bankNode.Bid forKey:@"cardid"];
    
    
    [dict setObject:pd forKey:@"pwd"];
    
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
//TODO:按钮响应事件
- (void)btnPassed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 选择省市
        case 10000:
        {
            [self showDataPressed];
        }
            break;
            // 选择网点
        case 10001:{
            if ([_cityTextField.text isEqualToString:@""] || _cityTextField.text.length == 0 || _cityTextField.text == nil) {
                [self showProgressWithString:@"请选择省市" hiddenAfterDelay:1];
                
                return;
            }
            //            if ([_keyTextField.text isEqualToString:@""] || _keyTextField.text.length == 0 || _keyTextField.text == nil) {
            //                [self showProgressWithString:@"请输入网点关键字" hiddenAfterDelay:1];
            //
            //                return;
            //            }
            
            //            [_keyTextField resignFirstResponder];
            [self reqGetBranch];
            
        }
            break;
        default:
            break;
    }
}


//TODO:选择省市
- (void)showDataPressed{
    if (_cityDataView) {
        [_cityDataView removeFromSuperview];
        _cityDataView = nil;
    }
    _cityDataView = [[SelectDataView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    _cityDataView.pickerStyle = PickerWithCity;
    _cityDataView.delegate = self;
    _cityDataView.backgroundColor = [UIColor clearColor];
    [_cityDataView showInView:self.view];
}

//TODO:取消选择省市
- (void)cancelDataView{
    [_cityDataView cancelPicker];
    
}

//TODO:确定传入地址
- (void)sureData:(NSString *)dataS dataID:(NSString *)ddID{
    _cityTextField.text = dataS;
    _provinceStr = [NSString stringWithFormat:@"%@",_cityDataView.provinceStr];
    _cityStr = [NSString stringWithFormat:@"%@",_cityDataView.cityStr];
    [self cancelDataView];
}

//TODO:取消选择
- (void)cancelSelectDataView{
    [_drawPickerView cancelPicker];
    
}

//TODO:确定传入
- (void)sureSelectStyle:(ModifyPickerStyle )style dataStr:(NSString *)str{
    [self cancelSelectDataView];
    _pointTextField.text = str;
    
}

#pragma mark -
#pragma mark =============== 网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 银行网点
        case REQ_BANK_BRANCH:
        {
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            [_drawArr removeAllObjects];
            for (NSDictionary *dic in arr) {
                NSString *name = [dic objectForKey:@"point"];
                [_drawArr addObject:name];
            }
            if (_drawArr.count == 0){
                [self showProgressWithString:@"该地区无网点" hiddenAfterDelay:1];
                
                return;
            }
            
            if (_drawPickerView) {
                [_drawPickerView removeFromSuperview];
                _drawPickerView = nil;
            }
            _drawPickerView = [[SelectPickerView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _drawPickerView.delegate = self;
            _drawPickerView.pickerStyle = PickerWithIncome;
            _drawPickerView.dataArr = _drawArr;
            _drawPickerView.backgroundColor = [UIColor clearColor];
            [_drawPickerView showInView:self.view];
            
        }
            break;
            // 提现
        case REQ_MONEY_APPLY:{
            [self showProgressWithString:@"提现成功" hiddenAfterDelay:1];
            //            [self backPressed];
        }
            break;
        default:
            break;
    }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    [self.progressView hide:YES];
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
            // 银行网点
        case REQ_BANK_BRANCH:{
            [self showProgressWithString:@"网点获取失败" hiddenAfterDelay:1];
            
        }
            break;
            //提现
        case REQ_MONEY_APPLY:{
            [self showProgressWithString:msg hiddenAfterDelay:1];
            
        }
            break;
        default:
            break;
    }
    
}
@end
