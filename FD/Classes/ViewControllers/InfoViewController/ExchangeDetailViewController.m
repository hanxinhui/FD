//
//  ExchangeDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ExchangeDetailViewController.h"
#import "ShowTasksDetailViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "GoodsDetailViewController.h"
#import "MoreViewController.h"

@interface ExchangeDetailViewController ()


@end

@implementation ExchangeDetailViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"兑换详情";
    self.statusColor = UIColorWithRGB(25, 125, 218, 0.8);
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn] ;

    
}

//TODO:传人id
- (void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    [self initNavBar];
    self.view.backgroundColor = [UIColor whiteColor];

//    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 0.8);

    setHeight = setHeight + NVARBAR_HIGHT;
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight) imgStr:@"" bgColor:UIColorWithRGB(239, 239, 244, 0.8)];
    [self reqGetDetail];

}

//TODO:设置界面
- (void)setMainViewInit{
    
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 50) imgStr:@"" bgColor:UIColorWithRGB(89, 103, 127, 0.8)];
    [self setTheImg:CGRectMake(15, setHeight + 16, 17, 18) imgStr:@"ex_icon1.png" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(60, setHeight, iPhoneWidth - 100, 50) textColor:[UIColor whiteColor] labText:_dNode.status_msg setFont:15 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth /2, setHeight , iPhoneWidth /2 - 20, 50) textColor:[UIColor whiteColor] labText:_dNode.code setFont:15 setCen:YES];

    setHeight = setHeight + 50;

    // 判断是实物还是虚拟商品
//    float  setY;
    if ([_dNode.sku integerValue] > 0) {
        // 快递信息
        [self setTheImg:CGRectMake(0, setHeight , iPhoneWidth, 130) imgStr:@"" bgColor:[UIColor whiteColor]];
        [self setTheImg:CGRectMake(25, setHeight + 56, 13, 17) imgStr:@"ex_icon2.png" bgColor:[UIColor clearColor]];
        
        NSString *kuadi = [NSString stringWithFormat:@"%@ : %@",_dNode.express_type,_dNode.express_code];
        if ([_dNode.status integerValue] == 0) {
            kuadi = _dNode.status_msg;
            [self setTheLab:CGRectMake(60, setHeight + 40, iPhoneWidth - 100, 55) textColor:UIColorWithRGB(229, 7, 0, 1) labText:kuadi setFont:17 setCen:NO];
        }else{
            [self setTheLab:CGRectMake(60, setHeight + 40, iPhoneWidth - 100, 30) textColor:UIColorWithRGB(229, 7, 0, 1) labText:kuadi setFont:15 setCen:NO];
            [self setTheImg:CGRectMake(iPhoneWidth - 50, setHeight + 58, 8, 15) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
            [self setTheLab:CGRectMake(60, setHeight + 70, iPhoneWidth - 100, 25) textColor:[UIColor blackColor] labText:_dNode.express_time setFont:15 setCen:NO];
            [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 110) btnTag:100001 imgStr:@""];
            
        }
        
        setHeight = setHeight + 130;
        
        [self setTheImg:CGRectMake(15, setHeight-1 , iPhoneWidth - 15, 1) imgStr:@"" bgColor:UIColorWithRGB(227, 227, 227, 0.8)];
        //收货人
        [self setTheImg:CGRectMake(0, setHeight , iPhoneWidth, 90) imgStr:@"" bgColor:[UIColor whiteColor]];
        [self setTheImg:CGRectMake(25, setHeight + 40 , 13, 17) imgStr:@"ex_icon3.png" bgColor:[UIColor clearColor]];
        NSString *names = [NSString stringWithFormat:@"收货人 : %@",_dNode.consignee];
        [self setTheLab:CGRectMake(60, setHeight + 10, 120, 30) textColor:[UIColor blackColor] labText:names setFont:15 setCen:NO];
        [self setTheLab:CGRectMake(iPhoneWidth - 200, setHeight + 10 , 180, 30) textColor:[UIColor blackColor] labText:_dNode.mobile setFont:15 setCen:YES];
        NSString *adds = [NSString stringWithFormat:@"收货地址 : %@",_dNode.address];
        
        [self setTheLab:CGRectMake(60, setHeight + 30, iPhoneWidth - 80, 50) textColor:[UIColor blackColor] labText:adds setFont:15 setCen:NO];
        setHeight = setHeight + 90;
        [self setTheImg:CGRectMake(15, setHeight , iPhoneWidth - 15, 1) imgStr:@"" bgColor:UIColorWithRGB(227, 227, 227, 0.8)];
        setHeight = setHeight + 25;
        [self setTheImg:CGRectMake(0, setHeight , iPhoneWidth, 90) imgStr:@"" bgColor:[UIColor whiteColor]];
        
        [self setTheImg:CGRectMake(0, setHeight , iPhoneWidth, 180) imgStr:@"" bgColor:[UIColor whiteColor]];
        
    }else{
        
        // 账户
        [self setTheImg:CGRectMake(0, setHeight , iPhoneWidth, 39) imgStr:@"" bgColor:[UIColor whiteColor]];
        

        NSString *remarks = [NSString stringWithFormat:@"%@",_dNode.remarks];
        
        [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth - 80, 39) textColor:[UIColor blackColor] labText:remarks setFont:15 setCen:NO];
        setHeight = setHeight + 50;

        
        [self setTheImg:CGRectMake(0, setHeight , iPhoneWidth, 180) imgStr:@"" bgColor:[UIColor whiteColor]];

      

    }

    // 商品信息
    // 商品头像
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, setHeight + 10, 112, 74)];
    headImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headImgView];
    [headImgView sd_setImageWithURL:[NSURL URLWithString:_dNode.thumb] placeholderImage:[UIImage imageNamed:@"list_noImg.png"]];

    [self setTheLab:CGRectMake(140, setHeight + 10, iPhoneWidth - 160, 50) textColor:[UIColor blackColor] labText:_dNode.name setFont:15 setCen:NO];
    if ([_dNode.sku integerValue] > 0) {
        NSString *goods = [NSString stringWithFormat:@"商品属性 : %@",_dNode.sku];
        [self setTheLab:CGRectMake(140, setHeight +60, iPhoneWidth - 160, 50) textColor:UIColorWithRGB(184, 184, 184, 0.8) labText:goods setFont:15 setCen:NO];

    }
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 100) btnTag:100002 imgStr:@""];

       setHeight = setHeight + 100;
    [self setTheImg:CGRectMake(15, setHeight, iPhoneWidth - 15, 1) imgStr:@"" bgColor:UIColorWithRGB(227, 227, 227, 0.8)];
    [self setTheLab:CGRectMake(15, setHeight, 120, 35) textColor:[UIColor grayColor] labText:_dNode.createtime setFont:13 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 180, setHeight, 60, 35) textColor:[UIColor blackColor] labText:@"兑换价格:" setFont:13 setCen:NO];
//    [self setTheLab:CGRectMake(iPhoneWidth - 120, setHeight, 60, 35) textColor:UIColorWithRGB(229, 7, 0, 1) labText:setFont:13 setCen:YES];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 120, setHeight, 60, 35)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = _dNode.price ;
    lab.textColor = UIColorWithRGB(229, 7, 0, 1);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lab];
    
    [self setTheLab:CGRectMake(iPhoneWidth - 60, setHeight, 50, 35) textColor:[UIColor blackColor] labText:@"葫芦币" setFont:13 setCen:NO];
    [self setTheImg:CGRectMake(15, setHeight-1 , iPhoneWidth - 15, 1) imgStr:@"" bgColor:UIColorWithRGB(227, 227, 227, 0.8)];

   // 兑换
    _exBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 100, setHeight + 40 , 80, 30)];
    _exBtn.backgroundColor = [UIColor clearColor];
    [_exBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    _exBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_exBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_exBtn.layer setMasksToBounds:NO];
    [_exBtn.layer setCornerRadius:5.0];
    [_exBtn.layer setBorderWidth:1.0];
    [_exBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    _exBtn.hidden = NO;
    _exBtn.userInteractionEnabled = YES;

    if ([_dNode.status integerValue] < 0 ) {
        [_exBtn setTitle:@"已关闭" forState:UIControlStateNormal];
        _exBtn.userInteractionEnabled = NO;
        
    }
    switch ([_dNode.status integerValue]) {
        case 0:{
            // 可退
            [_exBtn setTitle:@"取消兑换" forState:UIControlStateNormal];
        }
    
            break;
        case 1:{
            // 确认
            [_exBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
        case 2:{
            _exBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
    _exBtn.tag = 100003;
    [self.view addSubview:_exBtn];
    
    
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}
//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    if (name == nil || [name isEqualToString:@""] || name.length == 0) {
        
    }else{
        [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        
    }
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    
    
}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    if (name == nil || [name isEqualToString:@""] || name.length == 0) {
        
    }else{
        [imgView setImage:[UIImage imageNamed:name]];

    }
    [self.view addSubview:imgView];
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
    [self.view addSubview:lab];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:点击事件
- (void)toBtnPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
        case 100001:
            // 物流详情
        {
            if ([_dNode.express_code isEqualToString:@""] || _dNode.express_code == nil || _dNode.express_code.length == 0) {
                return;
            }else{
                // 进入物流
                MoreViewController *moreViewController = [[MoreViewController alloc] init];
                NSString *urls = [NSString stringWithFormat:@"%@%@",SERVER_EMAIL_DETAILES,_dNode.gid];
                moreViewController.webUrl = urls;
                moreViewController.webName = @"物流信息";
                moreViewController.cID = @"0";
                moreViewController.gID = _dNode.gid;
                moreViewController.typeS= @"1";
                moreViewController.goodName = _dNode.name;
                [self.navigationController pushViewController:moreViewController animated:YES];
            }
        }
            break;
        case 100002:
        {
            // 商品详情
            GoodsDetailViewController *detailViewController = [[GoodsDetailViewController alloc] init];
            detailViewController.goodID = _dNode.gid;
            [self.navigationController pushViewController:detailViewController animated:YES];
        }
            break;
        case 100003:
        {
            // 取消兑换
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];

            switch ([_dNode.status integerValue]) {
                case 0:{
                    [dict setObject:[NSNumber numberWithInt:REQ_MYEXCHAGE_CLOSE] forKey:REQ_CODE];
                    
   
                }
                    break;
                case 1:{
                    // 确认收货
                    [dict setObject:[NSNumber numberWithInt:REQ_MYEXCHAGE_SURE] forKey:REQ_CODE];

                }
                    break;
           
                default:
                    break;
            }
            [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
            [dict setObject:_goodID forKey:@"id"];
            [self.httpManager sendReqWithDict:dict];
            [self.progressView show:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetDetail{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MYEXCHAGE_DETAIL] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_goodID forKey:@"id"];
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
            // 详情
        case REQ_MYEXCHAGE_DETAIL:
        {
            _dNode = [resultDict objectForKey:RESP_CONTENT];
            [self setMainViewInit];
        }
            break;
            // 取消兑换
        case REQ_MYEXCHAGE_CLOSE:{
            [self showProgressWithString:@"取消成功" hiddenAfterDelay:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:CLOSEEXCHANGE__SUCCESS object:nil];
            [self backPressed];
        }
            break;
            // 确认兑换
        case REQ_MYEXCHAGE_SURE:{
            [self showProgressWithString:@"确认收货成功" hiddenAfterDelay:1];
            _exBtn.hidden = YES;
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
            // 详情
        case REQ_MYEXCHAGE_DETAIL:
            // 取消兑换
        case REQ_MYEXCHAGE_CLOSE:{
            
        }
            break;
 
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

@end
