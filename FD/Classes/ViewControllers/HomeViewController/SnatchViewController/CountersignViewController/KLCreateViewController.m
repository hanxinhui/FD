//
//  WelfareClassifyViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "KLCreateViewController.h"
#import "AppDelegate.h"


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface KLCreateViewController ()


@end

@implementation KLCreateViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    self.dlineImgView.hidden = YES;

    self.titleLable.text = @"暗号抽疯";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT ;
    fsetHeight = setHeight;
    
    setJPX = 0;
    setJPY = fsetHeight;
//    setJPW = (iPhoneWidth - 360 )/ 2;
    setJPH = iPhoneHeight - fsetHeight - 85;
    setJPW = setJPH / 567 *iPhoneWidth;
    setJPX = (iPhoneWidth - setJPW) / 2;
 
    if (setJPH > 567  ){
        if (iPhoneWidth > 360) {
            setJPW = 360;
            setJPH = 567;
            setJPX = (iPhoneWidth - setJPW) / 2;

        }else{
            setJPW = iPhoneWidth;
            setJPX = 0;
            setJPH = iPhoneWidth / 360 *567;
        }
    }
 
    
    // 我的背景
    _mybgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(setJPX, setHeight, setJPW , setJPH)];
    _mybgImgView.backgroundColor = [UIColor lightGrayColor];
    [_mybgImgView setImage:[UIImage imageNamed:@"kl_Share_bg.png"]];
    [self.view addSubview:_mybgImgView];
    
    // 商品图片
    _goodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, setHeight+80, 40, 40)];
    _goodImgView.backgroundColor = [UIColor redColor];
//    [_goodImgView setImage:[UIImage imageNamed:@"kl_Share_bg.png"]];
    [self.view addSubview:_goodImgView];
//    [self.mybgImgView sd_setImageWithURL:[NSURL URLWithString:node.Gthumb] placeholderImage:[UIImage imageNamed:@"list_noImg.png"]];
//
    [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_codeDict objectForKey:@"thumb"]]] placeholderImage:[UIImage imageNamed:@"icon.png"]];

    
    // 商品名称
    _goodsLab = [[UILabel alloc] initWithFrame:CGRectMake(setJPX+70, setHeight+40, 200, 30)];
    _goodsLab.backgroundColor = [UIColor clearColor];
    _goodsLab.text = [_codeDict objectForKey:@"title"];
    _goodsLab.textAlignment = NSTextAlignmentLeft;
    _goodsLab.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_goodsLab];
//    _goodsLab.text = @"asdasdadadas";
    _goodsLab.textColor = UIColorWithRGB(220, 117, 107, 1);

    // 副标题Lab
    _goodsubLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, 200, 30)];
    _goodsubLab.backgroundColor = [UIColor clearColor];
    _goodsubLab.text = [_codeDict objectForKey:@"sub_title"];
    _goodsubLab.textAlignment = NSTextAlignmentLeft;
    _goodsubLab.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:_goodsubLab];
//    _goodsubLab.text = @"asdasdadadas";
    _goodsubLab.textColor = UIColorWithRGB(151, 151, 151, 1);

    // 口令
    _codeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, iPhoneHeight - 200, iPhoneWidth, 50)];
    _codeLab.backgroundColor = [UIColor clearColor];
    _codeLab.text = [_codeDict objectForKey:@"code"];
    _codeLab.textAlignment = NSTextAlignmentCenter;
    _codeLab.font = [UIFont boldSystemFontOfSize:35];
    _codeLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    _codeLab.textColor = [UIColor whiteColor];
    [self.view addSubview:_codeLab];
//    _codeLab.text = @"123456";
    setHeight = setHeight + 40;
    if (iPhoneHeight < 500) {
        _goodImgView.frame = CGRectMake(105, setHeight+27, 30, 30);
        _goodsLab.frame = CGRectMake(138, 134, 75, 20);
        _goodsubLab.frame = CGRectMake(138, 150, 75, 20);
        _codeLab.frame = CGRectMake(0, iPhoneHeight - 173, iPhoneWidth, 50);
        
    }
    if (iPhone5) {
        _goodImgView.frame = CGRectMake(90, setHeight+45, 40, 40);
        _goodsLab.frame = CGRectMake(135, 148, 90, 25);
        _goodsubLab.frame = CGRectMake(135, 170, 90, 25);
        _codeLab.frame = CGRectMake(0, iPhoneHeight - 190, iPhoneWidth, 50);
        
    }
    if (iPhone6 || iPhone6S) {
        _goodImgView.frame = CGRectMake(90, setHeight+70, 40, 40);
        _goodsLab.frame = CGRectMake(135, 170, 150, 25);
        _goodsubLab.frame = CGRectMake(135, 200, 150, 25);
        _codeLab.frame = CGRectMake(0, iPhoneHeight - 210, iPhoneWidth, 50);
        
    }
    if (iPhone6plus || iPhone6Splus) {
        _goodImgView.frame = CGRectMake(100, setHeight+80, 40, 50);
        _goodsLab.frame = CGRectMake(145, 185, 170, 30);
        _goodsubLab.frame = CGRectMake(145, 215, 170, 30);
        _codeLab.frame = CGRectMake(0, iPhoneHeight - 230, iPhoneWidth, 50);
        
    }

    // 底部背景
    UIImageView *dibgImgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - 85, iPhoneWidth, 85)];
    dibgImgView.backgroundColor = [UIColor whiteColor];
    [dibgImgView setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:dibgImgView];
    
    //
    UILabel *dishowLab = [[UILabel alloc] initWithFrame:CGRectMake(30, iPhoneHeight - 85, iPhoneWidth - 60, 30)];
    dishowLab.backgroundColor = [UIColor clearColor];
    dishowLab.text = @"口令图已保存至相册，可自行分享";
    dishowLab.textAlignment = NSTextAlignmentCenter;
    dishowLab.font = [UIFont systemFontOfSize:17];
    dishowLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    dishowLab.textColor = [UIColor blackColor];
    [self.view addSubview:dishowLab];
    
    // 任务列表
//    UIButton *sharebtn = [[UIButton alloc] initWithFrame:CGRectMake(20  , iPhoneHeight - 55, iPhoneWidth - 40, 45)];
    UIButton *sharebtn = [[UIButton alloc] initWithFrame:CGRectMake((iPhoneWidth - 262) /2, iPhoneHeight - 55, 262, 50)];

    sharebtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sharebtn];
    sharebtn.backgroundColor = UIColorWithRGB(253, 204, 57, 1);
    [sharebtn addTarget:self action:@selector(sharePressed) forControlEvents:UIControlEventTouchUpInside];
//    [sharebtn setTitleColor:UIColorWithRGB(254, 212, 108, 1) forState:UIControlStateNormal];
//    [sharebtn setTitle:@"打开微信" forState:UIControlStateNormal];
//    sharebtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    sharebtn.titleLabel.textColor = UIColorWithRGB(239, 0, 42, 1);
    [sharebtn setImage:[UIImage imageNamed:@"share_to_weixin.png"] forState:UIControlStateNormal];

    // 截图
    _screenshotImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth , iPhoneHeight)];
    _screenshotImgView.backgroundColor = [UIColor clearColor];
    
    _screenshotImgView.image = [self screenshot];
    [self saveImageToPhotos];
//    [self.view addSubview:_screenshotImgView];
}




#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    // 返回
    NSArray *ctrlArray = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
    
}



//TODO:截屏
- (UIImage *)screenshot
{
    return [self screenshotWithRect:CGRectMake(setJPX, setJPY, setJPW , setJPH)];
}

- (UIImage *)screenshotWithRect:(CGRect)rect
{
    // Source (Under MIT License): https://github.com/shinydevelopment/SDScreenshotCapture/blob/master/SDScreenshotCapture/SDScreenshotCapture.m#L35
    
    BOOL ignoreOrientation = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGSize imageSize = CGSizeZero;
    CGFloat width = rect.size.width, height = rect.size.height;
    CGFloat x = rect.origin.x, y = rect.origin.y;
    
    //    imageSize = CGSizeMake(width, height);
    //    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    if (UIInterfaceOrientationIsPortrait(orientation) || ignoreOrientation)
    {
        //imageSize = [UIScreen mainScreen].bounds.size;
        imageSize = CGSizeMake(width, height);
        x = rect.origin.x, y = rect.origin.y;
    }
    else
    {
        //imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        imageSize = CGSizeMake(height, width);
        x = rect.origin.y, y = rect.origin.x;
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.view.center.x, self.view.center.y);
    CGContextConcatCTM(context, self.view.transform);
    CGContextTranslateCTM(context, -self.view.bounds.size.width * self.view.layer.anchorPoint.x, - self.view.bounds.size.height * self.view.layer.anchorPoint.y);
    
    // Correct for the screen orientation
    if(!ignoreOrientation)
    {
        if(orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, (CGFloat)M_PI_2);
            CGContextTranslateCTM(context, 0, - self.view.bounds.size.height);
            CGContextTranslateCTM(context, -x, y);
        }
        else if(orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, (CGFloat)-M_PI_2);
            CGContextTranslateCTM(context, -self.view.bounds.size.width, 0);
            CGContextTranslateCTM(context, x, -y);
        }
        else if(orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            CGContextRotateCTM(context, (CGFloat)M_PI);
            CGContextTranslateCTM(context, -self.view.bounds.size.height, -self.view.bounds.size.width);
            CGContextTranslateCTM(context, x, y);
        }
        else
        {
            CGContextTranslateCTM(context, -x, -y);
        }
    }
    else
    {
        CGContextTranslateCTM(context, -x, -y);
    }
    
    //[self layoutIfNeeded];
    
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    else
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark 网络请求
//TODO:获取详情
- (void)reqGetFavList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DETAIL] forKey:REQ_CODE];
//  
//    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
//    [dict setObject:_goodID forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
//    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
//            // 详情
//        case REQ_ANYTIMEBUY_DETAIL:
//        {
//            self.jsonString = [resultDict objectForKey:RESP_CONTENT];
//            
//
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    [self.progressView hide:YES];
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
//    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
//            // 详情
//        case REQ_ANYTIMEBUY_DETAIL:{
//        }
//            break;
//            
//        default:
//            break;
//    }
    
    
}


//TODO:保存到本地相册
- (void)saveImageToPhotos
{
 
    UIImageWriteToSavedPhotosAlbum(_screenshotImgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
 
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        
        msg = @"保存图片失败" ;
      
    }else{
    
        msg = @"保存图片成功" ;
       
    }
 
    [self showProgressWithString:msg hiddenAfterDelay:1];
   
}


//TODO:打开微信
- (void)sharePressed{
    [app openWeixin];
}

@end
