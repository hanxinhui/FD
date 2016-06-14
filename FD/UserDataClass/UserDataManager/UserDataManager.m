//
//  UserDataManager.m
//  FD
//
//  Created by zhhua on 10/15/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

#import "UserDataManager.h"
#import "LoginViewController.h"
#import "FontDefine.h"
#import "SvUDIDTools.h"


#define USERDATA_SANDBOX   @"userdata_sandbox"
#define USERDATA_NAME      @"userdata_name"
UserDataManager *userDataManager;

@implementation UserDataManager

-(id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogOut) name:USER_DID_LOG_OUT object:nil];
        _logViewArray = [[NSMutableArray alloc] init];
        _httpManager = [[HTTPManager alloc]init];
        _httpManager.delegate = self;
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_DID_LOG_OUT object:nil];
    [_userData release];
    [_logViewArray release];
    [_httpManager release];
    [_locationArray release];
    [_indexDict release];
    [super dealloc];
}


//TODO:获取单例
+(UserDataManager *) sharedUserDataManager
{
    if (!userDataManager) {
        userDataManager = [[UserDataManager alloc] init];
        [userDataManager loadUserData];
    }
    return userDataManager;
}
//TODO:销毁单例
+(void)destory
{
    [userDataManager release];
    userDataManager = nil;
}

#pragma mark ====== data ===============
//TODO:读取用户数据
-(void)loadUserData
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:USERDATA_SANDBOX];
    self.userData = [UserData userDataWithForm:dict];
    if(self.userData && self.userData.UID)
    {
        [[SystemStateManager sharedSystemStateManager] setJpushAlias:[NSString stringWithFormat:@"%ld",(long)self.userData.UID]];
    }else{
        [[SystemStateManager sharedSystemStateManager] setJpushAlias:nil];

    }
}
//TODO:存储用户数据
-(void)saveUserInfo:(UserData *)userData
{
    [[NSUserDefaults standardUserDefaults] setObject:[userData dictFromUserData]  forKey:USERDATA_SANDBOX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//TODO:存储用户数据
-(void)saveUserInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:_userData.UName forKey:USERDATA_NAME];

    [[NSUserDefaults standardUserDefaults] setObject:[_userData dictFromUserData]  forKey:USERDATA_SANDBOX];
    [[NSUserDefaults standardUserDefaults] setObject:_userData.UName forKey:USERDATA_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if(self.userData && self.userData.UID)
    {
        [[SystemStateManager sharedSystemStateManager] setJpushAlias:[NSString stringWithFormat:@"%ld",(long)self.userData.UID]];
    }else{
        [[SystemStateManager sharedSystemStateManager] setJpushAlias:nil];
        
    }
    
}
//TODO:清除用户数据
-(void)clearUserData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERDATA_SANDBOX];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.userData = nil;
    [[SystemStateManager sharedSystemStateManager] setJpushAlias:nil];

}

//TODO:获取用户数据
-(UserData *)getUserData
{
    return self.userData;
}

//TODO:用户是否已经登录
-(BOOL)userIsLogIn
{
    if (self.userData && self.userData.UID) {
        return YES;
    }
    else
        return NO;
}
//保存账号登录
-(void)loginWithSavedData
{
    if (_userData) {
        [self reqLoginWithUserName:_userData.UName password:_userData.UPassWord];
    }
}

//获取保存的用户名
+(NSString *)getSavedUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERDATA_NAME];
}



#pragma mark ====== method ===============
-(void)login
{
    LoginViewController *loginview = [[LoginViewController alloc] init];
    [[SystemStateManager sharedSystemStateManager].root pushViewController:loginview animated:YES];
}


#pragma mark ====== net method ===============
//TODO:登录用户 用户名，密码
-(void)reqLoginWithUserName:(NSString *)userName password:(NSString *)password
{
    NSString *udid = [SvUDIDTools UDID];
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"userPhoneName ======== is %@",userPhoneName);
    if (userPhoneName == nil || userPhoneName.length == 0   || [userPhoneName isEqualToString:@""]){
        userPhoneName = @"";
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_LOGIN],REQ_CODE,userName,@"username",password,@"password",udid,@"udid",userPhoneName,@"subject", nil];
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_LOGIN],REQ_CODE,userName,@"username",password,@"password",userPhoneName,@"subject", nil];
    [self.httpManager sendReqWithDict:dict];
    
    UserData *userData = [[UserData alloc] initWithDict:dict];
    self.userData = userData;
    
    [userData release];
}
//TODO:登录用户 用户名，密码
-(void)reqLoginAgainWithUserName:(NSString *)userName password:(NSString *)password
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_LOGIN_AGAIN],REQ_CODE,userName,@"username",password,@"password", nil];
    [self.httpManager sendReqWithDict:dict];
    
//    UserData *userData = [[UserData alloc] initWithDict:dict];
//    self.userData = userData;
//    
//    [userData release];
}


//TODO:注册用户 手机，密码，type 2
-(void)reqRegisterWithPhoneNum:(NSString *)phoneNum passWord:(NSString *)pd typeP:(NSString *)typeP{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_REGISTER] forKey:REQ_CODE];
//    NSString *udid = [SvUDIDTools UDID];

    [dict setObject:phoneNum forKey:@"mobile"];
    [dict setObject:pd forKey:@"password"];
//    [dict setObject:udid forKey:@"udid"];
    [dict setObject:@"2" forKey:@"type"];
    [self.httpManager sendReqWithDict:dict];
}

//TODO:修改登陆密码
-(void)ModifyLoginPD:(NSString *)oldPD npassword:(NSString *)npassword{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MODIFY_LOGINPWD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:oldPD forKey:@"old"];
    [dict setObject:npassword forKey:@"new"];
    [self.httpManager sendReqWithDict:dict];
}

//TODO:修改手机号
-(void)ModifyPhone:(NSString *)ver phone:(NSString *)num{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MODIFY_PHONE] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:[UserDataManager sharedUserDataManager].userData.UPhone forKey:@"old"];
    [dict setObject:ver forKey:@"verify"];
    [dict setObject:num forKey:@"new"];
    [[NSUserDefaults standardUserDefaults] setObject:num forKey:MODIFY_PHONE];
    [self.httpManager sendReqWithDict:dict];
}

//TODO:修改支付密码
-(void)ModifyPayPD:(NSString *)ver password:(NSString *)password{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_MODIFY_PAYPWD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:ver forKey:@"verify"];
    [dict setObject:password forKey:@"pwd"];

    [self.httpManager sendReqWithDict:dict];
}

//TODO:注册成功
- (void)doRegisterDone:(UserData *)userData
{
//    userData.UPassWord = self.userData.UPassWord;
    self.userData = userData;

    [self saveUserInfo];


    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_RES_IN object:nil];
}

//TODO:登录成功
- (void)doLoginDone:(UserData *)userData
{
//    NSLog(@"self.userData.UPassWord is ==+== %@",self.userData.UPassWord);
    userData.UPassWord = self.userData.UPassWord;
    [[NSUserDefaults standardUserDefaults] setObject:self.userData.UPassWord forKey:SAVE_USER_PASSWORD];

    self.userData = userData;
    [[NSUserDefaults standardUserDefaults] setObject:self.userData.UPhone forKey:SAVE_USER_PHONE];
    
    [self saveUserInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOG_IN object:nil];
}
//TODO:登录成功
- (void)doLoginAgainDone:(UserData *)userData
{
//    NSLog(@"self.userData.UPassWord is ==+== %@",self.userData.UPassWord);
    userData.UPassWord = self.userData.UPassWord;
    [[NSUserDefaults standardUserDefaults] setObject:self.userData.UPassWord forKey:SAVE_USER_PASSWORD];
    
    self.userData = userData;
    [[NSUserDefaults standardUserDefaults] setObject:self.userData.UPhone forKey:SAVE_USER_PHONE];
        [self saveUserInfo];
}

//TODO:获取用户信息成功
- (void)doGetUserInfoDone:(UserData *)userData
{
    
    self.userData = userData;
    [self saveUserInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_GETUSERINFO_SUCCESS object:nil];
    
}

//TODO:三方登录成功
- (void)doLoginOtherDone:(UserData *)userData{
//    self.userData = userData;
//    [self saveUserInfo];
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_OTHERLOGIN];
//
//    if ([self.userData.UIsFirst integerValue] == 1) {
//        // 第一次三方登录 绑定手机号
//        [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOG_IN_OTHER_FIRST object:nil];
//
//    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOG_IN object:nil];
//    }
}
//TODO:登录成功
- (void)doChangeInfoDone
{
    [self saveUserInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_INFO_CHANGE object:nil];
}


//TODO:上传头像
- (void)reqChangeHeadImg:(NSData *)avatar{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_EDITHEAD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    [dict setObject:avatar forKey:@"avatar"];
    
    [self.httpManager sendReqWithDict:dict];
}

#pragma mark - 网络回调
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            //登录
        case REQ_LOGIN:
   
        {
            [self doLoginDone:[resultDict objectForKey:RESP_CONTENT]];

        }
            break;
            //重新登录
        case REQ_LOGIN_AGAIN:
            
        {
            [self doLoginAgainDone:[resultDict objectForKey:RESP_CONTENT]];
            
        }
            break;
            
            //注册
        case REQ_REGISTER:
        {
//
            [self doRegisterDone:[resultDict objectForKey:RESP_CONTENT]];


        }
            break;
            // 修改头像成功
        case REQ_EDITHEAD:{
            NSDictionary *imgDict =[resultDict objectForKey:RESP_CONTENT];
//            NSDictionary *imgDictw =[imgDict objectForKey:@"avatar"];
            int x = arc4random() % 100;
            NSString *imgUrl = [NSString stringWithFormat:@"%@?%d",[imgDict objectForKey:@"path"],x];

            self.userData.UAvatar = imgUrl;
            
            [self saveUserInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_HEADIMG_SUCCESS object:nil];
            
        }
            break;
            // 修改手机号
        case REQ_MODIFY_PHONE:{
            self.userData.UPhone = [[NSUserDefaults standardUserDefaults] objectForKey:MODIFY_PHONE];
            [self saveUserInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_PHONE_SUCCESS object:nil];
            
            
        }
            break;
            // 修改登陆密码
        case REQ_MODIFY_LOGINPWD:{
            self.userData.UPassWord = [[NSUserDefaults standardUserDefaults] objectForKey:MODIFY_LPD];
            [self saveUserInfo];

            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_LPD_SUCCESS object:nil];
            
        }
            break;
            // 修改支付密码
        case REQ_MODIFY_PAYPWD:{
            self.userData.PayPassWord = [[NSUserDefaults standardUserDefaults] objectForKey:MODIFY_PPD];
            [self saveUserInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_PPD_SUCCESS object:nil];
            
        }
            break;
        default:
            break;
    }
    
}

// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
//    NSString *msg = [errorDict objectForKey:@"msg"];
    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
            //登录
        case REQ_LOGIN:

        {
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOG_IN_FAIL object:[errorDict objectForKey:RESP_MSG]];
            self.userData = nil;
        }
            break;
            //重新登录
        case REQ_LOGIN_AGAIN:{
            
        }
            break;

            //注册
        case REQ_REGISTER:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOG_IN_FAIL object:[errorDict objectForKey:RESP_MSG]];
            self.userData = nil;
            
        }
            break;
            // 修改头像失败
        case REQ_EDITHEAD:{
            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_HEADIMG_FAILED object:nil];
            
        }
            break;
            // 修改手机号失败
        case REQ_MODIFY_PHONE:{
            NSString *msg = [errorDict objectForKey:RESP_MSG];
            
            if([ShareDataManager getText:msg]){
                msg = @"请求出错";
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_PHONE_FAILED object:msg];
            
        }
            break;
            // 修改登陆密码
        case REQ_MODIFY_LOGINPWD:{
            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_LPD_FAILED object:nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_LPD_FAILED object:errorDict];

        }
            break;
            // 修改支付密码
        case REQ_MODIFY_PAYPWD:{
            [[NSNotificationCenter defaultCenter] postNotificationName:MODIFY_PPD_FAILED object:nil];
            
        }
            break;
        default:
            break;
    }

}


#pragma mark ====== observer ===============

//TODO:用户退出
- (void)userDidLogOut
{
    [self clearUserData];
}

//清空栈
-(void)dissmissViews{
    
}


@end
