//
//  SystemStateManager.h
//  FD
//
//  Created by Leo xu on 10/25/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

//!!!!:系统数据与控制区

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MLNavigationController.h"
#import "MBProgressHUD.h"
#import "HTTPManager.h"
//#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "APService.h"
#import "FontDefine.h"
//#import "LXActivity.h"


@class IFlySpeechSynthesizer;

const static int Index_Bar_Height = 57;
static NSString *const Key_notify_refreshBackBtn = @"refreshBackBtn";
static NSString *const k_ApplicationLoadinAD = @"applicationLoadingAD";
static NSString *const k_ApplicationModelFlag = @"applicationModelFlag";

//TODO:播放回调
typedef void(^onSpeakProgress) (int progress);
typedef void(^StartSpeak) ();
typedef void(^WillStartSpeak) ();
//typedef void(^speakCompleted) (IFlySpeechError *error, BOOL stop);

@interface SystemStateManager : NSObject <MHNetWorkListennerDelegate,HTTPManagerDelegate,UIAlertViewDelegate>
{
    BOOL netWorkEnable;
    BOOL netWorkIn2Gor3G;
    UIColor *_statusBarColor;
    NSURL *_SourceAppUrl;
    IFlySpeechSynthesizer *_iFlySpeechSynthesizer;
    
    NSArray *arrayToRead;
    int _playControl;
}

@property (nonatomic, assign) float systemVersion;
@property (nonatomic, assign) BOOL isIphone5;
@property (nonatomic, assign) BOOL isIOS7;
@property (nonatomic, assign) BOOL isOpenFromOtherApp;
//3G有无图
@property (nonatomic, assign) BOOL is3GHasImage;
@property (nonatomic, retain) MLNavigationController *root;
@property (nonatomic, retain) MBProgressHUD *progressView;
@property (nonatomic, retain) NSDictionary *sourceAppDict;
@property (nonatomic, retain) HTTPManager *httpManager;
@property (nonatomic, assign) BOOL isVersionChecked;
@property (nonatomic, retain) NSString *versionUrl;
@property (nonatomic, assign) CGSize windowSize;
@property (nonatomic, retain) UIStoryboard *mainBoard;
@property (nonatomic, copy) onSpeakProgress progressBlock;
@property (nonatomic, copy) StartSpeak startBlock;
@property (nonatomic, copy) WillStartSpeak willStartBlock;
//@property (nonatomic, copy) speakCompleted completedBlock;
@property (nonatomic, assign)int currentReading;
@property (nonatomic, assign)BOOL readingStop;
@property (nonatomic, assign) BOOL pushOn;

//TODO:获取单例
+(SystemStateManager *) sharedSystemStateManager;
//TODO:销毁单例
+(void)destory;
//TODO:获取xib名
+(NSString *)xibNameWithControllerClass:(NSString *)className;

//TODO:获取系统版本
- (float)getSystemVersion;
//TODO:是否是首次打开应用
- (BOOL)isFirstLaunch;
//TODO:检查版本
- (void)checkVersion;
//TODO:开始网络监测
- (void)netWorkStartListening;
//TODO:是否在2G网络下
- (BOOL)isNetWorkIn2Gor3G;
//TODO:是否有网络
- (BOOL)isNetWorkEnable;
//TODO:是否是IPhone5
- (BOOL)isIphone5;
//TODO:是否是IOS7
- (BOOL)isIOS7;
//TODO:隐藏或者显示tabbar
-(void)hiddenIndexBar:(BOOL)hidden WithAnimotion:(BOOL)animotion;
//TODO:跳转至某索引位置页面
-(void)tabBarJumpToViewWithIndex:(int)index;
//TODO:设置状态条颜色
-(void)setStatusBarColor:(UIColor *)color;
//TODO:获取状态条颜色
-(UIColor *)statusBarColor;
//TODO:隐藏显示状态条
-(void)hiddenStatusBar:(BOOL)hidden;
//TODO:设置状态条样式
-(void)setstatusBarLight;
-(void)setstatusBarDark;
//TODO:重置首页位置
-(void)resetMainViewFrame;

//TODO:显示progress
-(void)showProgressWithString:(NSString *)string hiddenAfterDelay:(float)delay;
//TODO:App跳转
-(BOOL)openURL:(NSURL *)url;
//TODO:App跳回
-(void)jumpBackToSourceApp;


//TODO:推送初始化
-(void)JPushInit:(NSDictionary *)launchOptions;
//TODO:设置推送标签
-(void)setJPushTag:(NSSet *)tags;
//TODO:设置推送别名
-(void)setJpushAlias:(NSString *)alias;


////TODO:读字符串
//- (void)startReadStringArray: (NSArray *)array currentIndex:(int)index;
////TODO:读字符串
//- (void)startReadString: (NSString *)str;
////TODO:暂停
//- (void)pauseReading;
////TODO:恢复播放
//- (void)resumeReading;
////TODO:停止
//- (void)stopReading;
////TODO:下一个
//- (void)nextReading;
////TODO:上一个
//- (void)preReading;


-(MBProgressHUD *) showHud:(id<MBProgressHUDDelegate>) delegate title:(NSString *) title  selector:(SEL) selector arg:(id) arg  targetView:(UIView *)targetView;

//传入路径和列表进行归档和反归档
-(void)archiverModel:(id)model filePath:(NSString *)filePath;
-(id)unArchiverModel:(NSString *)filePath;

////TODO:显示分享界面
//- (void)showShareView;
//获取缓存大小
-(NSInteger)getCacheSize;
-(NSString *)getCacheSizeStr;
//清空缓存
-(void)clearCache;
//TODO:请求开机广告
-(void)reqLoadingImage;
- (void)getNowVer;// 获得当前版本



@end
