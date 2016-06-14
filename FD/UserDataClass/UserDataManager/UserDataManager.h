//
//  UserDataManager.h
//  FD
//
//  Created by Leo xu on 10/15/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

//!!!!:用户数据区

#import <Foundation/Foundation.h>
#import "UserData.h"
#import "HTTPManager.h"

@class AddrNode;

@interface UserDataManager : NSObject <HTTPManagerDelegate>
{
    //登录页面堆栈
    NSMutableArray *_logViewArray;
}
@property (nonatomic, retain) UserData *userData;
@property (nonatomic, retain) HTTPManager *httpManager;
//位置信息
@property (nonatomic, retain) NSArray *locationArray;
@property (nonatomic, retain) NSMutableDictionary *indexDict;
+(UserDataManager *) sharedUserDataManager;
+(void)destory;
//获取保存的用户名
+(NSString *)getSavedUserName;

//存储
-(void)saveUserInfo:(UserData *)userData;
-(void)saveUserInfo;
//读取
-(void)loadUserData;
//清除
-(void)clearUserData;
//获取
-(UserData *)getUserData;
//用户是否已经登录
-(BOOL)userIsLogIn;

//用户登录方法
-(void)login;


//清空栈
-(void)dissmissViews;


//TODO:登录用户 用户名，密码
-(void)reqLoginWithUserName:(NSString *)userName password:(NSString *)password;
//TODO:重新登录用户 用户名，密码
-(void)reqLoginAgainWithUserName:(NSString *)userName password:(NSString *)password;

//TODO:注册用户 手机，密码，type 2
-(void)reqRegisterWithPhoneNum:(NSString *)phoneNum passWord:(NSString *)pd typeP:(NSString *)typeP;
//TODO:修改手机号
-(void)ModifyPhone:(NSString *)ver phone:(NSString *)num;
//TODO:修改登陆密码
-(void)ModifyLoginPD:(NSString *)oldPD npassword:(NSString *)npassword;
//TODO:修改支付密码
-(void)ModifyPayPD:(NSString *)ver password:(NSString *)password;

//TODO:上传头像
- (void)reqChangeHeadImg:(NSData *)avatar;

//保存账号登录
-(void)loginWithSavedData;


@end
