//
//  FontDefine.h
//  cardPreferential
//
//  Created by leo xu on 13-4-11.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#ifndef FontDefine_h
#define FontDefine_h
//默认字体
#define defaultFontSize(s) [UIFont systemFontOfSize:s]
#define defaultBoldFontSize(s) [UIFont boldSystemFontOfSize:s]

#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import "MHTool.h"
    #import "ASIHTTPRequest.h"
    #import "ASIFormDataRequest.h"
    #import "UIImageView+WebCache.h"
    #import "SDImageCache.h"
    #import "HTTPKeysDefine.h"
    #import "UserDataManager.h"
    #import "SystemStateManager.h"
    #import "NSObject+Parser.h"
    #import "ShareDataManager.h"
    #import "JSON.h"
#endif


//hud size
#define HUD_SIZE CGSizeMake(150, 50)
#define HUD_LABEL_SIZE CGSizeMake(150, 100)

//颜色
#define UIColorWithRGB(R,G,B,A) [UIColor colorWithRed:(float)R/255.0f green:(float)G/255.0f blue:(float)B/255.0f alpha:(float)A]
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//判断当前设备是否是IOS7
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//判断当前设备是否是iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6Splus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


//判断当前设备是否是IOS7
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


//替代界面宽
#define iPhoneWidth             [UIScreen mainScreen].bounds.size.width
#define iPhoneViewWidth         self.frame.size.width
#define iPhoneViewHeight        self.frame.size.height
#define iPhoneHeight             ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.height - 20)


//头部高
#define NVARBAR_HIGHT           50

// 底部高
#define TARBAR_HIGHT            46
#define TARBAR_HIGHT_PLUS        77


//============通知==============
// 开机抽奖时间
#define TIME_HOME_LAT            @"TIME_HOME_LAT"

//网络状态通知
#define NETWORKSTATUS_INWIFI            @"netWork_in_wifi"
#define NETWORKSTATUS_IN2GOR3G          @"netWork_in_2G_or_3G"
#define NETWORKSTATUS_DISCONNECT        @"netWork_disconnect"

#define USER_DID_RES_IN                 @"userRegister"
#define USER_LOG_IN_FAIL                @"userLogInFail"
#define USER_LOG_IN_CANCEL              @"userLogInCancel"
#define USER_DID_LOG_OUT                @"userLogOut"
#define USER_INFO_CHANGE                @"userinfoChange"
#define USER_INFO_CHANGE_FAIL           @"userinfoChangeFail"
#define USER_FIND_PWD                   @"userFindPwd"
#define USER_FIND_PWD_Fail              @"userFindPwdFail"
#define USER_DID_LOG_IN                 @"userLogIn"// 登录成功
#define CHANGE_HEADIMG_SUCCESS          @"CHANGE_HEADIMG_SUCCESS"// 修改头像成功
#define CHANGE_HEADIMG_FAILED          @"CHANGE_HEADIMG_FAILED"// 修改头像失败

#define MODIFY_PHONE_SUCCESS         @"MODIFY_PHONE_SUCCESS"// 修改手机号成功
#define MODIFY_PHONE_FAILED          @"MODIFY_PHONE_FAILED"// 修改手机号失败
#define MODIFY_PHONE          @"MODIFY_PHONE"// 修改手机号修改

#define MODIFY_LPD_SUCCESS         @"MODIFY_LPD_SUCCESS"// 修改登陆密码成功
#define MODIFY_LPD_FAILED          @"MODIFY_LPD_FAILED"// 修改登陆密码失败
#define MODIFY_LPD          @"MODIFY_LPD"// 登陆密码修改

#define MODIFY_PPD_SUCCESS         @"MODIFY_PPD_SUCCESS"// 修改支付密码成功
#define MODIFY_PPD_FAILED          @"MODIFY_PPD_FAILED"// 修改支付密码失败
#define MODIFY_PPD          @"MODIFY_PPD"// 支付密码修改

#define BANKLIST_RELOAD          @"BANKLIST_RELOAD"// 添加银行卡后刷新

// 随时赚数据保存
#define SAVE_ANYTIMEDO_SCREEN_FIRST          @"SAVE_ANYTIMEDO_SCREEN_FIRST"// 筛选第一条数据记录
#define SAVE_ANYTIMEDO_SCREEN_SECOND          @"SAVE_ANYTIMEDO_SCREEN_SECOND"// 筛选第二条数据记录
#define SAVE_ANYTIMEDO_SCREEN_ISYUE          @"SAVE_ANYTIMEDO_SCREEN_ISYUE"// 是否只看余额
// 随时赚取消筛选通知
#define ANYTIMEDO_SCREEN_CANCEL          @"ANYTIMEDO_SCREEN_CANCEL"




// 搜索任务回调
#define SEARCH_TASK_SUCCESS                @"SEARCH_TASK_SUCCESS"
// 搜索任务本地数据 最多10条
#define SEARCH_TASK_DATA                @"SEARCH_TASK_DATA"
// 关键字
#define SEARCH_TASK_KEY               @"SEARCH_TASK_KEY"

// 搜索商品回调
#define SEARCH_GOODS_SUCCESS                @"SEARCH_GOODS_SUCCESS"
// 搜索商品本地数据 最多10条
#define SEARCH_GOODS_DATA                @"SEARCH_GOODS_DATA"
// 关键字
#define SEARCH_GOODS_KEY               @"SEARCH_GOODS_KEY"


// 评论成功
#define COMMENT__SUCCESS                @"COMMENT__SUCCESS"// 评论成功
// 取消兑换成功
#define CLOSEEXCHANGE__SUCCESS                @"CLOSEEXCHANGE__SUCCESS"

// 任务完成反馈
#define TASKS_HAVEDONE_SUCCESS          @"TASKS_HAVEDONE_SUCCESS"
// 我的任务完成反馈
#define DOMYTASK_SUCCESS          @"DOMYTASK_SUCCESS"

// 个人中心 地区数据
#define PER_CENTER_AREAS    @"PER_CENTER_AREAS"


// 抽疯
//------ 抢宝 ------
// 选择商品成功 回调
#define SELECTGOODS_SUCCESS         @"SELECTGOODS_SUCCESS"
// 微信支付成功
#define WEIXINPAY_SUCCESS         @"WEIXINPAY_SUCCESS"
// 返回我的抢宝刷新界面
#define MYCOUNTERSIGN_RELOAD         @"MYCOUNTERSIGN_RELOAD"

// 设置中奖确认的地址 通知
#define SETADDRSSS_WINNER_DETAIL         @"SETADDRSSS_WINNER_DETAIL"

// 保存选择商品数据
#define SAVE_SELECTGOODS_NODE         @"SAVE_SELECTGOODS_NODE"

// 保存用户密码
#define SAVE_USER_PASSWORD              @"SAVE_USER_PASSWORD"
// 验证密码通过可以修改手机号
#define USERINFO_CANEDITPHONE           @"USERINFO_CANEDITPHONE"
// 保存用户手机
#define SAVE_USER_PHONE                 @"SAVE_USER_PHONE"

// 保存默认选择的省份id
#define SAVE_ADDRESS_PROVINCES_ID        @"SAVE_ADDRESS_PROVINCES_ID"
// 保存默认选择的城市名称
#define SAVE_ADDRESS_CITY_ID            @"SAVE_ADDRESS_CITY_ID"
// 保存默认选择的地区id
#define SAVE_ADDRESS_COUNTY_ID          @"SAVE_ADDRESS_COUNTY_ID"
// 保存默认选择区域名称
#define SAVE_ADDRESS_AREA               @"SAVE_ADDRESS_AREA"
// 保存默认收货名称
#define SAVE_ADDRESS_NAME                @"SAVE_ADDRESS_NAME"
// 保存默认电话名称
#define SAVE_ADDRESS_PHONE               @"SAVE_ADDRESS_PHONE"
// 保存默认地址id
#define SAVE_ADDRESS_ID               @"SAVE_ADDRESS_ID"
// 详细地址
#define SAVE_ADDRESS_ADDR              @"SAVE_ADDRESS_ADDR"


// 兑换时选择地址
#define GOODSBUY_ADDRESS              @"GOODSBUY_ADDRESS"
#define GOODSBUY_ADDRESSID              @"GOODSBUY_ADDRESSID"
// 兑换时选择地址成功
#define GOODSBUY_ADDRESS_SUCCESS          @"GOODSBUY_ADDRESS_SUCCESS"


//重设密码时 保存手机号
#define SAVE_IPHONEFORPW               @"SAVE_IPHONEFORPW"


// 保存我的积分
#define SAVE_MYINTEGRAL             @"SAVE_MYINTEGRAL"

//保存参加活动用户信息
// 姓名
#define SAVE_ACTIVE_NAME                @"SAVE_ACTIVE_NAME"
// 性别
#define SAVE_ACTIVE_SEX                 @"SAVE_ACTIVE_SEX"
// 身份证号码
#define SAVE_ACTIVE_ID                  @"SAVE_ACTIVE_ID"
// 手机号码
#define SAVE_ACTIVE_PHONE               @"SAVE_ACTIVE_PHONE"

// 确认订单 存储收货人
#define SAVE_OREDR_NAME                @"SAVE_OREDR_NAME"
// 确认订单 存储地址
#define SAVE_OREDR_ADDRESS                @"SAVE_OREDR_ADDRESS"
// 确认订单 存储电话
#define SAVE_OREDR_TEL                @"SAVE_OREDR_TEL"
// 确认订单 存储地址id
#define SAVE_OREDR_ADDRESSID                @"SAVE_OREDR_ADDRESSID"


// leoxu add 关于会员登录 2014－05-08
// 登录时间
#define VIP_LOGIN_TIME   @"VIP_LOGIN_TIME"
// 登录账号
#define VIP_LOGIN_CODE   @"VIP_LOGIN_CODE"

// 再次打开应用
#define REOPENAPP       @"REOPENAPP"




// 获得起购金额
#define   GETMINMONEY           @"GETMINMONEY"

#define USER_GETUSERINFO_SUCCESS                @"USER_GETUSERINFO_SUCCESS"// 获取用户信息成功
#define USER_GETUSERINFO_FAIL                @"USER_GETUSERINFO_FAIL"
#define PASSWORD_SAVE_FAILED                 @"PASSWORD_SAVE_FAILED"// 修改密码失败
#define ADD_ADDRESS_SUCCESS                 @"ADD_ADDRESS_SUCCESS"// 添加地址成功

// 充值送钱提示
#define RECHARGEABLE_CLOSE                    @"RECHARGEABLE_CLOSE"


// 经度
#define ADDRESS_LATITUDE                    @"ADDRESS_LATITUDE"
// 纬度
#define ADDRESS_LONGITUDE                   @"ADDRESS_LONGITUDE"

//动画时间
#define kDuration 0.3


// 是否打开手势密码
#define ISOPENGESTURE           @"ISOPENGESTURE"
// 手势输入失败 打开登录
#define ISOPENGESTUREFAIL           @"ISOPENGESTUREFAIL"
// 创建手势成功
#define ISSETGESTURE_SUCCESS           @"ISSETGESTURE_SUCCESS"

// 修改手势失败 打开登录
#define ISMODIFYGESTUREFAIL           @"ISMODIFYGESTUREFAIL"


// 是否提示评分
#define ISSHOW_SCORE          @"ISSHOW_SCORE"
#define ISSHOW_SCORE_SUCCESS        @"ISSHOW_SCORE_SUCCESS"
// 版本号
#define VersionNow          @"1.0"
// 项目名称
#define ProjectName          @"爱葫芦"
// 项目地址
#define ProjectURL          @"https://itunes.apple.com/cn/app/ai-hu-lu/id1033843787?mt=8"

// 评分地址
#define APPSTOREURL          @"itms-apps://itunes.apple.com/cn/app/ai-hu-lu/id1033843787?mt=8"

//QQ key
#define QQ_KEY          @"1104785507"

//分享内容
#define SHARE_TITLE @"爱葫芦，新生代的赚钱神器！"
#define SHARE_TEXT @"我正在玩“爱葫芦”，炫酷精彩的广告资源，琳琅满目的兑换产品，葫芦里卖的什么药？爱上葫芦里的秘密！"
#define WEB_ADDRESS  @"http://www.ihuluu.com"

#define WEIXIN_APPID @"wx43858438c5418da2"
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"
#define PARTNER_ID          @"d15062311c4833efa1ad83fddc32fce6" // 秘钥
#define MCH_ID      @"1283895401"// 商户号


#define HELP_KEY @"help_key"


#define OPEN_WEIXIN  @"itms-apps://itunes.apple.com/cn/app/id414478124?mt=8"

#endif
