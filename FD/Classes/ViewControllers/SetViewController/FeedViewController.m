//
//  FeedViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "FeedViewController.h"

#define MAX_INPUT_LENGTH     300

@interface FeedViewController ()


@end

@implementation FeedViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"反馈";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    //提交
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(0, 0, 50, 50);
    [sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    sendBtn.backgroundColor = [UIColor clearColor];
    [sendBtn addTarget:self action:@selector(sendBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = sendBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT + 10;
    
    // 初始化
    _feedtextView = [[UITextView alloc] initWithFrame:CGRectMake(10, setHeight, iPhoneWidth - 20, 200)];
    _feedtextView.backgroundColor = [UIColor clearColor];
    _feedtextView.delegate = self;
    _feedtextView.font = [UIFont systemFontOfSize:15];//设置字体名字和字体大小
    _feedtextView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _feedtextView.scrollEnabled = YES;//是否可以拖动
    _feedtextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.view addSubview:_feedtextView];
    _feedtextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _feedtextView.layer.borderWidth = 1.0;
    _feedtextView.layer.cornerRadius = 8.0f;
    [_feedtextView.layer setMasksToBounds:YES];
    
    // 提示 文字
    _hintLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, iPhoneWidth - 50, 30)];
    _hintLab.backgroundColor = [UIColor clearColor];
    _hintLab.font = [UIFont systemFontOfSize:15];
    _hintLab.textColor = [UIColor grayColor];
    _hintLab.textAlignment = NSTextAlignmentLeft;
    _hintLab.text = @"请给我们您的宝贵建议！";
    [_feedtextView addSubview:_hintLab];
    
    setHeight = setHeight + 210;

    //
    _limitLab = [[UILabel alloc] initWithFrame:CGRectMake(10, setHeight, iPhoneWidth - 50, 20)];
    _limitLab.backgroundColor = [UIColor clearColor];
    _limitLab.font = [UIFont systemFontOfSize:15];
    _limitLab.textColor = [UIColor grayColor];
    _limitLab.textAlignment = NSTextAlignmentLeft;
    _limitLab.text = @"0/300";
    [self.view addSubview:_limitLab];
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

#pragma mark - UITextView Delegate Methods
- (void)textViewDidBeginEditing:(UITextView *)textView {
    _hintLab.hidden = YES;


}

- (void)textViewDidEndEditing:(UITextView *)textView {
    

}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        _hintLab.hidden = NO;

    }else{
        _hintLab.hidden = YES;

    }
    _limitLab.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length ];
    if (textView.text.length > MAX_INPUT_LENGTH) {
        _limitLab.textColor = [UIColor redColor];
    }else{
        _limitLab.textColor = [UIColor grayColor];

    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;

}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:提交
- (void)sendBtnPressed{
    if ([ShareDataManager getText:_feedtextView.text] ) {
        [self showProgressWithString:@"请输入内容" hiddenAfterDelay:1];

        return;
    }
    if (_feedtextView.text.length > 300 ) {
        [self showProgressWithString:@"输入内容超出范围" hiddenAfterDelay:1];
        
        return;
    }
    [self showProgressWithString:@"反馈成功" hiddenAfterDelay:1];
    [self backPressed];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DETAIL] forKey:REQ_CODE];
//    
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
//    [dict setObject:_feedtextView.text forKey:@"id"];
//    [self.httpManager sendReqWithDict:dict];
//    [self.progressView show:YES];
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
        case REQ_ANYTIMEBUY_DETAIL:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}
@end
