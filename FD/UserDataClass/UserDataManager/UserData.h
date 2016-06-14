//
//  UserData.h
//  FD
//
//  Created by Leo xu on 10/17/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject
//用户ID
@property (nonatomic, assign) NSInteger UID;
//用户名
@property (nonatomic, retain) NSString *UName;
//邮箱
@property (nonatomic, retain) NSString *Uemail;
//手机号码
@property (nonatomic, retain) NSString *UPhone;
//用户头像
@property (nonatomic, retain) NSString *UAvatar;
//昵称
@property (nonatomic, retain) NSString *Unike;
//真实姓名
@property (nonatomic, retain) NSString *RName;
//性别
@property (nonatomic, retain) NSString *Usex;
//生日
@property (nonatomic, retain) NSString *Ubirthday;
//地址
@property (nonatomic, retain) NSString *Uaddr;
//月收入
@property (nonatomic, retain) NSString *Uincome;
//兴趣爱好
@property (nonatomic, retain) NSString *Uinterest;
//类别
@property (nonatomic, retain) NSString *Ustatus;
//总资产
@property (nonatomic, retain) NSString *Utotal;
// 可提现
@property (nonatomic, retain) NSString *Utotal_Free;
// 体验金
@property (nonatomic, retain) NSString *Utotal_Freeze;
// 保证金
@property (nonatomic, retain) NSString *Utotal_Bail;
// 可用保证金
@property (nonatomic, retain) NSString *Utotal_FreeBail;


//今天进账
@property (nonatomic, retain) NSString *UtodayIn;
@property (nonatomic, retain) NSString *UweekIn;//本周进账
@property (nonatomic, retain) NSString *UmouthIn;//本月进账
//一共进账
@property (nonatomic, retain) NSString *UtotalIn;




//登录时间
@property (nonatomic, retain) NSString *UaddTime;

//最后登录时间
@property (nonatomic, retain) NSString *UlastTime;
//msg_num
@property (nonatomic, retain) NSString *Umsg_num;




//用户类型(经理/个人)
@property (nonatomic, retain) NSString *Utype;

//登陆密码
@property (nonatomic, retain) NSString *UPassWord;
//支付密码
@property (nonatomic, retain) NSString *PayPassWord;

//理财产品个数
@property (nonatomic, retain) NSString *Uyy_num;

+(UserData *)userDataWithForm:(NSDictionary *)dict;
+(UserData *)UserDataWithUID:(NSString *)uid Pwd:(NSString *)pwd;
//TODO:数据组成表单
- (NSDictionary *)dictFromUserData;


-(id)initWithDict:(NSDictionary *)dict;
@end
