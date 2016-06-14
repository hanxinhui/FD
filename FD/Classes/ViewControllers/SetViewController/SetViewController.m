//
//  SetViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SetViewController.h"
#import "ModifyDataViewController.h"
#import "SecurityCenteViewController.h"
#import "AboutViewController.h"
#import "AddressViewController.h"
#import "HelpViewController.h"
#import "ShowViewController.h"
#import "AppDelegate.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "FeedViewController.h"

#define ORIGINAL_MAX_WIDTH iPhoneWidth*2

@interface SetViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>


@end

@implementation SetViewController

//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGE_HEADIMG_FAILED object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGE_HEADIMG_SUCCESS object:nil];
 
    
}
//TODO:初始化导航栏
-(void)initNavBar
{
    

    self.titleLable.text = @"账户设置";
  
    //设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag = 111111;
    self.leftBtn = backBtn;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.titleLable.textColor = [UIColor blackColor];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFailed:) name:CHANGE_HEADIMG_FAILED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFinished) name:CHANGE_HEADIMG_SUCCESS object:nil];

    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];
    
    setHeight = 10;

    [self setMainViewInit];

    // 退出
    UIButton *logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth - 0, 45)];
    logoutBtn.backgroundColor = [UIColor whiteColor];
    [logoutBtn setTitle:@"安全退出" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    logoutBtn.tag = 10008;
    [logoutBtn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:logoutBtn];
    
    _mainScrollView.contentSize = CGSizeMake(iPhoneWidth, setHeight + 60);
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

//TODO:设置界面
- (void)setMainViewInit{
    
    // 头像和会员名
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 80)  btnTag:10000 imgStr:@""];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, setHeight + 10 , 60, 60)];
    _headImageView.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_headImageView];
    _headImageView.layer.masksToBounds=YES;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[UserDataManager sharedUserDataManager].userData.UAvatar] placeholderImage:[UIImage imageNamed:@"Set_head_big.png"]];
//    NSLog(@"4 get Img = ==== %@",[UserDataManager sharedUserDataManager].userData.UAvatar);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    path= [path stringByAppendingString:@"/Headimg.png"];
//
//    [self.headImageView setImage:[UIImage imageNamed:path]];
    _headImageView.layer.cornerRadius=30.0;    //最重要的是这个地方要设成imgview高的一半
    
    //        self.outimgViewCusActivity.layer.borderWidth=1.0;
    

    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setHeight , iPhoneWidth - 140, 80)];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.text = [UserDataManager sharedUserDataManager].userData.Unike;
    _nameLab.textColor = [UIColor blackColor];
    _nameLab.textAlignment = NSTextAlignmentLeft;
    _nameLab.font = [UIFont systemFontOfSize:15];
    [_mainScrollView addSubview:_nameLab];
    
    
    setHeight = setHeight + 90;
//    [self setTheLineImg:setHeight - 10];
 
    // 修改资料
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 50) btnTag:10001 imgStr:@""];
    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"修改资料" setFont:17 setCen:NO];
    
    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight ];

    // 地址管理
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 50) btnTag:10002 imgStr:@""];
    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"地址管理" setFont:17 setCen:NO];

    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight ];

    // 安全中心
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 50) btnTag:10003 imgStr:@""];
    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"安全中心" setFont:17 setCen:NO];

    setHeight = setHeight + 60;
//    [self setTheLineImg:setHeight - 10];

    // 功能介绍
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 50) btnTag:10004 imgStr:@""];
    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"功能介绍" setFont:17 setCen:NO];

    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight ];

    //  帮助与反馈
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 50) btnTag:10005 imgStr:@""];
//    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"帮助与反馈" setFont:17 setCen:NO];
    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"反馈" setFont:17 setCen:NO];

    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight ];

    // 推荐给朋友一起赚钱吧
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 50) btnTag:10006 imgStr:@""];
    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"推荐给朋友一起赚钱吧" setFont:17 setCen:NO];

    setHeight = setHeight + 50;
    [self setTheLineImg:setHeight ];

    // 关于
    [self setTheBtn:CGRectMake(0, setHeight , iPhoneWidth, 50)  btnTag:10007 imgStr:@""];
    [self setTheLab:CGRectMake(20, setHeight , iPhoneWidth, 50) textColor:[UIColor blackColor] labText:@"关于" setFont:17 setCen:NO];

//    [self setTheLineImg:setHeight ];

    setHeight = setHeight + 65;


}


//TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [_mainScrollView addSubview:btn];
    
    
    [self setTheImg:CGRectMake(iPhoneWidth - 40, setHeight +(btn.frame.size.height - 17 )/ 2, 10, 17) imgStr:@"My_right.png" bgColor:[UIColor clearColor]];

}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [_mainScrollView addSubview:imgView];
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
    [_mainScrollView addSubview:lab];
}

//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, sizeY - 1, iPhoneWidth - 20, 4)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
//    imgView.backgroundColor = [UIColor redColor];
    [_mainScrollView addSubview:imgView];
}

#pragma mark ============ UIActionSheet ============


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:点击按钮
- (void)toBtnPressed:(id)sender{
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 修改头像
        case 10000:
        {
            [self editPortrait];

        }
            break;
            // 修改资料
        case 10001:
        {
            ModifyDataViewController *modifyDataViewController = [[ModifyDataViewController alloc] init];
            [self.navigationController pushViewController:modifyDataViewController animated:YES];
            
        }
            break;
            // 地址管理
        case 10002:
        {
            
            AddressViewController *addressViewController = [[AddressViewController alloc] init];
            addressViewController.addressStyle = setAddress;
            addressViewController.isBuyIn = NO;
            [self.navigationController pushViewController:addressViewController animated:YES];
            
        }
            break;
            // 安全中心
        case 10003:
        {
            SecurityCenteViewController *securityCenteViewController = [[SecurityCenteViewController alloc] init];
            [self.navigationController pushViewController:securityCenteViewController animated:YES];
        }
            break;
            
            // 功能介绍
        case 10004:
        {
            ShowViewController *showViewController = [[ShowViewController alloc] init];
            [self.navigationController pushViewController:showViewController animated:YES];
        }
            break;
            // 帮助反馈
        case 10005:
        {
//            HelpViewController *helpViewController = [[HelpViewController alloc] init];
//            [self.navigationController pushViewController:helpViewController animated:YES];
            FeedViewController *feedViewController = [[FeedViewController alloc] init];
            [self.navigationController pushViewController:feedViewController animated:YES];

        }
            break;
            // 推荐
        case 10006:
        {
            [self showShareView];

        }
            break;
            // 关于
        case 10007:
        {
            
            AboutViewController *aboutViewController = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutViewController animated:YES];
        }
            break;
            // 退出
        case 10008:
        {
            [[UserDataManager sharedUserDataManager] clearUserData];
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOG_OUT object:nil];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self showProgressWithString:@"退出成功" hiddenAfterDelay:1];

            [[UserDataManager sharedUserDataManager] clearUserData];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOG_OUT object:nil];

        }
            break;
            // 返回
        case 111111:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

//TODO:上传头像
-(void)sendHeadView{
    [self.progressView show:YES];
    NSData *imgData = UIImageJPEGRepresentation(_headImageView.image, 0.1);
    
    [[UserDataManager sharedUserDataManager] reqChangeHeadImg:imgData];
    
}

//TODO:修改头像失败
- (void)changeFailed:(NSNotification*)notification{
    [self.progressView hide:YES];
    NSString *msg = [notification object];
    if([ShareDataManager getText:msg]){
        msg = @"头像修改失败";
        
    }
//    [_headImageView setImage:nil];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[UserDataManager sharedUserDataManager].userData.UAvatar] placeholderImage:[UIImage imageNamed:@"Set_head_big.png"]];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    path= [path stringByAppendingString:@"/Headimg.png"];
//    
//    [self.headImageView setImage:[UIImage imageNamed:path]];
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}
//TODO:修改头像成功
- (void)changeFinished{
    [self.progressView hide:YES];
    [self showProgressWithString:@"头像修改成功" hiddenAfterDelay:1];
//    NSString *path_sandox = NSHomeDirectory();
//    //设置一个图片的存储路径
//    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/Headimg.png"];
//    [UIImagePNGRepresentation(self.headImageView.image) writeToFile:imagePath atomically:YES];

    
}

//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _nameLab.text = [UserDataManager sharedUserDataManager].userData.Unike;

    
}


#pragma mark - LXActivityDelegate-- 分享

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"========= %d",(int)imageIndex);
    int i = (int)imageIndex ;
    switch (i) {
            // 分享到QQ好友
        case 0 :{
            UIImageView *imgv = [[UIImageView alloc] init];
            [imgv setImage:[UIImage imageNamed:@"icon.png"]];

            [app sharePhotoToWeixinFriends:imgv.image description:SHARE_TEXT title:SHARE_TITLE webpageUrl:WEB_ADDRESS];
        }
            
            
            break;
            // 分享到微信朋友圈
        case 1 :{
            UIImageView *imgv = [[UIImageView alloc] init];
            [imgv setImage:[UIImage imageNamed:@"icon.png"]];
            
            [app sharePhotoToWeixin:imgv.image description:[self shareText] scene:1 webpageUrl:WEB_ADDRESS];
        }
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
    NSString *shareString = [NSString stringWithFormat:@"%@ %@",SHARE_TITLE,SHARE_TEXT];
    return shareString;
}


- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}


#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO 上传头像
        [self sendHeadView];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, (iPhoneHeight - self.view.frame.size.width ) /2, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TODO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_headImageView) {
        CGFloat w = 100.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 2;
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_headImageView.layer setCornerRadius:(_headImageView.frame.size.height/2)];
        [_headImageView.layer setMasksToBounds:YES];
        [_headImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headImageView setClipsToBounds:YES];
        _headImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _headImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _headImageView.layer.shadowOpacity = 0.5;
        _headImageView.layer.shadowRadius = 2.0;
        _headImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        _headImageView.layer.borderWidth = 2.0f;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_headImageView addGestureRecognizer:portraitTap];
    }
    return _headImageView;
}

- (void)editPortrait{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
}
@end
