//
//  MyTasksDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "MyTasksDetailViewController.h"
#import "BuyDetailViewController.h"
#import "ShowTasksDetailViewController.h"


#define SETFOOTHIGH         65  // 底部高度

@interface MyTasksDetailViewController ()


@end

@implementation MyTasksDetailViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"任务进度";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
    //删除
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.frame = CGRectMake(0, 0, 50, 50);
//    [delBtn setImage:[UIImage imageNamed:@"Public_Rubbish.png"] forState:UIControlStateNormal];
    [delBtn setTitle:@"结束" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    delBtn.backgroundColor = [UIColor clearColor];
    [delBtn addTarget:self action:@selector(delBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = delBtn;
    
}
//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TASKS_HAVEDONE_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DOMYTASK_SUCCESS object:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskFinished) name:TASKS_HAVEDONE_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doMytaskSuccess) name:DOMYTASK_SUCCESS object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT ;
   
    [self reqGetDetail];
//    [self setMainInitView];

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

//TODO:设置主界面
- (void)setMainInitView{
    
    // 图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setHeight , 80, 80)];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgImageView];

    // 点击事件
    [self setTheBtn:CGRectMake(10, setHeight , iPhoneWidth, 100) btnTag:10000 imgStr:@""];
    setHeight  = setHeight + 10;
    // 图片
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,  setHeight, 80, 80)];
    headImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headImageView];
//    headImageView.layer.masksToBounds=YES;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_node.thumb] placeholderImage:[UIImage imageNamed:@"Public_list_noImg.png"]];
    
    // 标题
    [self setTheLab:CGRectMake(100, setHeight , iPhoneWidth - 150, 33) textColor:[UIColor blackColor] labText:_node.name setFont:17 setCen:NO];
    // 说明
//    [self setTheLab:CGRectMake(100, setHeight + 33 , iPhoneWidth - 150, 23) textColor:[UIColor grayColor] labText:@"一起赚钱吧" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(100, setHeight+ 33 , iPhoneWidth - 150, 25) textColor:[UIColor grayColor] labText:_buyDetailNode.sub_name setFont:15 setCen:NO];

    // 状态
//    [self setTheImg:CGRectMake(100, setHeight + 66 , 80, 24) imgStr:@"" bgColor:[UIColor clearColor]];
    
    _courseBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, setHeight + 58 , 80, 24)];
    _courseBtn.backgroundColor = UIColorWithRGB(126, 205, 91, 1);
    [_courseBtn setTitle:@"进行中" forState:UIControlStateNormal];
    [_courseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _courseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_courseBtn];
    [_courseBtn.layer setMasksToBounds:YES];
    [_courseBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
//    [_courseBtn.layer setBorderWidth:1.0]; //边框宽度
//    CGColorRef colorref = UIColorWithRGB(239, 239, 239, 1).CGColor;
//    [_courseBtn.layer setBorderColor:colorref];//边框颜色
    

    [self setTheImg:CGRectMake(iPhoneWidth - 30, setHeight + 36, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];
    
    setHeight = setHeight + 90;
    
    [self setTheImg:CGRectMake(0, setHeight , iPhoneWidth, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(209, 209, 209, 0.6)];
    
    // 任务奖励
    [self setTheLab:CGRectMake(13, setHeight  , 120, 70) textColor:[UIColor blackColor] labText:@"任务奖励" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(83, setHeight  , 120, 70) textColor:[UIColor grayColor] labText:@"（葫芦币）" setFont:13 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 140 , setHeight  , 120, 70) textColor:UIColorWithRGB(251, 102, 57, 1) labText:_node.profit setFont:17 setCen:YES];
    setHeight = setHeight + 70;

    [self setTheImg:CGRectMake(13, setHeight , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(209, 209, 209, 0.6)];

    // 总进度
    [self setTheLab:CGRectMake(13, setHeight  , 120, 70) textColor:[UIColor blackColor] labText:@"总进度" setFont:17 setCen:NO];
    NSString *sss = [NSString stringWithFormat:@"剩余%@天（%@天）",_node.surplus,_node.cycle];
    
    _surplusLab =  [[UILabel alloc] initWithFrame:CGRectMake(100 , setHeight  , iPhoneWidth - 120, 70)];
    _surplusLab.backgroundColor = [UIColor clearColor];
    _surplusLab.text = sss;
    _surplusLab.textColor = [UIColor grayColor];
    _surplusLab.textAlignment = NSTextAlignmentRight;
    _surplusLab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_surplusLab];
    
    setHeight = setHeight + 70;

    [self setTheImg:CGRectMake(13, setHeight , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(209, 209, 209, 0.6)];

    // 保证金
    [self setTheLab:CGRectMake(13, setHeight  , 120, 70) textColor:[UIColor blackColor] labText:@"保证金" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(63, setHeight  , 120, 70) textColor:[UIColor grayColor] labText:@"（葫芦币）" setFont:13 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 140 , setHeight  , 120, 70) textColor:[UIColor grayColor] labText:_node.bond setFont:17 setCen:YES];
    setHeight = setHeight + 70;

    [self setTheImg:CGRectMake(13, setHeight , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(209, 209, 209, 0.6)];

    
    // 领取时间
    [self setTheLab:CGRectMake(13, setHeight  , 120, 70) textColor:[UIColor blackColor] labText:@"领取时间" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(iPhoneWidth - 140 , setHeight  , 120, 70) textColor:[UIColor grayColor] labText:_node.mission_time setFont:17 setCen:YES];
    setHeight = setHeight + 70;

    [self setTheImg:CGRectMake(13, setHeight , iPhoneWidth - 26, 1) imgStr:@"line.png" bgColor:UIColorWithRGB(209, 209, 209, 0.6)];
    bgImageView.frame = CGRectMake(0, bgImageView.frame.origin.y, iPhoneWidth, setHeight - bgImageView.frame.origin.y);
    
    _tasksBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , iPhoneHeight - SETFOOTHIGH , iPhoneWidth, SETFOOTHIGH)];
    _tasksBtn.backgroundColor = UIColorWithRGB(60, 159, 242, 1);
    [_tasksBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_tasksBtn setTitle:@"做任务" forState:UIControlStateNormal];
    [_tasksBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _tasksBtn.tag = 10001;
    [self.view addSubview:_tasksBtn];

    
    NSInteger missionS = [_buyDetailNode.mission_status integerValue];
    if (missionS > 0) {
        // 可以做任务
        _tasksBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
        [_tasksBtn setTitle:@"做任务" forState:UIControlStateNormal];
        [_courseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _courseBtn.titleLabel.font = [UIFont systemFontOfSize:15];


    }

    else if (missionS == -1){
        //今日任务已经完成
        _tasksBtn.backgroundColor = [UIColor grayColor];
        [_tasksBtn setTitle:@"今日任务已经完成" forState:UIControlStateNormal];
        _tasksBtn.userInteractionEnabled = NO;
   
    }
    else if (missionS == 0){
        //今日任务已经完成
        _tasksBtn.backgroundColor = [UIColor grayColor];
        [_tasksBtn setTitle:@"此任务已完结" forState:UIControlStateNormal];
        _tasksBtn.userInteractionEnabled = NO;
        [_courseBtn setTitle:@"此任务已完结" forState:UIControlStateNormal];
        [_courseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _courseBtn.titleLabel.font = [UIFont systemFontOfSize:11];

    }
    else if (missionS == -2){
        //今日任务已经完成
        _tasksBtn.backgroundColor = [UIColor grayColor];
        [_tasksBtn setTitle:@"此任务已终止" forState:UIControlStateNormal];
        _tasksBtn.userInteractionEnabled = NO;
        [_courseBtn setTitle:@"此任务已终止" forState:UIControlStateNormal];
        [_courseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _courseBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        self.rightBtn.hidden = YES;
    }
    
    
}

//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    

}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
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
    lab.font = [UIFont systemFontOfSize:font];
    [self.view addSubview:lab];
}


- (void)setNode:(MyTaskAnyCellNode *)node{
    if (_node == node) {
        return;
    }
    _node = node;

}



#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:删除随时赚列表
- (void)delBtnPressed{
    if ([_node.surplus integerValue] == 0){
        [self showProgressWithString:@"该任务已完结，不可终止！" hiddenAfterDelay:1];
        return;
    }
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"警告！您正在进行终止任务操作！终止任务将会扣除罚金！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertV show];
   
}


#pragma mark -
#pragma mark ============ UIAlertViewDelegate ============
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"确定"]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:REQ_MYTASKS_BUY_END] forKey:REQ_CODE];
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
        [dict setObject:_buyDetailNode.mid forKey:@"mid"];
        [self.httpManager sendReqWithDict:dict];
        [self.progressView show:YES];

    }

    
    
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 进详情
        case 10000:
        {
            BuyDetailViewController *buyv = [[BuyDetailViewController alloc] init];
            buyv.goodID = _node.Mid;
            [self.navigationController pushViewController:buyv animated:YES];
        }
            break;
            // 进入任务
        case 10001:{
            //
            ShowTasksDetailViewController *showTasksDetailViewController = [[ShowTasksDetailViewController alloc]  init];
            showTasksDetailViewController.isMyTask = YES;
            showTasksDetailViewController.jsonString = _jsonString;
            showTasksDetailViewController.detailNode = _buyDetailNode ;
            [self.navigationController pushViewController:showTasksDetailViewController animated:YES];
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
    [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DETAIL] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_node.Mid forKey:@"id"];
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
        case REQ_ANYTIMEBUY_DETAIL:
        {
            self.jsonString = [resultDict objectForKey:RESP_CONTENT];
            _buyDetailNode = [resultDict objectForKey:RESP_NODE];
            [self setMainInitView];
            
        }
            break;
            // 终止任务
        case REQ_MYTASKS_BUY_END:{
            [self showProgressWithString:@"任务已终止" hiddenAfterDelay:1];
            // 任务完成
            [[NSNotificationCenter defaultCenter] postNotificationName:DOMYTASK_SUCCESS object:nil];

            [self backPressed];
            
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
        case REQ_ANYTIMEBUY_DETAIL:
            // 终止任务
        case REQ_MYTASKS_BUY_END:{
            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

//TODO:任务完成
- (void)taskFinished{
    //今日任务已经完成
    _tasksBtn.backgroundColor = [UIColor grayColor];
    [_tasksBtn setTitle:@"今日任务已经完成" forState:UIControlStateNormal];
    _tasksBtn.userInteractionEnabled = NO;
    
}

//TODO:我的任务完成
- (void)doMytaskSuccess{
//    NSInteger days  = [_node.surplus integerValue];
//    if (days > 0) {
//        days = days - 1;
//        NSString *sss = [NSString stringWithFormat:@"剩余%ld天（%@天）",(long)days,_node.cycle];
//        _surplusLab.text = sss;
//        [_courseBtn setTitle:@"进行中" forState:UIControlStateNormal];
//        [_courseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _courseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//
//        if (days == 0) {
//            [_courseBtn setTitle:@"此任务已完结" forState:UIControlStateNormal];
//            [_courseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            _courseBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//
//        }
//
//    }
  

}



@end
