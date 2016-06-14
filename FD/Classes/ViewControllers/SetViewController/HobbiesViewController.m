//
//  HobbiesViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "HobbiesViewController.h"
#import "HobbiesChildNode.h"
#import "HobbiesNode.h"



@interface HobbiesViewController ()


@end

@implementation HobbiesViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"兴趣爱好";
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
    //完成
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(0, 0, 50, 50);
//    [favBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    sendBtn.backgroundColor = [UIColor clearColor];
    [sendBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(saveBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = sendBtn;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    _hDataArr = [NSMutableArray array];
    _selectArr = [NSMutableArray array];
    
    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];

    
    [self reqGetHobbies];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

//TODO:根据数据设置界面
- (void)setMainInitView{
    float setH = 5.0;
    for (int i = 0; i <_hDataArr.count; i++) {
        HobbiesNode *node = [_hDataArr objectAtIndex:i];
        UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(15, setH, 100, 30)];
        namelab.backgroundColor = [UIColor clearColor];
        namelab.text = node.name;
        namelab.textColor = [UIColor blackColor];
        namelab.textAlignment = NSTextAlignmentLeft;
        namelab.font = defaultFontSize(15);
        [_mainScrollView addSubview:namelab];
        
        setH = setH + 30;
        
        HobbiesBtnScrollView *btnScrollView = [[HobbiesBtnScrollView alloc] init];
        btnScrollView.frame = CGRectMake(15, setH, iPhoneWidth - 30, 44);
        btnScrollView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:btnScrollView];
        btnScrollView.btnDelegate = self;
        btnScrollView.nameArray = node.childArr;
        btnScrollView.varTag = i * 10000;
        btnScrollView.nowSelectTag = 0;
        [btnScrollView initWithNameButtons];
       btnScrollView.frame = CGRectMake(15, setH, iPhoneWidth - 30, btnScrollView.contentSize.height);
        setH = setH + btnScrollView.frame.size.height  + 10;
        
    }
    _mainScrollView.contentSize = CGSizeMake(iPhoneWidth, setH);
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:完成
- (void)saveBtnPressed{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MODIFYINFO] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    NSString *idStr = @"0";
    for (int i = 0; i<_selectArr.count; i++) {
        id obj = [_selectArr objectAtIndex:i];
        idStr = [NSString stringWithFormat:@"%@,%@",idStr,obj];

    }
    if (_selectArr.count == 0){
        [self showProgressWithString:@"请至少保留一个兴趣" hiddenAfterDelay:1];
        return;
    }
    idStr = [idStr substringFromIndex:2];

    [dict setObject:idStr forKey:@"interest"];

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


//TOOD:选择按钮
- (void)HobbiesSelectBtnTag:(NSInteger )tag{
    BOOL isH = NO;// 是否已经选中
    for (NSString *ss in _selectArr) {
        if ([ss integerValue] == tag) {
            isH = YES;
        }
    }
    if (isH) {
        [_selectArr removeObject:[NSString stringWithFormat:@"%ld",(long)tag]];
        
    }else{
        [_selectArr addObject:[NSString stringWithFormat:@"%ld",(long)tag]];

    }
//    NSLog(@"_selectArr si ====  %@",_selectArr);
}

#pragma mark 网络请求
//TODO:获取数据
- (void)reqGetHobbies{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_HOBBIES] forKey:REQ_CODE];
  
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
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
        case REQ_HOBBIES:
        {
            _hDataArr = [resultDict objectForKey:RESP_CONTENT];
            for (HobbiesNode *node in _hDataArr) {
                
                for (HobbiesChildNode *cnode in node.childArr) {
                    if (cnode.selected == 1) {
                        [_selectArr addObject:cnode.Hid];
                    }
                }
            }
            [self setMainInitView];
            
        }
            break;
        case REQ_MODIFYINFO:
        {
            NSLog(@"[resultDict objectForKey:RESP_CONTENT] is %@",[resultDict objectForKey:RESP_CONTENT]);
            NSString *name = @"0";
            for (int i = 0; i<_selectArr.count; i++) {
                id obj = [_selectArr objectAtIndex:i];
                for (int i = 0; i < _hDataArr.count; i++) {
                    HobbiesNode *node = [_hDataArr objectAtIndex:i];
                    for (HobbiesChildNode *cnode in node.childArr ) {
                        if ([obj isEqualToString:cnode.Hid] || obj == cnode.Hid) {
                            name = [NSString stringWithFormat:@"%@,%@",name,cnode.name];

                        }
                    }
                }
  
            }
            name = [name substringFromIndex:2];

            [UserDataManager sharedUserDataManager].userData.Uinterest = name ;
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
        case REQ_HOBBIES:
        case REQ_MODIFYINFO:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}

@end
