//
//  SystemStateManager.m
//  FD
//
//  Created by Leo xu on 10/25/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

#import "SystemStateManager.h"
//#import "VersionNode.h"
#import "UserDataManager.h"
//#import "iflyMSC/IFlySpeechConstant.h"
//#import "iflyMSC/IFlySpeechUtility.h"
//#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "MyModelSwitchNode.h"
#import "OpenAdNode.h"


SystemStateManager *systemStateManager;
//    EducationBookStore://?data=username:824,password:123456,source:Education

NSString * const key_sourceApp_username = @"username";
NSString * const key_sourceApp_password = @"password";
NSString * const key_sourceApp_source = @"source";
NSString * const key_standBox_3GhasImg = @"3gHasImg";
NSString * const key_standBox_PushOn = @"PushOn";

@implementation SystemStateManager

-(id)init
{
    if (self = [super init]) {
        _httpManager = [[HTTPManager alloc]init];
        _httpManager.delegate = self;
        [self addObserver:self forKeyPath:@"netWorkEnable" options:NSKeyValueObservingOptionNew context:nil];
        //        [self setSourceAppUrl:[NSURL URLWithString:@"Education://source=EducationBookStore"]];
        self.windowSize =  [ UIScreen mainScreen ].bounds.size;
        
        int cacheSizeMemory = 1*1024*1024; // 4MB
        int cacheSizeDisk = 32*1024*1024; // 32MB
        NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
        [NSURLCache setSharedURLCache:sharedCache];
        
        //3G有无图
        NSString *hasImg = [[NSUserDefaults standardUserDefaults] objectForKey:key_standBox_3GhasImg];
        if(hasImg)
        {
            _is3GHasImage = [hasImg boolValue];
        }
        else
        {
            self.is3GHasImage = YES;
            
        }
        
        
        NSString *pushOn = [[NSUserDefaults standardUserDefaults] objectForKey:key_standBox_PushOn];
        if (pushOn) {
            _pushOn = [pushOn boolValue];
        }
        else
        {
            _pushOn = YES;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:key_standBox_PushOn];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [self netWorkStartListening];
        //        [self checkModel];
        [self checkApp];
    }
    return self;
}

-(void)dealloc
{
    [_root release];
    [_mainBoard release];
    [_statusBarColor release];
    [_SourceAppUrl release];
    [_sourceAppDict release];
    _httpManager.delegate = nil;
    [_httpManager release];
    
    [_versionUrl release];
    [_iFlySpeechSynthesizer release];
    //    Block_release(_completedBlock);
    Block_release(_progressBlock);
    [arrayToRead release];
    
    [self removeObserver:self forKeyPath:@"netWorkEnable"];
    [super dealloc];
}

//TODO:设置3G是否有图
-(void)setIs3GHasImage:(BOOL)is3GHasImage
{
    _is3GHasImage = is3GHasImage;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:is3GHasImage] forKey:key_standBox_3GhasImg];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setSourceAppUrl:(NSURL *)appUrl
{
    if (_SourceAppUrl == appUrl) return;
    [_SourceAppUrl release];
    _SourceAppUrl = [appUrl retain];
}

//TODO:获取单例
+ (SystemStateManager *)sharedSystemStateManager
{
    if (!systemStateManager) {
        systemStateManager = [[SystemStateManager alloc] init];
        systemStateManager.systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        systemStateManager.isIOS7 = IOS7;
        systemStateManager.isIphone5 = iPhone5;
    }
    return systemStateManager;
}

//TODO:销毁单例
+(void)destory
{
    [systemStateManager release];
    systemStateManager = nil;
}

//TODO:获取xib名
+(NSString *)xibNameWithControllerClass:(NSString *)className
{
    NSString *xibName = className;
    if ([[SystemStateManager sharedSystemStateManager] isIphone5]) {
        xibName = [NSString stringWithFormat:@"%@-iphone5",className];
    }
    return xibName;
}

//APP跳转
-(BOOL)openURL:(NSURL *)url
{
    NSString *openUrl = nil;
    if (url) {
        openUrl = url.absoluteString;
        NSArray *attributes = [openUrl componentsSeparatedByString:@"EducationBookStore://"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (attributes && attributes.count >= 2) {
            NSString *attribute = [attributes lastObject];
            NSArray *subAttributes = [attribute componentsSeparatedByString:@","];
            if (subAttributes && subAttributes.count) {
                for (NSString * subAttribute in subAttributes) {
                    NSArray *propertys = [subAttribute componentsSeparatedByString:@":"];
                    if (propertys && propertys.count>=2) {
                        NSString *key = [propertys objectAtIndex:0];
                        NSString *value = [propertys objectAtIndex:1];
                        [dict setObject:value forKey:key];
                    }
                }
            }
        }
        
        if (dict.allKeys.count) {
            self.sourceAppDict = dict;
            NSString *souceApp = [dict objectForKey:key_sourceApp_source];
            if (souceApp) {
                [self setSourceAppUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@://source=EducationBookStore",souceApp]]];
                self.isOpenFromOtherApp = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:Key_notify_refreshBackBtn object:nil];
            }
            NSString *userName = [dict objectForKey:key_sourceApp_username];
            NSString *passWord = [dict objectForKey:key_sourceApp_password];
            [[UserDataManager sharedUserDataManager] clearUserData];
            UserData *userdata = [[UserData alloc] init];
            userdata.UName = userName;
            userdata.UPassWord = passWord;
            [UserDataManager sharedUserDataManager].userData = userdata;
            [[UserDataManager sharedUserDataManager] saveUserInfo];
            if (userName && passWord) {
                [[UserDataManager sharedUserDataManager] loginWithSavedData];
            }
            [userdata release];
        }
    }
    return YES;
}

//TODO:App跳回
-(void)jumpBackToSourceApp
{
    if (_SourceAppUrl) {
        
        if (![[UIApplication sharedApplication] canOpenURL:_SourceAppUrl]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"尚未安装教学平台" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        };
        
        [[UIApplication sharedApplication] openURL:_SourceAppUrl];
    }
}

//TODO:获取系统版本
- (float)getSystemVersion
{
    return _systemVersion;
}
//TODO:获取屏幕尺寸
-(CGSize)windowSize
{
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            return CGSizeMake(_windowSize.height, _windowSize.width);
            break;
        default:
            return _windowSize;
            break;
    }
}

//TODO:开始网络监测
- (void)netWorkStartListening
{
    //获取网络管理器
    MHNetWorkListenner * manager = [MHNetWorkListenner sharedManager];
    
    //设置网络管理器代理
    manager.delegate = self;
    
    //开始检测网络
    if (![manager startNetWorkeWatch])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NETWORKSTATUS_DISCONNECT object:nil];
    }
}

//TODO:是否在2G网络下
- (BOOL)isNetWorkIn2Gor3G
{
    return netWorkEnable && netWorkIn2Gor3G;
}
//TODO:是否有网络
- (BOOL)isNetWorkEnable
{
    return netWorkEnable;
}

//TODO:是否是IPhone5
- (BOOL)isIphone5
{
    return _isIphone5;
}
//TODO:是否是IOS7
- (BOOL)isIOS7
{
    return _isIOS7;
}

//TODO:隐藏或者显示tabbar
-(void)hiddenIndexBar:(BOOL)hidden WithAnimotion:(BOOL)animotion
{
    //    [_root hiddenIndexBar:hidden WithAnimotion:animotion];
}

//TODO:跳转至某索引位置页面
-(void)tabBarJumpToViewWithIndex:(int)index
{
    //    [_root jumpToViewWithIndex:index];
}

//TODO:设置状态条颜色
-(void)setStatusBarColor:(UIColor *)color
{
    if(!color) return;
    [_statusBarColor release];
    _statusBarColor = [color retain];
    //    [_root setStatusBarColor:color];
}

//TODO:获取状态条颜色
-(UIColor *)statusBarColor
{
    return _statusBarColor;
}

//TODO:隐藏显示状态条
-(void)hiddenStatusBar:(BOOL)hidden
{
    if (_isIOS7) {
            [_root setstateBarHidden:hidden];
    }
    else
        [[UIApplication sharedApplication] setStatusBarHidden:hidden];
}

//TODO:设置状态条样式
-(void)setstatusBarLight
{
    if (_isIOS7) [_root setStateBarLight];
}
-(void)setstatusBarDark;
{
    if (_isIOS7) [_root setStateBarDark];
}


//TODO:显示progress
-(void)showProgressWithString:(NSString *)string hiddenAfterDelay:(float)delay
{
    self.progressView.mode = MBProgressHUDModeText;
    self.progressView.labelText = string;
    self.progressView.minSize = HUD_LABEL_SIZE;
    [self.progressView.superview bringSubviewToFront:self.progressView];
    [self.progressView show:YES];
    [self.progressView hide:YES afterDelay:delay];
}


//TODO:重置首页位置
-(void)resetMainViewFrame
{
    //    [_root resetViewsFrame];
}


#pragma mark ====JPush=======
//TODO:推送初始化
-(void)JPushInit:(NSDictionary *)launchOptions;
{
    if (_pushOn) {
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)];
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                                              UIRemoteNotificationTypeSound |
                                                                              UIRemoteNotificationTypeAlert)];
    }
    [APService setupWithOption:launchOptions];
}
//TODO:设置推送标签,数组里为tag字符串
-(void)setJPushTag:(NSSet *)tags
{
    [APService setTags:tags callbackSelector:@selector(tagsAliasCallback:tags:alias:)  object:self];
}
//TODO:设置推送别名
-(void)setJpushAlias:(NSString *)alias
{
    [APService setAlias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}


//TODO:设置别名和标签的callback
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

//推送开关
-(void)setPushOn:(BOOL)pushOn
{
    _pushOn = pushOn;
    if (pushOn) {
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)];
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                                               UIRemoteNotificationTypeSound |
                                                                               UIRemoteNotificationTypeAlert)];
    }
    else
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_pushOn] forKey:key_standBox_PushOn];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




#pragma mark ====netWorkListener delegate=======

//TODO:网络可以用
- (void) netWorkStatusWillEnabled {
    NSLog(@"netWorkStatusWillEnabled"); //用处不大
    netWorkEnable = YES;
}

//TODO:wifi可用
- (void) netWorkStatusWillEnabledViaWifi {
    NSLog(@"netWorkStatusWillEnabledViaWifi"); //wifi
    netWorkEnable = YES;
    netWorkIn2Gor3G = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:NETWORKSTATUS_INWIFI object:nil];
}

//TODO:3G or 2G可用
- (void) netWorkStatusWillEnabledViaWWAN {
    NSLog(@"netWorkStatusWillEnabledViaWWAN"); //3G or 2G
    netWorkEnable = YES;
    netWorkIn2Gor3G = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:NETWORKSTATUS_IN2GOR3G object:nil];
}

//TODO:网络不可用
- (void) netWorkStatusWillDisconnection {
    netWorkEnable = NO;
    netWorkIn2Gor3G = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:NETWORKSTATUS_DISCONNECT object:nil];   //无网络
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"netWorkEnable"])
    {
        if (netWorkEnable==YES) {
            [self checkVersion];
        }
    }
}

//TODO:检查版本信息
-(void)checkVersion
{
    if (self.isVersionChecked) {
        return;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_VERSION],REQ_CODE, nil];
    [self.httpManager sendReqWithDict:dict];
}

//TODO:检查模式
-(void)checkModel
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MODEL],REQ_CODE,@"zsjs00129",@"reqCode", nil];
    [self.httpManager sendReqWithDict:dict];
}

-(void)checkApp
{
    //    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_APPCONTROL],REQ_CODE,@"zsjs00133",@"reqCode", nil];
    //    [self.httpManager sendReqWithDict:dict];
    UILabel *lab = [[UILabel alloc] init];
    lab.backgroundColor = [UIColor clearColor];
    
    lab.text = @"6p";
    if (iPhoneWidth == 320) {
        if (iPhoneHeight < 500) {
            lab.text = @"4";
        }else{
            lab.text = @"5";
            
        }
    }else{
        if (iPhone6) {
            lab.text = @"6";
            
        }
        if (iPhoneHeight > 700 && iPhoneWidth > 400 && iPhoneWidth < 420) {
            lab.text = @"6p";
            
        }
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_LOADINGAD] forKey:REQ_CODE];
    [dict setObject:lab.text forKey:@"type"];
    [self.httpManager sendReqWithDict:dict];
}

-(void)requestFinished:(NSDictionary *)resultDict
{
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
        case REQ_VERSION:
        {
            NSDictionary *dict = [resultDict objectForKey:RESP_CONTENT];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:VERSION_NEWS];
            
            NSString *version = [dict objectForKey:@"version"];
            float ver = [version floatValue];
            NSString *nowVers = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            float nowVer = [nowVers floatValue];
            
            if (ver > nowVer) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您当前版本比较低，是否更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                [alertView show];
            }
        }
            break;
        case REQ_LOADINGAD:
        {
            NSMutableArray *arrs = [resultDict objectForKey:RESP_CONTENT];
            NSLog(@"arrs is ======== %@",arrs);
            
            if (arrs.count>0) {
                //                NSString *key = (iPhone5)?@"url5":@"url4";
                //                NSString *url = [dict objectForKey:key];
                OpenAdNode *node = [arrs objectAtIndex:0];
                NSString *url = node.src;
                
                [[NSUserDefaults standardUserDefaults] setObject:url forKey:k_ApplicationLoadinAD];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        }
            break;
        case REQ_MODEL:
        {
            NSDictionary *dict = [resultDict objectForKey:RESP_CONTENT];
            if (dict) {
                NSString *modeFlag = [dict objectForKey:@"flag"];
                [[NSUserDefaults standardUserDefaults] setObject:modeFlag forKey:k_ApplicationModelFlag];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:k_ApplicationModelFlag object:nil];
            }
            
        }
            break;
        case REQ_APPCONTROL:
        {
            NSArray *array = [resultDict objectForKey:RESP_CONTENT];
            NSMutableArray *modelsArr = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                MyModelSwitchNode *modelSwitch = [[MyModelSwitchNode alloc] initWithDict:dict];
                [modelsArr addObject:modelSwitch];
            }
            
            //            [Config currentConfig].myModelSwitchList = modelsArr;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:k_ApplicationModelFlag object:nil];
        }
            break;
        default:
            break;
    }
}

-(void)requestFailed:(NSDictionary *)errorDict
{
    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
            
        case REQ_VERSION:
        {
            NSLog(@"获取列表失败");
        }
        default:
            break;
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        NSURL *url = [NSURL URLWithString:self.versionUrl];
        [[UIApplication sharedApplication]openURL:url];
        exit(0);
    }
    
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"更新"]) {
        NSDictionary *verDict = [[NSUserDefaults standardUserDefaults] objectForKey:VERSION_NEWS];
        NSString *upDatastr = [verDict objectForKey:@"url"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:upDatastr]];
        
    }
    
}



#define APPID_VALUE @"53cf487b"
#define TIMEOUT_VALUE         @"20000"            // timeout      连接超时的时间，以ms为单位





//TODO:进度
-(void)onSpeakProgress:(int)progress
{
    if (_progressBlock) {
        _progressBlock(progress);
    }
    
    NSLog(@"%d",progress);
    
}


//TODO:是否是首次打开应用
- (BOOL)isFirstLaunch
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
}

-(MBProgressHUD *) showHud:(id<MBProgressHUDDelegate>) delegate title:(NSString *) title  selector:(SEL) selector arg:(id) arg  targetView:(UIView *)targetView
{
    MBProgressHUD *hud = [[[MBProgressHUD alloc] initWithView:targetView] autorelease];
    [targetView addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.delegate = delegate;
    hud.labelText = title;
    [hud showWhileExecuting:selector
                   onTarget:delegate
                 withObject:arg
                   animated:YES];
    return hud;
}

-(void)archiverModel:(id)model filePath:(NSString *)filePath
{
    NSMutableData *archiverData=[[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    [archiver encodeObject:model forKey:@"Data"];
    [archiver finishEncoding];
    BOOL flag=[archiverData writeToFile:filePath atomically:NO];
    if(!flag)
    {
        NSLog(@"归档失败");
    }
    [archiver release];
    [archiverData release];
}

-(id)unArchiverModel:(NSString *)filePath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath])
    {
        NSLog(@"反归档的路径不存在:%@",filePath);
        return nil;
    }
    
    NSData *unArchiverData=[[NSData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:unArchiverData];
    id model=[unarchiver decodeObjectForKey:@"Data"];
    [unarchiver finishDecoding];
    [unarchiver release];
    [unArchiverData release];
    return model;
}

//TODO:获取缓存大小
-(NSInteger)getCacheSize
{
    NSInteger size = 0;
    //图像缓存
    size += [[SDImageCache sharedImageCache ]getSize];
    //文件缓存
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachePath = [NSString stringWithFormat:@"%@/Cache/", cachesDirectory];
    size += [self folderSizeAtPath:cachePath];
    //    [MHFile getCacheFilePath:<#(NSString *)#>]
    
    return size;
}


//TODO:单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//TODO:遍历文件夹获得文件夹大小
- (NSInteger) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    NSInteger folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

//TODO:获取缓存大小字符串
-(NSString *)getCacheSizeStr
{
    NSInteger size = [self getCacheSize];
    if (size < 1024) {
        return [NSString stringWithFormat:@"%ld Byte",(long)size];
    }
    else if (size < 1024 * 1024)
    {
        return [NSString stringWithFormat:@"%.2f KB",(float)size/1024.0];
    }
    else if (size < 1024 * 1024 * 1024)
    {
        return [NSString stringWithFormat:@"%.2f MB",(float)size/(1024.0*1024.0)];
    }
    else
        return [NSString stringWithFormat:@"%.2f GB",(float)size/(1024.0*1024.0*1024.0)];
    return nil;
}
//清空缓存
-(void)clearCache
{
    //图片缓存
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    //列表文件缓存
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachePath = [NSString stringWithFormat:@"%@/Cache/", cachesDirectory];
    [MHFile removeDirByPath:cachePath];
}


//TODO:请求开机广告
-(void)reqLoadingImage
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_LOADINGAD] forKey:REQ_CODE];
    NSString *itype;
    itype = @"6p";
    
    if (iPhoneHeight < 500) {
        itype = @"4";
    }
    if (iPhone5) {
        itype = @"5";
        
    }
    if (iPhone6) {
        itype = @"6";
        
    }
    if (iPhoneHeight > 700 && iPhoneWidth > 400 && iPhoneWidth < 420) {
        itype = @"6p";
        
    }
    [dict setObject:itype forKey:@"type"];
    
    [self.httpManager sendReqWithDict:dict];
}
//TODO:获得当前版本
- (void)getNowVer{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_VERSION],REQ_CODE, nil];
    [self.httpManager sendReqWithDict:dict];
}



@end
