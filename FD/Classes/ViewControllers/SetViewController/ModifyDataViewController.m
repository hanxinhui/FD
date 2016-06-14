//
//  ModifyDataViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ModifyDataViewController.h"
#import "ModifyNikeViewController.h"
#import "HobbiesViewController.h"


@interface ModifyDataViewController ()


@end

@implementation ModifyDataViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.titleLable.textColor = [UIColor blackColor];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
 
    self.titleLable.text = @"修改资料";
  
    //设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag = 111111;
    self.leftBtn = backBtn;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    //昵称
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth , 50) btnTag:100001 ];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 50) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"昵称" setFont:17 setCen:NO];
    
    _nikeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 50)];
    _nikeLab.backgroundColor = [UIColor clearColor];
    _nikeLab.text = [UserDataManager sharedUserDataManager].userData.Unike;
    _nikeLab.textColor = [UIColor grayColor];
    _nikeLab.textAlignment = NSTextAlignmentRight;
    _nikeLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_nikeLab];
    
    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight];

    //性别
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth , 50) btnTag:100002 ];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 50) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"性别" setFont:17 setCen:NO];
    
    _sexLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 50)];
    _sexLab.backgroundColor = [UIColor clearColor];
    _sexLab.text = [UserDataManager sharedUserDataManager].userData.Usex;
    _sexLab.textColor = [UIColor grayColor];
    _sexLab.textAlignment = NSTextAlignmentRight;
    _sexLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_sexLab];
    
    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight];

    
//    //真实姓名
//    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth, 50) btnTag:100003 ];
//
//    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 50) imgStr:@"" bgColor:[UIColor clearColor]];
//    [self setTheLab:CGRectMake(20, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"真实姓名" setFont:17 setCen:NO];
//
//    _realNameLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 50)];
//    _realNameLab.backgroundColor = [UIColor clearColor];
//    _realNameLab.text = [UserDataManager sharedUserDataManager].userData.RName;
//    _realNameLab.textColor = [UIColor grayColor];
//    _realNameLab.textAlignment = NSTextAlignmentRight;
//    _realNameLab.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:_realNameLab];
//    
//    setHeight = setHeight + 50;
//    [self setTheLineImg:setHeight];

    
    //生日
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth, 50) btnTag:100004 ];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 50) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"生日" setFont:17 setCen:NO];

    _brithLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 50)];
    _brithLab.backgroundColor = [UIColor clearColor];
    _brithLab.text = [UserDataManager sharedUserDataManager].userData.Ubirthday;
    _brithLab.textColor = [UIColor grayColor];
    _brithLab.textAlignment = NSTextAlignmentRight;
    _brithLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_brithLab];
    
    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight];

    
    //所在省市
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth , 50) btnTag:100005];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 50) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"所在省市" setFont:17 setCen:NO];

    _cityLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 50)];
    _cityLab.backgroundColor = [UIColor clearColor];
    _cityLab.text = [UserDataManager sharedUserDataManager].userData.Uaddr;
    _cityLab.textColor = [UIColor grayColor];
    _cityLab.textAlignment = NSTextAlignmentRight;
    _cityLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_cityLab];
    
    setHeight = setHeight + 60;
//    [self setTheLineImg:setHeight - 10];

    
    //月收入
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth, 50) btnTag:100006 ];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 50)  imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"月收入" setFont:17 setCen:NO];
    
    _incomeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 50)];
    _incomeLab.backgroundColor = [UIColor clearColor];
    _incomeLab.text = [UserDataManager sharedUserDataManager].userData.Uincome;
    _incomeLab.textColor = [UIColor grayColor];
    _incomeLab.textAlignment = NSTextAlignmentRight;
    _incomeLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_incomeLab];
    
    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight];

    
    //兴趣爱好
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth, 50) btnTag:100007];

    [self setTheImg:CGRectMake(10, setHeight, iPhoneWidth - 20, 50) imgStr:@"" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(20, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"兴趣爱好" setFont:17 setCen:NO];

    _hobbyLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 250, setHeight, 200, 50)];
    _hobbyLab.backgroundColor = [UIColor clearColor];
//    _hobbyLab.text = [UserDataManager sharedUserDataManager].userData.Uinterest;
    _hobbyLab.text = @"请选择";

    _hobbyLab.textColor = [UIColor grayColor];
    _hobbyLab.textAlignment = NSTextAlignmentRight;
    _hobbyLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_hobbyLab];
    
    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight];

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag {
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    
    
    [self setTheImg:CGRectMake(iPhoneWidth - 40, setHeight + 16, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];

}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self.view addSubview:imgView];
}
//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, sizeY-1, iPhoneWidth - 20, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [self.view addSubview:imgView];
}
//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setCen:(BOOL )cen{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (cen) {
        lab.textAlignment = NSTextAlignmentCenter;
        
    }else{
        lab.textAlignment = NSTextAlignmentLeft;
        
    }
    lab.font = [UIFont systemFontOfSize:font];
    [self.view addSubview:lab];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 修改昵称
        case 100001:
        {
            ModifyNikeViewController *modifyNikeViewController = [[ModifyNikeViewController alloc] init];
            [modifyNikeViewController initWithStyle:ModifyNikename];
            [self.navigationController pushViewController:modifyNikeViewController animated:YES];
        }
            break;
            // 修改性别
        case 100002:
        {
            if (_selectPickerView) {
                [_selectPickerView removeFromSuperview];
                _selectPickerView = nil;
            }
            _selectPickerView = [[SelectPickerView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _selectPickerView.delegate = self;
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:@"男"];
            [arr addObject:@"女"];
//            [arr addObject:@"保密"];
            _selectPickerView.pickerStyle = PickerWithSex;
            _selectPickerView.dataArr = arr;

            _selectPickerView.backgroundColor = [UIColor clearColor];
            [_selectPickerView showInView:self.view];
        }
            break;
            // 修改真实姓名
        case 100003:
        {
            ModifyNikeViewController *modifyNikeViewController = [[ModifyNikeViewController alloc] init];
            [modifyNikeViewController initWithStyle:ModifyRealname];
            [self.navigationController pushViewController:modifyNikeViewController animated:YES];
        }
            break;
            // 修改生日
        case 100004:
        {
            if (_brithView) {
                [_brithView removeFromSuperview];
                _brithView = nil;
            }
            _brithView = [[SelectBrithView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _brithView.delegate = self;
            _brithView.backgroundColor = [UIColor clearColor];
            [_brithView showInView:self.view];
        }
            break;
            // 修改省市
        case 100005:
        {
            if (_dataView) {
                [_dataView removeFromSuperview];
                _dataView = nil;
            }
            _dataView = [[SelectDataView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _dataView.pickerStyle = PickerWithCityArea;
            _dataView.delegate = self;
            _dataView.backgroundColor = [UIColor clearColor];
            [_dataView showInView:self.view];
        }
            break;
            // 修改月收入
        case 100006:
        {
            if (_selectPickerView) {
                [_selectPickerView removeFromSuperview];
                _selectPickerView = nil;
            }
            _selectPickerView = [[SelectPickerView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _selectPickerView.delegate = self;
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:@"4999以下"];
            [arr addObject:@"5000-9999"];
            [arr addObject:@"10000-14999"];
            [arr addObject:@"15000-19999"];
            [arr addObject:@"20000以上"];
            _selectPickerView.pickerStyle = PickerWithIncome;
            _selectPickerView.dataArr = arr;
            _selectPickerView.backgroundColor = [UIColor clearColor];
            [_selectPickerView showInView:self.view];
        }
            break;
            // 修改兴趣爱好
        case 100007:
        {
            
            HobbiesViewController *hobbiesViewController = [[HobbiesViewController alloc] init];
            [self.navigationController pushViewController:hobbiesViewController animated:YES];

        }
            break;
  
            // 返回
        case 111111:
        {
            if ([ShareDataManager getText:_sexLab.text] || [ShareDataManager getText:_brithLab.text]|| [ShareDataManager getText:_cityLab.text]|| [ShareDataManager getText:_incomeLab.text]|| [ShareDataManager getText:[UserDataManager sharedUserDataManager].userData.Unike] || [ShareDataManager getText:[UserDataManager sharedUserDataManager].userData.Uinterest]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的资料尚未完善，是否确认退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];

                
            }else{
                [self.navigationController popViewControllerAnimated:YES];
  
            }
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"确定"]) {
        [self.navigationController popViewControllerAnimated:YES];

    }

}

#pragma mark ============ 其他事件 ============
//TODO:取消选择生日
- (void)cancelBrithView{
    [_brithView removeFromSuperview];
    _brithView = nil;
}

//TODO:确定传入生日
- (void)sureBrith:(NSString *)dataS{
    _brithLab.text = dataS;
    [_brithView removeFromSuperview];
    _brithView = nil;
    
    self.dataStyle = ModifyWithBrith;
    [self reqModifyData];

}

//TODO:取消选择地址
- (void)cancelDataView{
    [_dataView cancelPicker];
}

//TODO:确定传入地址
- (void)sureData:(NSString *)dataS dataID:(NSString *)ddID{
    [_dataView cancelPicker];
    _cityLab.text = dataS;
    _cidyID = ddID;
    self.dataStyle = ModifyWithAddress;
    [self reqModifyData];

}

//TODO:取消选择
- (void)cancelSelectDataView{
    
    [_selectPickerView cancelPicker];

}
//TODO:确定传入
- (void)sureSelectStyle:(ModifyPickerStyle )style dataStr:(NSString *)str{
    [_selectPickerView cancelPicker];
    if (style == PickerWithIncome){
        _incomeLab.text = str;
        self.dataStyle = ModifyWithIncome;

    }else{
        _sexLab.text = str;
        self.dataStyle = ModifyWithSex;

    }
    [self reqModifyData];
}

#pragma mark 网络请求
//TODO:修改数据
- (void)reqModifyData{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MODIFYINFO] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    if ([ShareDataManager getText:_sexLab.text] || [ShareDataManager getText:_brithLab.text]|| [ShareDataManager getText:_cityLab.text]|| [ShareDataManager getText:_incomeLab.text]|| [ShareDataManager getText:[UserDataManager sharedUserDataManager].userData.Unike] || [ShareDataManager getText:[UserDataManager sharedUserDataManager].userData.Uinterest]) {
        return;
        
    }
    NSString *sexs;
    if ([_sexLab.text isEqualToString:@"男"]) {
        sexs = @"1";
    }
    if ([_sexLab.text isEqualToString:@"女"]) {
        sexs = @"2";
    }
    [dict setObject:sexs forKey:@"sex"];
    
    [dict setObject:_brithLab.text forKey:@"birthday"];
    [dict setObject:_cityLab.text forKey:@"addr"];
    [dict setObject:_incomeLab.text forKey:@"monthly_income"];

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
            [UserDataManager sharedUserDataManager].userData.Usex = _sexLab.text ;
            [UserDataManager sharedUserDataManager].userData.Ubirthday = _brithLab.text ;
            [UserDataManager sharedUserDataManager].userData.Uaddr = _cityLab.text ;
            [UserDataManager sharedUserDataManager].userData.Uincome = _incomeLab.text ;

            [[UserDataManager sharedUserDataManager] saveUserInfo];
//            [self showProgressWithString:@"修改成功" hiddenAfterDelay:1];

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
            _sexLab.text = [UserDataManager sharedUserDataManager].userData.Usex;
            _brithLab.text = [UserDataManager sharedUserDataManager].userData.Ubirthday;
            _cityLab.text = [UserDataManager sharedUserDataManager].userData.Uaddr;
            _incomeLab.text = [UserDataManager sharedUserDataManager].userData.Uincome;

            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}


//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _realNameLab.text = [UserDataManager sharedUserDataManager].userData.RName;
    _nikeLab.text = [UserDataManager sharedUserDataManager].userData.Unike;
//    _hobbyLab.text = [UserDataManager sharedUserDataManager].userData.Uinterest;
    [[UserDataManager sharedUserDataManager] saveUserInfo];
}


@end
