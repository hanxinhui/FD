//
//  CommentViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "CommentViewController.h"
#import "LoginViewController.h"



@interface CommentViewController ()


@end

@implementation CommentViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
//    self.titleLable.textColor = [UIColor clearColor];
    
    self.titleLable.text = @"评论";
//    self.headerBgView.backgroundColor = [UIColor clearColor];
//    self.headerView.backgroundColor = [UIColor clearColor];
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn] ;

}

//TODO:传人id
- (void)setCommentID:(NSString *)commentID{
    _commentID = commentID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavBar];

    setHeight = setHeight + 50;

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, setHeight , iPhoneWidth - 20, 50)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = [UIColor grayColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = _nameStr;
    lab.numberOfLines = 0;
    [self.view addSubview:lab];
    
    setHeight = setHeight + 50;

    // 初始化评论界面
    _conTextView = [[UITextView alloc] initWithFrame:CGRectMake(10,  setHeight, iPhoneWidth - 20, 150)];
    _conTextView.backgroundColor = [UIColor whiteColor];
    _conTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _conTextView.layer.borderWidth = 1.0;
    _conTextView.layer.cornerRadius = 8.0f;
    [_conTextView.layer setMasksToBounds:YES];

    [self.view addSubview:_conTextView];
    _conTextView.font = [UIFont systemFontOfSize:15];//设置字体名字和字体大小
    _conTextView.delegate = self;//设置它的委托方法
    _conTextView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _conTextView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    _conTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _conTextView.scrollEnabled = YES;//是否可以拖动
    _conTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    // 提交
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , iPhoneHeight - 50 , iPhoneWidth , 50)];
    sureBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [sureBtn addTarget:self action:@selector(surePressed) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sureBtn];

        [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is %@",requestString);
    return YES;
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.progressView show:YES];

}

//TODO:加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.progressView hide:YES];

    NSLog(@"webViewDidFinishLoad======");

//    id repr = [self.jsonString JSONFragment];
//    [_conWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initSpread(%@);",repr]];

}

//TODO:加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.progressView hide:YES];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_conTextView resignFirstResponder];
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark 网络请求
//TODO:确认评论
- (void)surePressed{
    if ([_conTextView.text isEqualToString:@""] || _conTextView.text == nil || _conTextView.text.length == 0) {
        [self showProgressWithString:@"请输入评论内容" hiddenAfterDelay:1];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_COMMENT_SEND] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_goodID forKey:@"id"];
    [dict setObject:_fID forKey:@"fid"];
    [dict setObject:_typeStr forKey:@"type"];
    [dict setObject:_conTextView.text forKey:@"content"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
    
}
////TODO:获取详情
//- (void)reqGetCommentDetail{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInt:REQ_COMMENT_SEND] forKey:REQ_CODE];
//  
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
//    [dict setObject:_commentID forKey:@"id"];
//    [self.httpManager sendReqWithDict:dict];
//    [self.progressView show:YES];
//}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {

            // 评论
        case REQ_COMMENT_SEND:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:COMMENT__SUCCESS object:nil];

            [self showProgressWithString:@"评论成功" hiddenAfterDelay:1];
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

            // 评论
        case REQ_COMMENT_SEND:{
            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

@end
