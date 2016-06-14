//
//  BuyDetailViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "ShowTasksDetailViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "AddressViewController.h"
#import "MoreViewController.h"
#import "CommentViewController.h"
#import "BankListViewController.h"
#import "SkuNode.h"
#import "AddBankViewController.h"


#define SETFOOTHIGH         65  // 底部高度

@interface GoodsDetailViewController ()


@end

@implementation GoodsDetailViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor clearColor];
    self.dlineImgView.hidden  = YES;

    self.titleLable.text = @"";
    self.headerBgView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.statusColor = [UIColor clearColor];
    //返回
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, setHeight, 50, 50);
    [_backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    _backBtn.backgroundColor = [UIColor clearColor];
    [_backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn] ;
    
    //收藏
    _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _favBtn.frame = CGRectMake(iPhoneWidth - 50, setHeight, 50, 50);
    [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];
    _favBtn.backgroundColor = [UIColor clearColor];
    [_favBtn addTarget:self action:@selector(favBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_favBtn] ;


}

//TODO:传人id
- (void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
}
//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GOODSBUY_ADDRESS_SUCCESS object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    skuID = 0;
    
    isINLocal = NO;
    setHeight = IOS7?20:0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressFinished) name:GOODSBUY_ADDRESS_SUCCESS object:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@"请选择" forKey:GOODSBUY_ADDRESS];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);

    setChangeH = 0;
    //    setHeight = setHeight + NVARBAR_HIGHT;
    setDownH  = SETFOOTHIGH;
    if (iPhoneWidth > 320) {
        setDownH = SETFOOTHIGH;
    }else{
        setDownH = 45;
    }
   
    // 初始化界面
    _conWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth , iPhoneHeight - setDownH )];
    _conWebView.backgroundColor = [UIColor clearColor];
    _conWebView.delegate = self;
    NSString *urlS = [NSString stringWithFormat:@"%@%@",SERVER_GOODSBUY_CON,_goodID];
    [_conWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlS]]];
    [self.view addSubview: _conWebView];
//    _conWebView.scrollView.pagingEnabled = YES;
    _conWebView.scrollView.clipsToBounds = NO;
    _conWebView.scrollView.delegate = self;
    //    _conWebView.scrollView.bounces = NO;// 顶部禁止拖动

    [self reqGetDetail];

    // 头部内容
    _showHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, NVARBAR_HIGHT+setHeight)];
//    _showHeadView.backgroundColor = UIColorWithRGB(1, 1, 1, 0.5);
    _showHeadView.backgroundColor = UIColorWithRGB(255, 255, 255, 0.9);

    [self.view addSubview:_showHeadView];
    //    _showHeadView.hidden = YES;
    _showHeadView.alpha = 0.0;

    [self initNavBar];

    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - setDownH, iPhoneWidth, setDownH)];
    _footView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_footView];
    
    // 做任务
    _taskBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth - 80, setDownH)];
    _taskBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [_taskBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_taskBtn setTitle:@"兑换商品" forState:UIControlStateNormal];
    [_taskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _taskBtn.tag = 10001;
    _taskBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [_footView addSubview:_taskBtn];
    
    // 分享
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 80 , 0 , 80, setDownH)];
    shareBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [shareBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.tag = 10002;
    [_footView addSubview:shareBtn];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"Public_Share_h.png"] forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"Public_Share.png"] forState:UIControlStateSelected];

    
    // 隐藏
    _bgHiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0 , iPhoneWidth, iPhoneHeight)];
    _bgHiddenBtn.backgroundColor = [UIColor blackColor];
//    [_bgHiddenBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    _bgHiddenBtn.tag = 10003;
    [self.view addSubview:_bgHiddenBtn];
    _bgHiddenBtn.hidden = YES;
    _bgHiddenBtn.alpha = 0.3;
    
    _shareImgView = [[UIImageView alloc] init];

    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


#pragma mark -
#pragma mark ============ UIWebViewDelegate ============
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString is======== %@",requestString);
//    NSMutableString *comurl = [NSMutableString stringWithString:SERVER_COMMENT_DETAIL];
//    NSString *comand = [NSString stringWithFormat:SERVER_COMMENT_DETAIL];
//    [comurl appendFormat:@"%@",comand];
    
    if([requestString hasSuffix:@"#open"]){
        requestString = [requestString substringToIndex:requestString.length - 5];
        NSLog(@"123 is======== %@",requestString);
        MoreViewController *moreViewController = [[MoreViewController alloc] init];
        moreViewController.webUrl = requestString;
        moreViewController.webName = @"更多详情";
        moreViewController.cID = @"0";
        moreViewController.gID = _goodsDetailNode.Gid;
        moreViewController.typeS= @"2";
        moreViewController.goodName = _goodsDetailNode.name;
        [self.navigationController pushViewController:moreViewController animated:YES];
        return NO;
        
    }
    else if ([requestString hasSuffix:@"#fabu"]){
        CommentViewController *commentViewController = [[CommentViewController alloc] init];
        commentViewController.fID = @"0";
        commentViewController.goodID = _goodsDetailNode.Gid;
        commentViewController.typeStr = @"2";
        commentViewController.nameStr = _goodsDetailNode.name;
        
        [self.navigationController pushViewController:commentViewController animated:YES];
        
        
        return NO;
    }
    else{
        return YES;
    }
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.y;
    if (offset > 0) {
        if (setChangeH < offset) {
            setChangeH = offset;
            
            //            _showHeadView.hidden = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _showHeadView.alpha = 1.0;
                [_backBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
                if (!isFav) {
                    [_favBtn setImage:[UIImage imageNamed:@"Public_Fav_b.png"] forState:UIControlStateNormal];

                }
            }];
        }else{
            setChangeH = offset;
            
        }
        
    }else{
        setChangeH = offset;
        
        [UIView animateWithDuration:0.5 animations:^{
            _showHeadView.alpha = 0.0;
            [_backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
            if (!isFav) {
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];

            }
        }];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:)
               withObject:scrollView
               afterDelay:0.3];

}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [UIView animateWithDuration:0.5 animations:^{
//        _footView.frame = CGRectMake(0, iPhoneHeight , iPhoneWidth, setDownH );
//        
//    }];
//}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView

{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //do something here
    [UIView animateWithDuration:0.5 animations:^{
        _footView.frame = CGRectMake(0, iPhoneHeight - setDownH, iPhoneWidth, setDownH );
        
    }];
}
#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:关注
- (void)favBtnPressed{
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        app.isInfo = NO;
        LoginViewController *loginview = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginview animated:YES];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_FAV] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_goodID forKey:@"obj_id"];
    [dict setObject:@"2" forKey:@"type"];

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    if (![UserDataManager sharedUserDataManager].userIsLogIn) {
        app.isInfo = NO;

        LoginViewController *loginview = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginview animated:YES];
        return;
    }
    switch (tag) {
            // 兑换商品
        case 10001:
        {
            [self reqGetBalance];

            
            
        }
            break;
            // 分享
        case 10002:{
            if (![UserDataManager sharedUserDataManager].userIsLogIn) {
                app.isInfo = NO;

                LoginViewController *loginview = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginview animated:YES];
                return;
            }
            
            [self showShareView];

        }
            break;
            // 隐藏
        case 10003:{
          
            [self cancelBuyView];
            
        }
            break;
            
        default:
            break;
    }
}


//TODO:取消确认任务
- (void)cancelBuyView{
    _bgHiddenBtn.hidden = YES;
    [_buyDetilView cancelPicker];

}
//TODO:传入属性id
- (void)selectSku:(NSInteger )sku{
    skuID = sku;
}

//TODO:确定购买
- (void)goToBuyView{
    float bzj = [[_goodsDetailNode.price stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
    float ye = [[[UserDataManager sharedUserDataManager].userData.Utotal_Free stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
    if (bzj > ye) {
        // 跳转充值
        BankListViewController *controller = [[BankListViewController alloc] init];
        controller.bankStyle = BankWithPay;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GOODSBUY_BUY] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_goodsDetailNode.Gid forKey:@"gid"];
    if (_goodsDetailNode.sku.count > 0){
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)skuID] forKey:@"sku"];
        
    }
    NSInteger is_virtual = [_goodsDetailNode.is_virtual integerValue];
    switch (is_virtual) {
            // 实物
        case 0:
        {
            NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:GOODSBUY_ADDRESS];
            if ([address isEqualToString:@"请选择"]) {
                [self showProgressWithString:@"请选择地址" hiddenAfterDelay:1];
                
                return;
                
            }
            NSString *addressid = [[NSUserDefaults standardUserDefaults] objectForKey:GOODSBUY_ADDRESSID];
            
            [dict setObject:addressid forKey:@"aid"];
            [dict setObject:address forKey:@"addr"];
            
        }
            break;
            // 话费
        case 1:
        {
            if (![ShareDataManager isValidatePhoneNum:_buyDetilView.pTextField.text]) {
                [self showProgressWithString:@"手机号不符合规范" hiddenAfterDelay:1];
                return;
            }else{
                [dict setObject:_buyDetilView.pTextField.text forKey:@"remarks"];
                
            }
        }
            break;
            // Q币
        case 2:
        {
            [dict setObject:_buyDetilView.pTextField.text forKey:@"remarks"];
            
        }
            break;
        default:
            break;
    }
    
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
    

}

//TODO:确定购买- 判断是否实名
- (void)sureBuyView{
    // 判断是否实名
    [self judgementRealName];
    
    
}

//TODO:获取余额
- (void)reqGetBalance{
    // 获取余额
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GETBALANCE_FREE] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:进入地址界面
- (void)toAddressView{
    AddressViewController *addressViewController = [[AddressViewController alloc] init];
    addressViewController.addressStyle = buyAddress;
    addressViewController.isBuyIn = YES;
    [self.navigationController pushViewController:addressViewController animated:YES];
}

//TODO:地址选择完成
- (void)addressFinished{
    

}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetDetail{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GOODSBUY_DETAIL] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:_goodID forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:判断是否实名
- (void)judgementRealName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_ISREALNAME] forKey:REQ_CODE];
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
            // 详情
        case REQ_GOODSBUY_DETAIL:
        {
            _goodsDetailNode = [resultDict objectForKey:RESP_NODE];
            [_shareImgView sd_setImageWithURL:[NSURL URLWithString:_goodsDetailNode.thumb] placeholderImage:[UIImage imageNamed:@"icon.png"]];

            if ([_goodsDetailNode.attention integerValue] == 1) {
                
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav_h.png"] forState:UIControlStateNormal];
                isFav = YES;
            }else{
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];
                isFav = NO;

            }
            _taskBtn.userInteractionEnabled = YES;

            
        }
            break;
            // 随心兑兑换
        case REQ_GOODSBUY_BUY:{
            [self showProgressWithString:@"兑换成功" hiddenAfterDelay:1];
            NSInteger bzj = [[_goodsDetailNode.price stringByReplacingOccurrencesOfString:@"," withString:@""] integerValue];
            NSInteger ye = [[[UserDataManager sharedUserDataManager].userData.Utotal_Free stringByReplacingOccurrencesOfString:@"," withString:@""] integerValue];
            ye = ye - bzj;
            [UserDataManager sharedUserDataManager].userData.Utotal_Free  = [NSString stringWithFormat:@"%ld",(long)ye];
            [self cancelBuyView];
        }
            break;
            // 关注
        case REQ_FAV:{
            isFav = !isFav;
            if (isFav) {
                // 关注成功
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav_h.png"] forState:UIControlStateNormal];
                [self showProgressWithString:@"关注成功" hiddenAfterDelay:1];

            }else{
                // 取关成功
                [_favBtn setImage:[UIImage imageNamed:@"Public_Fav.png"] forState:UIControlStateNormal];
                [self showProgressWithString:@"取消关注成功" hiddenAfterDelay:1];

            }
        }
            break;
            // 余额
        case REQ_GETBALANCE_FREE:{
            [UserDataManager sharedUserDataManager].userData.Utotal_Free  = [resultDict objectForKey:RESP_CONTENT];
            _bgHiddenBtn.hidden = NO;
            if (_buyDetilView) {
                [_buyDetilView removeFromSuperview];
                _buyDetilView = nil;
            }
            _buyDetilView = [[GoodsDetilView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
            _buyDetilView.delegate = self;
            _buyDetilView.dnode = _goodsDetailNode;
            if (_goodsDetailNode.sku != nil && _goodsDetailNode.sku.count != 0) {
                SkuNode *skuNode = [_goodsDetailNode.sku objectAtIndex:0];
                skuID = [skuNode.sid integerValue];
            }
        
            if (isINLocal) {
                NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:GOODSBUY_ADDRESS];
                
                _buyDetilView.addressLab.text = address;
            }
            _buyDetilView.backgroundColor = [UIColor clearColor];
            [_buyDetilView showInView:self.view];

        }
            break;
            // 是否实名
        case REQ_ISREALNAME:{
            NSDictionary *infoDict =[resultDict objectForKey:RESP_CONTENT];
            NSInteger realy = [[infoDict objectForKey:@"realy"] integerValue];
            if (realy == 1) {
                // 可以兑换
                [self goToBuyView];
            }else{
                AddBankViewController *bankV = [[AddBankViewController alloc] init];
                [self.navigationController pushViewController:bankV animated:YES];
            }
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
        case REQ_GOODSBUY_DETAIL:
            // 随心兑兑换
        case REQ_GOODSBUY_BUY:
            // 关注失败
        case REQ_FAV:
            // 是否实名
        case REQ_ISREALNAME:
{
            [self showProgressWithString:msg hiddenAfterDelay:1];

        }
            break;
                  // 获取余额
        case REQ_GETBALANCE_FREE:{
            [self showProgressWithString:@"网络请求失败" hiddenAfterDelay:1];

        }
            break;
        default:
            break;
    }
    

}


//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:GOODSBUY_ADDRESS];
    if (![address isEqualToString:@"请选择"]) {
        isINLocal = YES;
        _buyDetilView.addressLab.text = address;
        _buyDetilView.addressLab.textAlignment = NSTextAlignmentLeft;

    }else{
        _buyDetilView.addressLab.textAlignment = NSTextAlignmentRight;

    }
}


#pragma mark - LXActivityDelegate-- 分享

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"========= %d",(int)imageIndex);
    int i = (int)imageIndex ;
    switch (i) {
        case 0 :{
            [app sharePhotoToWeixinFriends:_shareImgView.image description:_goodsDetailNode.desc title:_goodsDetailNode.name webpageUrl:WEB_ADDRESS];
        }
            
            break;
            // 分享到微信朋友圈
        case 1 :{
            
            [app sharePhotoToWeixin:_shareImgView.image description:[self shareText] scene:1 webpageUrl:WEB_ADDRESS];
        }
            
            break;
            // 分享到短信
        case 2 :
            [app showSMSPicker:[self shareText] webpageUrl:WEB_ADDRESS];
            break;
        default:
            break;
    }
}

/**   函数名称 :shareText
 **   函数作用 :TODO:分享的字迹
 **   函数参数 :
 **   函数返回值:
 **/
- (NSString *)shareText
{
    //    NSString *shareString = [NSString stringWithFormat:SHARE_TEXT,@"测试",ProjectURL];
    
    NSString *shareString = [NSString stringWithFormat:@"%@%@",_goodsDetailNode.name,_goodsDetailNode.desc];
    return shareString;
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}
@end
