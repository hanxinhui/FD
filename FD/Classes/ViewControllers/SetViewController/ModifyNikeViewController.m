//
//  ModifyNikeViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ModifyNikeViewController.h"


@interface ModifyNikeViewController ()


@end

@implementation ModifyNikeViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.titleLable.textColor = [UIColor blackColor];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.titleLable.text = @"修改昵称";
  
    //设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
//    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    _slab = [[UILabel alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _slab.backgroundColor = [UIColor clearColor];
    _slab.text = @"4-20个字符，可由中英文、数字、“_”、“-”组成";
    _slab.textColor = UIColorWithRGB(154, 154, 154, 1);
    _slab.textAlignment = NSTextAlignmentLeft;
    _slab.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:_slab];
    
    setHeight = setHeight + 40;
   
    
    // 初始化界面
    _nikeTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _nikeTextField.backgroundColor = [UIColor clearColor];
    _nikeTextField.font = defaultFontSize(21);
    _nikeTextField.textColor = [UIColor blackColor];
    _nikeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    if (self.modifyStyle == ModifyNikename) {
        _nikeTextField.placeholder = @"请输入昵称";
        self.titleLable.text = @"修改昵称";
    }else{
        _nikeTextField.placeholder = @"请输入姓名";
        self.titleLable.text = @"修改真实姓名";

    }
    _nikeTextField.verticalPadding = 2;
    [_nikeTextField becomeFirstResponder];
    _nikeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _nikeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_nikeTextField];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight + 40, iPhoneWidth - 40, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [self.view addSubview:imgView];
    
    setHeight = setHeight + 60;

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 50)];
    btn.backgroundColor = UIColorWithRGB(241, 101, 103, 1);
//    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(modifyBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:21];
    
    [self.view bringSubviewToFront:self.progressView];
    [self.view bringSubviewToFront:self.MSGprogressView];

    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}



//TODO:出入类型
- (void)initWithStyle:(ModifyNameStyle)style{
    
    self.modifyStyle = style;
    

}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:进行修改
- (void)modifyBtnPressed{
    if (_nikeTextField.text == nil || _nikeTextField.text.length == 0 || [_nikeTextField.text isEqualToString:@""]){
        [self.view bringSubviewToFront:self.MSGprogressView];
        [_nikeTextField resignFirstResponder];
        [self showProgressWithString:@"尚未输入内容" hiddenAfterDelay:1];

        return;
    }
    
    [self reqModifyData];
}


#pragma mark 网络请求
//TODO:修改数据
- (void)reqModifyData{
    if([_nikeTextField.text isEqualToString:@""] || _nikeTextField.text.length == 0 || _nikeTextField.text == nil){
        [self showProgressWithString:@"请输入内容" hiddenAfterDelay:1];
        return;
    }
    if(_nikeTextField.text.length > 20 ){
        [self showProgressWithString:@"输入的内容不能超过20个字符数" hiddenAfterDelay:1];
        return;
    }
    if( _nikeTextField.text.length  < 4){
        [self showProgressWithString:@"输入的内容不能小于4个字符数" hiddenAfterDelay:1];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MODIFYINFO] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    switch (self.modifyStyle) {
        case ModifyNikename:
        {
            [dict setObject:_nikeTextField.text forKey:@"nickname"];

        }
            break;
        case ModifyRealname:
        {
            [dict setObject:_nikeTextField.text forKey:@"realname"];
            
        }
            break;
        
        default:
            break;
    }
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            //
        case REQ_MODIFYINFO:
        {
            switch (self.modifyStyle) {
                case ModifyNikename:
                {
                    [UserDataManager sharedUserDataManager].userData.Unike = _nikeTextField.text ;

                }
                    break;
                case ModifyRealname:
                {
                    [UserDataManager sharedUserDataManager].userData.RName = _nikeTextField.text ;
                    
                }
                    break;

                default:
                    break;
            }
            [self.navigationController popViewControllerAnimated:YES];

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
            //
        case REQ_MODIFYINFO:{
            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

@end
