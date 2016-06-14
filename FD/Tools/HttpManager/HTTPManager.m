
//
//  HTTPManager.m
//  cardPreferential
//
//  Created by leo xu on 13-4-11.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#import "HTTPManager.h"
#import "NSString+SBJSON.h"
#import "NSString+UTF8.h"
#import "MHTool.h"
#import "UserData.h"
#import "HomeNode.h"
#import "Encryption.h"
#import <CommonCrypto/CommonDigest.h>
#import "DES3Util.h"
#import "BuylistNode.h"
#import "CateNode.h"
#import "GoodsListNode.h"
#import "LayListNode.h"
#import "PropertyNode.h"
#import "MyTaskAnyCellNode.h"
#import "MyTaskGetCellNode.h"
#import "MyTaskLayCellNode.h"
#import "BuyDetailNode.h"
#import "AddressNode.h"
#import "MyNewsListNode.h"
#import "UserDataManager.h"
#import "HobbiesNode.h"
#import "GoodsDetailNode.h"
#import "MyGoodsListNode.h"
#import "ExchangeDetailNode.h"
#import "MyBankListNode.h"
#import "OpenAdNode.h"
#import "SnatchHomeListNode.h"
#import "SnatchAdsNode.h"
#import "SnatchClassifyNode.h"
#import "PassedSnatchNode.h"
#import "ShopCartNode.h"
#import "MyBagListNode.h"
#import "MyBagDetailListNode.h"
#import "ShowMeNode.h"
#import "WinningRecordNode.h"
#import "SnatchRecordListNode.h"
#import "SnatchPayNode.h"

@implementation HTTPManager

#pragma mark -
#pragma mark ===============life cycle================
-(id)init
{
    if (self = [super init]) {
        
        _httpQueue = [[ASINetworkQueue alloc] init];
    }
    
    return self;
}

-(void)dealloc{
    if (_httpRequest) {
        [_httpRequest cancel];
        _httpRequest.delegate = nil;
        [_httpRequest release];
        _httpRequest = nil;
    }
    if (_httpPost) {
        [_httpPost cancel];
        _httpPost.delegate = nil;
        [_httpPost release];
        _httpPost = nil;
    }
    if (_httpQueue) {
        [self destoryQueue];
    }
    [super dealloc];
}

- (void)destoryQueue
{
    for (ASIHTTPRequest *request in [_httpQueue operations]) {
        request.delegate = nil;
    }
    [_httpQueue cancelAllOperations];
    _httpQueue.delegate = nil;
    [_httpQueue release];
    _httpQueue=nil;
}

//TODO:获取字典信息
-(NSString *)stringFromDict:(NSDictionary *)dict forKey:(NSString *)key
{
    NSString *ret = [dict objectForKey:key];
    if (ret) return ret;
    else return @"";
}

//TODO:获取字典信息且加密
-(NSString *)enCodeStringFromDict:(NSDictionary *)dict forKey:(NSString *)key
{
    NSString *ret = [dict objectForKey:key];
    if (ret) return [MHTool encodeDES:ret];
    else return @"";
}


//TODO:取消请求
-(void)cancelReqWithReqCode:(HTTP_CODE)reqCode
{
    for (ASIHTTPRequest *request in [_httpQueue operations]) {
        NSDictionary *userInfo = request.userInfo;
        NSInteger httpCode = [[userInfo objectForKey:REQ_CODE] integerValue];
        if (reqCode == httpCode) {
            [request clearDelegatesAndCancel];
        }
    }
}


#pragma mark -
#pragma mark ===============请求分发================
//TODO:发送请求
-(void)sendReqWithDict:(NSDictionary *)dict{
    
    int reqCode = [[dict objectForKey:REQ_CODE] intValue];
    switch (reqCode) {
            //====== 抽疯 =====
            // 抽疯首页广告
        case REQ_SNATCH_HOME_ADS:
            // 抽疯首页列表
        case REQ_SNATCH_HOME_LIST:
            // 获取购物车数量
        case REQ_SNATCH_CART_COUNT:
            // 购物车列表
        case REQ_SNATCH_CART_LIST:
            // 加入购物车
        case REQ_SNATCH_CART_ADD:
            // 移除购物车
        case REQ_SNATCH_CART_LESS:
//            // 获取支付信息
//        case REQ_SNATCH_PAYMENTING:
            // 立即支付
        case REQ_SNATCH_PAYNOW:
            // 抽疯商品详情
        case REQ_SNATCH_DETAILS:
            // 获取可参与数据
        case REQ_SNATCH_CANADD:
            // 晒单列表
        case REQ_SNATCH_SHAIDAN_LIST:
            // 我的中奖
        case REQ_SNATCH_MYWINNER_LIST:
            // 我的中奖状态
        case REQ_SNATCH_MYWINNER_DETAILS:
            //设置奖品收货地址
        case REQ_SNATCH_MYWINNER_ADDRESS:
            //确认奖品收货
        case REQ_SNATCH_MYWINNER_SURE:
            // 夺宝记录
        case REQ_SNATCH_RECORD_LIST:
            //====== 口令夺宝 =====
               // 输入抽奖码
        case REQ_KL_GETCODE:
             // 加入抽奖
        case REQ_KL_JOIN:
            // 进行支付-福利
        case REQ_KWELFARE_CREATE:
            // 进行支付-群
        case REQ_KWELFARE_CREATE_GROUP:
            // 第三方支付后获取数据
        case  REQ_KWELFARE_RESULT:
            // 抽疯商品第三方支付后获取数据
        case  REQ_KWELFARE_RESULT_SNATCHPAY:
            // 我的抢宝
        case REQ_MYBAG_LIST:
            // 我的抢宝详情
        case REQ_MYBAG_DETAIL:

            
            // 分类浏览
        case REQ_SNATCH_CLASSIFY:
            // 往期揭晓
        case REQ_SNATCH_PASSED_LIST:
            
            //登录
        case REQ_LOGIN:
            // 网页扫码登录
        case REQ_HOME_LOGINWEB:
            // 重新登录
        case REQ_LOGIN_AGAIN:
            //注册
        case REQ_REGISTER:
            //注册 获取验证码
        case REQ_GETCODE:
            // 验证验证码
        case REQ_VERIFY:
            // 首页列表
        case REQ_HOME_LIST:
            // 随时赚列表
        case REQ_ANYTIMEBUY_LIST:
             // 随时赚详情
        case REQ_ANYTIMEBUY_DETAIL:
            // 上传评论
        case REQ_COMMENT_SEND:
            // 关注
        case REQ_FAV:
            //领取随时赚任务
        case REQ_ANYTIMEBUY_GETTASK:
            //做随时赚的任务
        case REQ_ANYTIMEBUY_DOTASK:
            
            // 随心兑列表
        case REQ_GOODSBUY_LIST:
            // 随心兑详情
        case REQ_GOODSBUY_DETAIL:
            // 随心兑兑换
        case REQ_GOODSBUY_BUY:
            // 我要抽列表
        case REQ_ANYTHINGLAY_LIST:
            // 我要抽详情
        case REQ_ANYTHINGLAY_DETAIL:
            // 资产明细
        case REQ_MYINFO_PROPERTY_LIST:
            //随时赚列表
        case REQ_MYTASKS_BUY_LIST:
            //我的随心兑列表
        case REQ_MYGOODS_LIST:
            //我的随心兑详情
        case REQ_MYEXCHAGE_DETAIL:
            // 终止任务
        case REQ_MYTASKS_BUY_END:
            // 是否实名
        case REQ_ISREALNAME:
            
            // 取消兑换
        case REQ_MYEXCHAGE_CLOSE:
            // 确认兑换
        case REQ_MYEXCHAGE_SURE:
            
            //我的任务随时抽列表
        case REQ_MYTASKS_LAY_LIST:
            //修改信息
        case REQ_MODIFYINFO:
            
            // 地址列表
        case REQ_ADDRESS_LIST:
            // 新增/编辑地址
        case REQ_ADDRESS_ADD:
            // 删除地址
        case REQ_ADDRESS_DELETE:
            // 修改头像
        case REQ_EDITHEAD:

            // 我的消息
        case REQ_MYNEWS_LIST:
            // 我的关注
        case REQ_MYCON_LIST_BUY:
            // 我的关注
        case REQ_MYCON_LIST_GOODS:
            // 兴趣爱好
        case REQ_HOBBIES:
            // 版本号
        case REQ_VERSION:
            // 修改手机号
        case REQ_MODIFY_PHONE:
            // 修改登录密码
        case REQ_MODIFY_LOGINPWD:
            // 修改支付密码
        case REQ_MODIFY_PAYPWD:
            //我的银行卡列表
        case REQ_MYBANKCARD_LIST:
            // 删除我的银行卡
        case REQ_MYBANKCARD_DELETE:
            // 删除消息
        case REQ_MYNEWS_DELETE:
            // 我的随心兑删除
        case REQ_MYGOODS_DELETE:
            // 我的随时赚删除
        case REQ_MYTASKS_BUY_DELETE:
            // 银行网点
        case REQ_BANK_BRANCH:
            // 提现
        case REQ_MONEY_APPLY:
            // 开机广告
        case REQ_LOADINGAD:
            // 余额查询
        case REQ_GETBALANCE:
            // 可用余额查询
        case REQ_GETBALANCE_FREE:
            // 获取总资产
        case REQ_INFO_ALLTOTAL:
            // 获取支付宝充值订单
        case REQ_PAY_ZFB_ORDER:
            // 获取微信充值订单
        case REQ_PAY_WX_ORDER:
        {
            [self doReqUserInfo:dict];
            
        }
            break;
            
        case 1:
        {
            [self doReqListInfo:dict];
            
        }
            break;
        default:
            [self requestWithURL:SERVER_URL data:dict code:reqCode json:YES];
            break;
    }
}


//TODO:关于我们
-(void)doReqAboutUs:(NSDictionary *)dict
{
    //    int reqCode = [[dict objectForKey:REQ_CODE] intValue];
    //    [self requestWithURL:SERVER_ABOUTUS data:dict code:reqCode json:NO];
}


//TODO:信息相关请求(url请求例子)
-(void)doReqInfomation:(NSDictionary *)dict
{
    int reqCode = [[dict objectForKey:REQ_CODE] intValue];
    NSMutableString *url = [NSMutableString stringWithString:SERVER_URL];
    //    switch (reqCode) {
    //            // 关于我们
    //        case REQ_ABOUTUS:{
    //            NSString *comand = [NSString stringWithFormat:SERVER_ABOUTUS];
    //            [url appendFormat:@"%@",comand];
    //        }
    //            break;
    //
    //        default:
    //            break;
    //    }
    
    [self requestWithURL:url code:reqCode];
    
}


// TODO: 用户相关请求(post例子)
-(void)doReqUserInfo:(NSDictionary *)dict
{
    int reqCode = [[dict objectForKey:REQ_CODE] intValue];
    NSMutableString *url = [NSMutableString stringWithString:SERVER_URL];
    
    switch (reqCode) {
            //====== 口令夺宝 =====
            // 我的抢宝详情
        case REQ_MYBAG_DETAIL:        {
            
            NSString *str  = SERVER_MYBAG_DETAIL;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 我的抢宝
        case REQ_MYBAG_LIST:
        {
            
            NSString *str  = SERVER_MYBAG_LIST;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 输入抽奖码
        case REQ_KL_GETCODE:  {
            
            NSString *str  = SERVER_KL_GETCODE;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 加入抽奖
        case REQ_KL_JOIN:  {
            
            NSString *str  = SERVER_KL_JOIN;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 进行支付-福利
        case REQ_KWELFARE_CREATE:  {
            
            NSString *str  = SERVER_KWELFARE_CREATE;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 进行支付-群
        case REQ_KWELFARE_CREATE_GROUP:  {
            
            NSString *str  = SERVER_KWELFARE_CREATE_GROUP;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 第三方支付后获取数据
        case  REQ_KWELFARE_RESULT:{
            
            NSString *str  = SERVER_KWELFARE_RESULT;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 抽疯商品第三方支付后获取数据
        case  REQ_KWELFARE_RESULT_SNATCHPAY:{
            
            NSString *str  = SERVER_KWELFARE_RESULT;
            [url appendFormat:@"%@",str];
            
        }
            break;
            //抽疯
//            // 获取支付信息
//        case REQ_SNATCH_PAYMENTING:
//        {
//            
//            NSString *str  = SERVER_SNATCH_PAYMENTING;
//            [url appendFormat:@"%@",str];
//            
//        }
//            break;
            // 抽疯首页广告
        case REQ_SNATCH_HOME_ADS:{
            
            NSString *str  = SERVER_SNATCH_HOME_ADS;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 抽疯首页列表
        case REQ_SNATCH_HOME_LIST:{
            
            NSString *str  = SERVER_SNATCH_HOME_LIST;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 抽疯商品详情
        case REQ_SNATCH_DETAILS:
        {
            NSString *str  = SERVER_SNATCH_DETAILS;
            [url appendFormat:@"%@",str];
        }
            break;
            // 获取可参与数据
        case REQ_SNATCH_CANADD:{
            NSString *str  = SERVER_SNATCH_CANADD;
            [url appendFormat:@"%@",str];
        }
            break;
            // 立即支付
        case REQ_SNATCH_PAYNOW:{
            NSString *str  = SERVER_SNATCH_PAYNOW;
            [url appendFormat:@"%@",str];
        }
            break;
            // 晒单列表
        case REQ_SNATCH_SHAIDAN_LIST:
        {
            NSString *str  = SERVER_SNATCH_SHAIDAN_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 我的中奖
        case REQ_SNATCH_MYWINNER_LIST:
        {
            NSString *str  = SERVER_SNATCH_MYWINNER_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 我的中奖状态
        case REQ_SNATCH_MYWINNER_DETAILS:
        {
            NSString *str  = SERVER_SNATCH_MYWINNER_DETAILS;
            [url appendFormat:@"%@",str];
        }
            break;
            //设置奖品收货地址
        case REQ_SNATCH_MYWINNER_ADDRESS:
        {
            NSString *str  = SERVER_SNATCH_MYWINNER_ADDRESS;
            [url appendFormat:@"%@",str];
        }
            break;
            //确认奖品收货
        case REQ_SNATCH_MYWINNER_SURE:
        {
            NSString *str  = SERVER_SNATCH_MYWINNER_SURE;
            [url appendFormat:@"%@",str];
        }
            break;
            // 夺宝记录
        case REQ_SNATCH_RECORD_LIST:
        {
            NSString *str  = SERVER_SNATCH_RECORD_LIST;
            [url appendFormat:@"%@",str];
        }
            break;

            // 分类
        case REQ_SNATCH_CLASSIFY:{
            
            NSString *str  = SERVER_SNATCH_CLASSIFY;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 获取购物车数量
        case REQ_SNATCH_CART_COUNT:
        {
            
            NSString *str  = SERVER_SNATCH_CART_COUNT;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 购物车列表
        case REQ_SNATCH_CART_LIST:
        {
            
            NSString *str  = SERVER_SNATCH_CART_LIST;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 加入购物车
        case REQ_SNATCH_CART_ADD:        {
            
            NSString *str  = SERVER_SNATCH_CART_ADD;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 移除购物车
        case REQ_SNATCH_CART_LESS:        {
            
            NSString *str  = SERVER_SNATCH_CART_LESS;
            [url appendFormat:@"%@",str];
            
        }
            break;

            // 往期揭晓
        case REQ_SNATCH_PASSED_LIST:
        {
            
            NSString *str  = SERVER_SNATCH_PASSED_LIST;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 获取微信充值订单
        case REQ_PAY_WX_ORDER:{
            
            NSString *str  = SERVER_PAY_WX_ORDER;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 获取支付宝充值订单
        case REQ_PAY_ZFB_ORDER:{
            
            NSString *str  = SERVER_PAY_ZFB_ORDER;
            [url appendFormat:@"%@",str];
            
        }
            break;
            // 开机广告
        case REQ_LOADINGAD:
        {
            NSString *str  = SERVER_LOADINGAD;
            [url appendFormat:@"%@",str];
 
        }
            break;
            // 版本号
        case REQ_VERSION:{
            url  = [NSMutableString stringWithString:SERVER_APPSTORE_VERSION];
        }
            break;

            //登录
        case REQ_LOGIN:
            // 重新登录
        case REQ_LOGIN_AGAIN:{
            NSString *str  = SERVER_LOGIN;
            [url appendFormat:@"%@",str];
        }
            break;
            // 网页扫码登录
        case REQ_HOME_LOGINWEB:{
            NSString *str  = SERVER_HOME_LOGINWEB;
            [url appendFormat:@"%@",str];
        }
            break;
            //注册  获取验证码
        case REQ_GETCODE:{
            NSString *str  = SERVER_GETCODE;
            [url appendFormat:@"%@",str];
        }
            break;
            // 验证验证码
        case REQ_VERIFY:{
            NSString *str  = SERVER_VERIFY;
            [url appendFormat:@"%@",str];
        }
            break;
            //注册
        case REQ_REGISTER:{
            NSString *str  = SERVER_REGISTER;
            [url appendFormat:@"%@",str];
        }
            break;
            //修改信息
        case REQ_MODIFYINFO:{
            NSString *str  = SERVER_MODIFYINFO;
            [url appendFormat:@"%@",str];

        }
            break;
            // 首页列表
        case REQ_HOME_LIST:
        {
            NSString *str = SERVER_HOME_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 随时赚列表
        case REQ_ANYTIMEBUY_LIST:       {
            NSString *str = SERVER_ANYTIMEBUY_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 随时赚详情
        case REQ_ANYTIMEBUY_DETAIL: {
            NSString *str = SERVER_ANYTIMEBUY_DETAIL;
            [url appendFormat:@"%@",str];
        }
            break;
            // 上传评论
        case REQ_COMMENT_SEND:{
            NSString *str = SERVER_COMMENT_SEND;
            [url appendFormat:@"%@",str];
        }
            break;

            //领取随时赚任务
        case REQ_ANYTIMEBUY_GETTASK: {
            NSString *str = SERVER_ANYTIMEBUY_GETTASK;
            [url appendFormat:@"%@",str];
        }
            break;
            //做随时赚的任务
        case REQ_ANYTIMEBUY_DOTASK: {
            NSString *str = SERVER_ANYTIMEBUY_DOTASK;
            [url appendFormat:@"%@",str];
        }
            break;
            // 随心兑列表
        case REQ_GOODSBUY_LIST: {
            NSString *str = SERVER_GOODSBUY_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 随心兑详情
        case REQ_GOODSBUY_DETAIL: {
            NSString *str = SERVER_GOODSBUY_DETAIL;
            [url appendFormat:@"%@",str];
        }
            break;
            
            // 随心兑兑换
        case REQ_GOODSBUY_BUY:{
            NSString *str = SERVER_GOODSBUY_BUY;
            [url appendFormat:@"%@",str];
        }
            break;
            // 我要抽列表
        case REQ_ANYTHINGLAY_LIST: {
            NSString *str = SERVER_ANYTHINGLAY_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 我要抽详情
        case REQ_ANYTHINGLAY_DETAIL: {
            NSString *str = SERVER_ANYTHINGLAY_DETAIL;
            [url appendFormat:@"%@",str];
        }
            break;
            // 关注
        case REQ_FAV:{
            NSString *str = SERVER_FAV;
            [url appendFormat:@"%@",str];
        }
            break;

            // 资产明细
        case REQ_MYINFO_PROPERTY_LIST:{
            NSString *str = SERVER_MYINFO_PROPERTY_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            //随时赚列表
        case REQ_MYTASKS_BUY_LIST:
        {
            NSString *str = SERVER_MYTASKS_BUY_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            //我的随心兑列表
        case REQ_MYGOODS_LIST:
        {
            NSString *str = SERVER_MYGOODS_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            
            //我的随心兑详情
        case REQ_MYEXCHAGE_DETAIL:{
            NSString *str = SERVER_MYEXCHAGE_DETAIL;
            [url appendFormat:@"%@",str];
        }
            break;
            // 是否实名
        case REQ_ISREALNAME:
        {
            NSString *str = SERVER_ISREALNAME;
            [url appendFormat:@"%@",str];
        }
            break;
            // 取消兑换
        case REQ_MYEXCHAGE_CLOSE:{
            NSString *str = SERVER_MYEXCHAGE_CLOSE;
            [url appendFormat:@"%@",str];
        }
            break;
            // 确认兑换
        case REQ_MYEXCHAGE_SURE:{
            NSString *str = SERVER_MYEXCHAGE_SURE;
            [url appendFormat:@"%@",str];
        }
            break;
            //我的任务随时抽列表
        case REQ_MYTASKS_LAY_LIST:
        {
            NSString *str = SERVER_MYTASKS_LAY_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 我的消息
        case REQ_MYNEWS_LIST:{
            NSString *str = SERVER_MYNEW_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 我的关注
        case REQ_MYCON_LIST_GOODS:
        case REQ_MYCON_LIST_BUY:{
            NSString *str = SERVER_MYCON_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 地址列表
        case REQ_ADDRESS_LIST:
        {
            NSString *str = SERVER_ADDRESS_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            // 新增/编辑地址
        case REQ_ADDRESS_ADD:
        {
            NSString *str = SERVER_ADDRESS_ADD;
            [url appendFormat:@"%@",str];
        }
            break;
            // 删除地址
        case REQ_ADDRESS_DELETE:
        {
            NSString *str = SERVER_ADDRESS_DELETE;
            [url appendFormat:@"%@",str];
        }
            break;
            // 修改头像
        case REQ_EDITHEAD:
        {
            NSString *comand = [NSString stringWithFormat:SERVER_EDITHEAD];
            [url appendFormat:@"%@",comand];
        }
            break;
            // 兴趣爱好
        case REQ_HOBBIES:{
            NSString *comand = [NSString stringWithFormat:SERVER_HOBBIES];
            [url appendFormat:@"%@",comand];

        }
            break;
            // 修改手机号
        case REQ_MODIFY_PHONE:
        {
            NSString *comand = [NSString stringWithFormat:SERVER_MODIFY_PHONE];
            [url appendFormat:@"%@",comand];
        }
            break;
            // 修改登录密码
        case REQ_MODIFY_LOGINPWD:{
            NSString *comand = [NSString stringWithFormat:SERVER_MODIFY_LOGINPWD];
            [url appendFormat:@"%@",comand];
            
        }
            break;
            // 修改支付密码
        case REQ_MODIFY_PAYPWD:{
            NSString *comand = [NSString stringWithFormat:SERVER_MODIFY_PAYPWD];
            [url appendFormat:@"%@",comand];
            
        }
            break;
            //我的银行卡列表
        case REQ_MYBANKCARD_LIST:{
            NSString *comand = [NSString stringWithFormat:SERVER_MYBANKCARD_LIST];
            [url appendFormat:@"%@",comand];
            
        }
            break;
            // 删除我的银行卡
        case REQ_MYBANKCARD_DELETE:{
            NSString *comand = [NSString stringWithFormat:SERVER_MYBANKCARD_DELETE];
            [url appendFormat:@"%@",comand];
            
        }
            break;
            // 删除消息
        case REQ_MYNEWS_DELETE:
        {
            NSString *comand = [NSString stringWithFormat:SERVER_MYNEW_DELETE];
            [url appendFormat:@"%@",comand];
            
        }
            break;
            // 我的随心兑删除
        case REQ_MYGOODS_DELETE:
        {
            NSString *comand = [NSString stringWithFormat:SERVER_MYGOODS_DELETE];
            [url appendFormat:@"%@",comand];
            
        }
            break;
            // 我的随时赚删除
        case REQ_MYTASKS_BUY_DELETE:
        {
            NSString *comand = [NSString stringWithFormat:SERVER_MYTASKS_BUY_DELETE];
            [url appendFormat:@"%@",comand];
            
        }
            break;
            // 终止任务
        case REQ_MYTASKS_BUY_END:{
            NSString *comand = [NSString stringWithFormat:SERVER_MYTASKS_BUY_END];
            [url appendFormat:@"%@",comand];
        }
            break;
            // 银行网点
        case REQ_BANK_BRANCH:{
            NSString *comand = [NSString stringWithFormat:SERVER_BANK_BRANCH];
            [url appendFormat:@"%@",comand];
        }
            break;
            // 提现
        case REQ_MONEY_APPLY:{
            NSString *comand = [NSString stringWithFormat:SERVER_MONEY_APPLY];
            [url appendFormat:@"%@",comand];
        }
            break;
            // 余额查询
        case REQ_GETBALANCE:{
            NSString *comand = [NSString stringWithFormat:SERVER_GETBALANCE];
            [url appendFormat:@"%@",comand];
        }
            break;
            // 可用余额查询
        case REQ_GETBALANCE_FREE:{
            NSString *comand = [NSString stringWithFormat:SERVER_GETBALANCE_FREE];
            [url appendFormat:@"%@",comand];
        }
            break;
            // 获取总资产
        case REQ_INFO_ALLTOTAL:{
            NSString *comand = [NSString stringWithFormat:SERVER_INFO_ALLTOTAL];
            [url appendFormat:@"%@",comand];
        }
            break;
        default:
            break;
    }
    
    NSMutableDictionary *reqDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSMutableString *url1 = [NSMutableString stringWithString:SERVER_URL];
    [url1 appendString:@"Api/"];
    NSMutableString *url2 = [NSMutableString stringWithString:SERVER_URL];
    [url2 appendString:@"H5/"];
    NSString *newUrl = url;
//    if ([url hasPrefix:url1]) {
//        newUrl = [url stringByReplacingOccurrencesOfString:url1 withString:@"http://api.ihuluu.com/"];
//
//    }
//    else if ([url hasPrefix:url2]) {
//        newUrl = [url stringByReplacingOccurrencesOfString:url1 withString:@"http://m.ihuluu.com/"];
//        
//    }
    //leoxu 测试用
    if ([url hasPrefix:url1]) {
        newUrl = [url stringByReplacingOccurrencesOfString:url1 withString:@"http://api-test.ihuluu.com/"];
        
    }
    else if ([url hasPrefix:url2]) {
        newUrl = [url stringByReplacingOccurrencesOfString:url1 withString:@"http://m-test.ihuluu.com/"];
        
    }
//    //leoxu 上线
//    if ([url hasPrefix:url1]) {
//        newUrl = [url stringByReplacingOccurrencesOfString:url1 withString:@"http://api.ihuluu.com/"];
//        
//    }
//    else if ([url hasPrefix:url2]) {
//        newUrl = [url stringByReplacingOccurrencesOfString:url1 withString:@"http://m.ihuluu.com/"];
//        
//    }
    //POST方法
    // 外网     
    [self requestWithURL:newUrl data:reqDict code:reqCode json:YES];
//    // 内网
//    [self requestWithURL:url data:reqDict code:reqCode json:YES];
}



// TODO: 用户相关请求(post例子)
-(void)doReqListInfo:(NSDictionary *)dict
{
    int reqCode = [[dict objectForKey:REQ_CODE] intValue];
    NSMutableString *url = [NSMutableString stringWithString:SERVER_URL];
    
    switch (reqCode) {
 
            
            // 首页列表
        case REQ_HOME_LIST:
        {
            NSString *str = SERVER_HOME_LIST;
            [url appendFormat:@"%@",str];
        }
            break;
            
        default:
            break;
    }
    
    NSMutableDictionary *reqDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    //POST方法
    [self requestWithURL:url userInfo:reqDict];
}



#pragma mark -
#pragma mark ===============网络请求================
//TODO:url请求方式，只传入请求码
- (void)requestWithURL:(NSString *)url code:(HTTP_CODE)code
{
    NSLog(@"%s,%d\n%@",__func__,__LINE__,url);
    
    if (_httpRequest) {
        [_httpRequest clearDelegatesAndCancel];
        [_httpRequest release];
        _httpRequest=nil;
    }
    if (url && [url length] > 0) {
#ifdef DEBUG
        //初始化网络请求
        _httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&debug=1",url]]];
#else
        //初始化网络请求
        _httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
#endif
        _httpRequest.timeOutSeconds = 20;
        [_httpRequest setUserInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:code] forKey:REQ_CODE]];
        _httpRequest.delegate = self;
        [_httpRequest startAsynchronous];
    }
}

//TODO:url请求方式，传入userinfo，字典内需带有请求码
- (void)requestWithURL:(NSString *)url userInfo:(NSDictionary *)userInfo
{
    NSLog(@"%s,%d\n%@",__func__,__LINE__,url);
    
    if (_httpRequest) {
        [_httpRequest clearDelegatesAndCancel];
        [_httpRequest release];
        _httpRequest=nil;
    }
    if (url && [url length] > 0) {
#ifdef DEBUG
        //初始化网络请求
        _httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
#else
        //初始化网络请求
        _httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
#endif
        _httpRequest.timeOutSeconds = 20;
        [_httpRequest setUserInfo:userInfo];
        _httpRequest.delegate = self;
        [_httpRequest startAsynchronous];
    }
}


//TODO:Post请求方式
- (void)requestWithURL:(NSString *)url data:(NSDictionary *)dict code:(HTTP_CODE)code json:(BOOL)bjson
{
    if (code == REQ_EDITHEAD) {
        //如果已有请求，直接返回
        //    if ([self checkQueueHasReq:code]) {
        //        return;
        //    }
        
        if (_httpPost) {
            [_httpPost clearDelegatesAndCancel];
            [_httpPost release];
            _httpPost=nil;
        }
        if (url && [url length] > 0) {
#ifdef HTTP_DEBUG
            //初始化网络请求
            _httpPost = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&debug=1",url]]];
#else
            //初始化网络请求
            _httpPost = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
#endif
            [_httpPost setUserInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:code] forKey:REQ_CODE]];
            _httpPost.delegate = self;
             _httpPost.uploadProgressDelegate = self;
            _httpPost.shouldResetDownloadProgress = NO;
            
            _httpPost.showProgress = YES;
            _httpPost.timeOutSeconds = 20;
            // 判断设备
            [dict setValue:@"1" forKey:@"device"];
            NSMutableDictionary *postData = [NSMutableDictionary dictionary];
            
            for (NSString *key in dict.allKeys) {
                if ([key isEqualToString:REQ_CODE]) continue;
                NSLog(@"key ======= %@",key);

                if ([[dict objectForKey:key] isKindOfClass:[NSData class]]) {
                    [_httpPost addData:[dict objectForKey:key] withFileName:[NSString stringWithFormat:@"%ld.jpg",(long)[UserDataManager sharedUserDataManager].userData.UID] andContentType:@"image/jpg" forKey:@"avatar"];

                }
  
                else
                {
//                    if (bjson) {
//                        [postData setObject:[dict objectForKey:key] forKey:key];
//                    }
//                    else
                    [_httpPost setPostValue:[dict objectForKey:key] forKey:key];
 
                }
//                [_httpPost setData:[dict objectForKey:key] forKey:key];
            }
            
            
            NSString *JSONString = [postData JSONRepresentation];
            NSLog(@"%s,%d\n%@\n%@",__func__,__LINE__,url,JSONString);
            
            if (bjson) {
                [_httpPost setPostValue:JSONString forKey:@"json"];
            }
            [_httpPost setRequestMethod:@"POST"];
            [_httpQueue addOperation:_httpPost];
            [_httpQueue go];
        }
    }else{
        //如果已有请求，直接返回
        if ([self checkQueueHasReq:code]) {
            return;
        }
        
        // 判断设备
        [dict setValue:@"1" forKey:@"device"];
        if (_httpPost) {
            [_httpPost clearDelegatesAndCancel];
            [_httpPost release];
            _httpPost=nil;
        }
        if (url && [url length] > 0) {
#ifdef DEBUG
            //初始化网络请求
            _httpPost = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
#else
            //初始化网络请求
            _httpPost = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
#endif
            [_httpPost setUserInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:code] forKey:REQ_CODE]];
            _httpPost.delegate = self;
            
            for (NSString *key in dict.allKeys) {
                if ([key isEqualToString:REQ_CODE]) continue;
                
                if ([[dict objectForKey:key] isKindOfClass:[NSData class]] ) {
                    [_httpPost setData:[dict objectForKey:key] forKey:key];
                }
                else
                {
                    //          [_httpPost setPostValue:[dict objectForKey:key] forKey:key];
                }
            }
            
            
            NSString *JSONString = [dict JSONRepresentation];
            NSLog(@"%s,%d\n%@\n%@",__func__,__LINE__,url,JSONString);
            if (code != REQ_VERSION) {
                    JSONString = [DES3Util AES128Encrypt:JSONString];

            }

            //        NSLog(@"%s,%d\n%@\n%@",__func__,__LINE__,url,JSONString);
            NSData *postData = [JSONString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            [_httpPost appendPostData:postData];
            [_httpPost setRequestMethod:@"POST"];
            [_httpPost startAsynchronous];
            //设置PUT方法
            //        [_httpPost setRequestMethod:@"PUT"];
        }

    }
    
}

- (BOOL)checkQueueHasReq:(HTTP_CODE)code
{
    //如果已有请求，直接返回
    for (ASIHTTPRequest *request in [_httpQueue operations]) {
        NSDictionary *userInfo = request.userInfo;
        NSInteger reqCode = [[userInfo objectForKey:REQ_CODE] integerValue];
        if (reqCode == code) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark ===============响应事件================
//TODO:登录响应
-(void)doLoginResp:(NSDictionary *)dict
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        
        UserData *data = [[UserData alloc] initWithDict:dict];
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_LOGIN],REQ_CODE,data,RESP_CONTENT, nil];
        [_delegate requestFinished:respDict];
        [data release];
    }
}

//TODO:刷新数据
-(void)doAlltotalResp:(NSDictionary *)dict
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        
        UserData *data = [[UserData alloc] initWithDict:dict];
        [UserDataManager sharedUserDataManager].userData.UtodayIn =data.UtodayIn;
        [UserDataManager sharedUserDataManager].userData.UweekIn =data.UweekIn;
        [UserDataManager sharedUserDataManager].userData.UmouthIn =data.UmouthIn;
        [UserDataManager sharedUserDataManager].userData.UtotalIn =data.UtotalIn;
        [UserDataManager sharedUserDataManager].userData.Utotal =data.Utotal;
        [UserDataManager sharedUserDataManager].userData.Utotal_Free =data.Utotal_Free;
        [UserDataManager sharedUserDataManager].userData.Utotal_Freeze =data.Utotal_Freeze;
        [UserDataManager sharedUserDataManager].userData.Utotal_Bail =data.Utotal_Bail;
        [UserDataManager sharedUserDataManager].userData.Utotal_FreeBail =data.Utotal_FreeBail;

        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_INFO_ALLTOTAL],REQ_CODE,data,RESP_CONTENT, nil];
        [_delegate requestFinished:respDict];
        [data release];
    }
}



//TODO:重新登录响应
-(void)doLoginAgainResp:(NSDictionary *)dict
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        
        UserData *data = [[UserData alloc] initWithDict:dict];
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_LOGIN_AGAIN],REQ_CODE,data,RESP_CONTENT, nil];
        [_delegate requestFinished:respDict];
        [data release];
    }
}
//TODO:注册响应
-(void)doRegisterResp:(NSDictionary *)dict
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        
        UserData *data = [[UserData alloc] initWithDict:dict];
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_REGISTER],REQ_CODE,data,RESP_CONTENT, nil];
        [_delegate requestFinished:respDict];
        [data release];
    }
}


//TODO:开机广告回调成功
-(void)doRespLoadingAd:(NSArray *)array
{
    if (!array){
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for(NSDictionary *dict in array)
        {
            OpenAdNode *node = [[OpenAdNode alloc] initWithDict:dict];
            [dataArr addObject:node];
            [node release];
        }
        
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_LOADINGAD],REQ_CODE,dataArr,RESP_CONTENT,nil];
        [_delegate requestFinished:respDict];
        
        

    }
}

#pragma mark =============== 转换数据 ================
//TODO:首页列表
- (void)doRespHomeList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:REQ_HOMELIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *msgNum = [dict objectForKey:REQ_MSGNUM];
    
    for(NSDictionary *dict in topicList)
    {
        HomeNode *node = [[HomeNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_HOME_LIST],REQ_CODE,dataArr,RESP_CONTENT,msgNum,REQ_MSGNUM,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}


//TODO:随时赚列表
- (void)doRespAnyTimeBuyList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    
    for(NSDictionary *dict in topicList)
    {
        BuylistNode *node = [[BuylistNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_ANYTIMEBUY_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}


//TODO:随时赚详情
- (void)doRespAnyTimeBuyDatail:(NSDictionary *)dict{
//    NSDictionary  *deytail = [dict objectForKey:RESP_CONTENT];
    BuyDetailNode *node = [[BuyDetailNode alloc] initWithDict:dict];

    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_ANYTIMEBUY_DETAIL],REQ_CODE,dict,RESP_CONTENT,node,RESP_NODE,nil];
        
        [_delegate requestFinished:respDict];
        
    }
    
}

//TODO:随心兑列表
- (void)doRespAnyThingGetList:(NSDictionary *)dict{
    NSArray  *cateList = [dict objectForKey:RESP_CATE];
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSMutableArray *cateDataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    
    for(NSDictionary *dictc in cateList)
    {
        CateNode *node = [[CateNode alloc] initWithDict:dictc];
        [cateDataArr addObject:node];
        [node release];
    }
    
    for(NSDictionary *dict in topicList)
    {
        GoodsListNode *node = [[GoodsListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_GOODSBUY_LIST],REQ_CODE,dataArr,RESP_CONTENT,cateDataArr,RESP_CATE,next,RESP_NEXT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:随心兑详情
- (void)doRespGoodsBuyDatail:(NSDictionary *)dict{
    //    NSDictionary  *deytail = [dict objectForKey:RESP_CONTENT];
    GoodsDetailNode *node = [[GoodsDetailNode alloc] initWithDict:dict];
    
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_GOODSBUY_DETAIL],REQ_CODE,dict,RESP_CONTENT,node,RESP_NODE,nil];
        
        [_delegate requestFinished:respDict];
        
    }
    
}

//TODO:我要抽列表
- (void)doRespAnyThingLayList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    NSArray  *cateList = [dict objectForKey:RESP_CATE];
    NSMutableArray *cateDataArr = [NSMutableArray array];

    for(NSDictionary *dictc in cateList)
    {
        CateNode *node = [[CateNode alloc] initWithDict:dictc];
        [cateDataArr addObject:node];
        [node release];
    }
    
    for(NSDictionary *dict in topicList)
    {
        LayListNode *node = [[LayListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_ANYTHINGLAY_LIST],REQ_CODE,dataArr,RESP_CONTENT,cateDataArr,RESP_CATE,next,RESP_NEXT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:我要资产明细列表
- (void)doRespPropertyList:(NSArray *)array{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        NSInteger tt = 0;
        for(NSDictionary *dict in array)
        {
    
            PropertyNode *node = [[PropertyNode alloc] initWithDict:dict];
            if (tt == 0) {
                node.opened = YES;
            }
            [dataArr addObject:node];
            tt ++;

            [node release];
        }
        
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYINFO_PROPERTY_LIST],REQ_CODE,dataArr,RESP_CONTENT,nil];
        [_delegate requestFinished:respDict];
        
        
    }


}

//TODO:我的任务-随时赚列表
- (void)doRespMyTaskAnyTimeBuyList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    
    for(NSDictionary *dict in topicList)
    {
        MyTaskAnyCellNode *node = [[MyTaskAnyCellNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYTASKS_BUY_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:我的任务-随心兑列表
- (void)doRespMyTaskGetList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    
    for(NSDictionary *dict in topicList)
    {
        MyGoodsListNode *node = [[MyGoodsListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYGOODS_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}


//TODO:我的-随心兑详情
- (void)doRespMyExchangeDetail:(NSDictionary *)dict{

    ExchangeDetailNode *node = [[ExchangeDetailNode alloc] initWithDict:dict];
    
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYEXCHAGE_DETAIL],REQ_CODE,node,RESP_CONTENT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}
//TODO:我的任务-免费抽列表
- (void)doRespMyTaskLayList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    
    for(NSDictionary *dict in topicList)
    {
        MyTaskLayCellNode *node = [[MyTaskLayCellNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYTASKS_LAY_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:我的消息
- (void)doRespMyNewsList:(NSDictionary *)dict{
    
    if (dict.count == 0) {
        NSMutableArray *dataArr = [NSMutableArray array];
        

        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYNEWS_LIST],REQ_CODE,dataArr,RESP_CONTENT,nil];
            
            [_delegate requestFinished:respDict];
        }
    }else{
        NSArray  *topicList = [dict objectForKey:RESP_LIST];
        NSMutableArray *dataArr = [NSMutableArray array];
        NSString *next = [dict objectForKey:RESP_NEXT];
        
        for(NSDictionary *dict in topicList)
        {
            MyNewsListNode *node = [[MyNewsListNode alloc] initWithDict:dict];
            [dataArr addObject:node];
            [node release];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYNEWS_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
            
            [_delegate requestFinished:respDict];
    }
    
        
        
    }
    
}


//TODO:我的关注_随时赚
- (void)doRespMyConsList:(NSDictionary *)dict{
  
    
    if (dict.count == 0) {
        NSMutableArray *dataArr = [NSMutableArray array];
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYCON_LIST_BUY],REQ_CODE,dataArr,RESP_CONTENT,nil];
            
            [_delegate requestFinished:respDict];
        }
    }else{
        NSArray  *topicList = [dict objectForKey:RESP_LIST];
        NSMutableArray *dataArr = [NSMutableArray array];
        NSString *next = [dict objectForKey:RESP_NEXT];
        
        for(NSDictionary *dict in topicList)
        {
            BuylistNode *node = [[BuylistNode alloc] initWithDict:dict];
            [dataArr addObject:node];
            [node release];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYCON_LIST_BUY],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
            
            [_delegate requestFinished:respDict];
            
            
        }
        
        
    }
    
}
    
//TODO:我的关注_随心兑
- (void)doRespMyConsGoodsList:(NSDictionary *)dict{
    
    
    if (dict.count == 0) {
        NSMutableArray *dataArr = [NSMutableArray array];
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYCON_LIST_GOODS],REQ_CODE,dataArr,RESP_CONTENT,nil];
            
            [_delegate requestFinished:respDict];
        }
    }else{
        NSArray  *topicList = [dict objectForKey:RESP_LIST];
        NSMutableArray *dataArr = [NSMutableArray array];
        NSString *next = [dict objectForKey:RESP_NEXT];
        
        for(NSDictionary *dict in topicList)
        {
            GoodsListNode *node = [[GoodsListNode alloc] initWithDict:dict];
            [dataArr addObject:node];
            [node release];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYCON_LIST_GOODS],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
            
            [_delegate requestFinished:respDict];
            
            
        }
        
        
    }
    
}

//TODO:收货地址列表
- (void)doRespAddressList:(NSArray *)arr{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for(NSDictionary *dict in arr)
    {
        AddressNode *node = [[AddressNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_ADDRESS_LIST],REQ_CODE,dataArr,RESP_CONTENT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:兴趣爱好数据
- (void)doRespHobbiesList:(NSArray *)arr{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for(NSDictionary *dict in arr)
    {
        HobbiesNode *node = [[HobbiesNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_HOBBIES],REQ_CODE,dataArr,RESP_CONTENT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:我的银行卡列表
- (void)doRespBanksList:(NSArray *)arr{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for(NSDictionary *dict in arr)
    {
        MyBankListNode *node = [[MyBankListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYBANKCARD_LIST],REQ_CODE,dataArr,RESP_CONTENT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}
#pragma mark =============== 抽疯 ================
//TODO:抽疯首页广告
- (void)doRespSnatchHomeAds:(NSArray *)arr{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for(NSDictionary *dict in arr)
    {
        SnatchAdsNode *node = [[SnatchAdsNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_HOME_ADS],REQ_CODE,dataArr,RESP_CONTENT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:抽疯首页列表
- (void)doRespSnatchHomeLists:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
   
    
    for(NSDictionary *dict in topicList)
    {
        SnatchHomeListNode *node = [[SnatchHomeListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_HOME_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];

        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:抽疯商品详情
- (void)doRespSnatchGoodsDatail:(NSDictionary *)dict{
    //    NSDictionary  *deytail = [dict objectForKey:RESP_CONTENT];
    BuyDetailNode *node = [[BuyDetailNode alloc] initWithDict:dict];
    
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_DETAILS],REQ_CODE,dict,RESP_CONTENT,node,RESP_NODE,nil];
        
        [_delegate requestFinished:respDict];
        
    }
    
}

//TODO:晒单列表
- (void)doRespSnatchShaidanList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];

    
    for(NSDictionary *dict in topicList)
    {
        ShowMeNode *node = [[ShowMeNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_SHAIDAN_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:夺宝记录
- (void)doRespRecodeList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    
    
    for(NSDictionary *dict in topicList)    {
        SnatchRecordListNode *node = [[SnatchRecordListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_RECORD_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:我的中奖
- (void)doRespSnatchWinnerList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:RESP_NEXT];
    
    
    for(NSDictionary *dict in topicList)

    {
        WinningRecordNode *node = [[WinningRecordNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_MYWINNER_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}


//TODO:抽疯分类
- (void)doRespSnatchClassify:(NSArray *)arr{
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for(NSDictionary *dict in arr)
    {
        SnatchClassifyNode *node = [[SnatchClassifyNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_CLASSIFY],REQ_CODE,dataArr,RESP_CONTENT,nil];
        
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:支付结果列表
- (void)doRespMyPayResult:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *detail = [dict objectForKey:@"detail"];
    
    
    for(NSDictionary *dict in topicList)
    {
        SnatchPayNode *node = [[SnatchPayNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_KWELFARE_RESULT_SNATCHPAY],REQ_CODE,dataArr,RESP_CONTENT,detail,@"detail",nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}



//TODO:抽疯购物车列表
- (void)doRespSnatchCartLists:(NSArray *)arr{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    
    for(NSDictionary *dict in arr)
    {
        ShopCartNode *node = [[ShopCartNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_CART_LIST],REQ_CODE,dataArr,RESP_CONTENT,nil];
        
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:抽疯搜索列表
- (void)doRespSnatchSearchLists:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_CONTENT];
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for(NSDictionary *dict in topicList)
    {
        SnatchHomeListNode *node = [[SnatchHomeListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_HOME_LIST],REQ_CODE,dataArr,RESP_CONTENT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}


//TODO:往期揭晓
- (void)doRespSnatchPassedSnatchList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *next = [dict objectForKey:@"next"];

    for(NSDictionary *dict in topicList)
    {
        PassedSnatchNode *node = [[PassedSnatchNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_SNATCH_PASSED_LIST],REQ_CODE,dataArr,RESP_CONTENT,next,RESP_NEXT,nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:我的抢宝列表
- (void)doRespMyBagList:(NSDictionary *)dict{
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSMutableArray *dataArr = [NSMutableArray array];
    NSString *avatar = [dict objectForKey:@"avatar"];
    NSString *next = [dict objectForKey:@"next"];
    NSString *price = [dict objectForKey:@"price"];
    NSString *total = [dict objectForKey:@"total"];
    for(NSDictionary *dict in topicList)
    {
        MyBagListNode *node = [[MyBagListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYBAG_LIST],REQ_CODE,dataArr,RESP_LIST,avatar,@"avatar",next,RESP_NEXT,price,@"price",total,@"total",nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

//TODO:我的抢宝详情
- (void)doRespMyBagDetail:(NSDictionary *)dict{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSArray  *topicList = [dict objectForKey:RESP_LIST];
    NSDictionary *headDic = [dict objectForKey:@"detail"];
    NSString *next = [dict objectForKey:@"next"];
    for(NSDictionary *dict in topicList)
    {
        MyBagDetailListNode *node = [[MyBagDetailListNode alloc] initWithDict:dict];
        [dataArr addObject:node];
        [node release];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
        NSDictionary *respDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:REQ_MYBAG_DETAIL],REQ_CODE,dataArr,RESP_LIST,next,RESP_NEXT,headDic,@"detail",nil];
        
        [_delegate requestFinished:respDict];
        
        
    }
    
}

#pragma mark ===============响应分发================
//TODO:用户相关请求
-(void)doRespUserInfo:(NSDictionary *)dict
{
    int reqCode = [[dict objectForKey:REQ_CODE] intValue];
    switch (reqCode) {
            
            //登录
        case REQ_LOGIN:
  
        {
            [self doLoginResp:[dict objectForKey:RESP_CONTENT]];
            
        }
            break;
            // 获取总资产
        case REQ_INFO_ALLTOTAL:
        {
            [self doAlltotalResp:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            //重新登录
        case REQ_LOGIN_AGAIN:
        {
            [self doLoginAgainResp:[dict objectForKey:RESP_CONTENT]];
            
        }
            break;
            
            // 注册
        case REQ_REGISTER:{
            [self doRegisterResp:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            
        default:
            break;
    }
}


//TODO:列表数据响应
-(void)doRespListInfo:(NSDictionary *)dict{
    int reqCode = [[dict objectForKey:REQ_CODE] intValue];
    switch (reqCode) {
            //抽疯
            // 抽疯首页广告
        case REQ_SNATCH_HOME_ADS:        {
            [self doRespSnatchHomeAds:[dict objectForKey:RESP_CONTENT]];
            
        }
            break;
            // 抽疯首页列表
        case REQ_SNATCH_HOME_LIST:
        {
            [self doRespSnatchHomeLists:[dict objectForKey:RESP_CONTENT]];
            
        }
            
            break;
            
            // 抽疯商品详情
        case REQ_SNATCH_DETAILS:{
            [self doRespSnatchGoodsDatail:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 晒单列表
        case REQ_SNATCH_SHAIDAN_LIST:{
            [self doRespSnatchShaidanList:[dict objectForKey:RESP_CONTENT]];
        }
            break;

            // 夺宝记录
        case REQ_SNATCH_RECORD_LIST:{
            [self doRespRecodeList:[dict objectForKey:RESP_CONTENT]];

        }
            break;
            // 我的中奖
        case REQ_SNATCH_MYWINNER_LIST:{
            [self doRespSnatchWinnerList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            
            // 我的抢宝
        case REQ_MYBAG_LIST: {
            [self doRespMyBagList:[dict objectForKey:RESP_CONTENT]];
            
        }
            
            break;
            // 我的详情
        case REQ_MYBAG_DETAIL: {
            [self doRespMyBagDetail:[dict objectForKey:RESP_CONTENT]];
            
        }
            
            break;
            // 支付结果
        case REQ_KWELFARE_RESULT_SNATCHPAY: {
            [self doRespMyPayResult:[dict objectForKey:RESP_CONTENT]];
            
        }
            
            break;
           
            // 购物车列表
        case REQ_SNATCH_CART_LIST:       {
            [self doRespSnatchCartLists:[dict objectForKey:RESP_CONTENT]];
            
        }
            
            break;

            
            break;
            // 分类浏览
        case REQ_SNATCH_CLASSIFY:  {
            [self doRespSnatchClassify:[dict objectForKey:RESP_CONTENT]];
        }
            break;

        // 往期揭晓
        case REQ_SNATCH_PASSED_LIST:{
            [self doRespSnatchPassedSnatchList:[dict objectForKey:RESP_CONTENT]];
 
        }
            break;
            //首页列表
        case REQ_HOME_LIST:
        {
            [self doRespHomeList:[dict objectForKey:RESP_CONTENT]];
            
        }
            break;
            // 随时赚列表
        case REQ_ANYTIMEBUY_LIST:    {
            [self doRespAnyTimeBuyList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 随时赚详情
        case REQ_ANYTIMEBUY_DETAIL:{
            [self doRespAnyTimeBuyDatail:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 随心兑详情
        case REQ_GOODSBUY_DETAIL:{
            [self doRespGoodsBuyDatail:[dict objectForKey:RESP_CONTENT]];
        }
            break;

            // 随心兑列表
        case REQ_GOODSBUY_LIST:
        {
            [self doRespAnyThingGetList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 我要抽列表
        case REQ_ANYTHINGLAY_LIST:
        {
            [self doRespAnyThingLayList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            
            // 资产明细
        case REQ_MYINFO_PROPERTY_LIST:
        {
            [self doRespPropertyList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            //随时赚列表
        case REQ_MYTASKS_BUY_LIST:
        {
            [self doRespMyTaskAnyTimeBuyList:[dict objectForKey:RESP_CONTENT]];
        }
            break;

            
            //我的随心兑列表
        case REQ_MYGOODS_LIST:     {
            [self doRespMyTaskGetList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            //我的随心兑详情
        case REQ_MYEXCHAGE_DETAIL:   {
            [self doRespMyExchangeDetail:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            //我的任务随时抽列表
        case REQ_MYTASKS_LAY_LIST:     {
            [self doRespMyTaskLayList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 我的消息
        case REQ_MYNEWS_LIST: {
            [self doRespMyNewsList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 我的关注_随时赚
        case REQ_MYCON_LIST_BUY:{
            [self doRespMyConsList:[dict objectForKey:RESP_CONTENT]];

        }
            break;
            // 我的关注_随心兑
        case REQ_MYCON_LIST_GOODS:{
            [self doRespMyConsGoodsList:[dict objectForKey:RESP_CONTENT]];
            
        }
            break;
            // 地址列表
        case REQ_ADDRESS_LIST:
        {
            [self doRespAddressList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 兴趣爱好
        case REQ_HOBBIES:    {
            [self doRespHobbiesList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            //我的银行卡列表
        case REQ_MYBANKCARD_LIST:
        {
            [self doRespBanksList:[dict objectForKey:RESP_CONTENT]];
        }
            break;
            // 开机广告
        case REQ_LOADINGAD:
        {
            [self doRespLoadingAd:[dict objectForKey:RESP_CONTENT]];
        }
            break;
        default:
            break;
    }
    
    
}


#pragma mark -
#pragma mark ===============网络回调================
//TODO:请求成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *userInfo = request.userInfo;
    NSInteger reqCode = [[userInfo objectForKey:REQ_CODE] integerValue];

    NSString *plainText = [DES3Util AES128Decrypt:[request responseString]];
    NSMutableDictionary *resp = [NSMutableDictionary dictionaryWithDictionary:[plainText JSONValue]];

    if (reqCode == REQ_VERSION) {
        resp = [NSMutableDictionary dictionaryWithDictionary:[[request responseString] JSONValue]];
//        NSLog(@"resp is   =====  %@",resp);
        [resp setObject:[userInfo objectForKey:REQ_CODE] forKey:REQ_CODE];

        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            [_delegate requestFinished:resp];
            return;
        }

    }
    [resp setObject:[userInfo objectForKey:REQ_CODE] forKey:REQ_CODE];
    if ([userInfo objectForKey:RESP_USERINFO]) [resp setObject:[userInfo objectForKey:RESP_USERINFO] forKey:RESP_USERINFO];
//    NSLog(@"[request responseString]======== %@",[request responseString]);

//    NSLog(@"plainText======== %@",plainText);
    
    if ([[resp objectForKey:RESP_STATUS] integerValue] == 1 ) {
        isupdate = NO;
        switch (reqCode) {
                
                //登录
            case REQ_LOGIN:
                //重新登录
            case REQ_LOGIN_AGAIN:
                // 注册
            case REQ_REGISTER:
                // 获取总资产
            case REQ_INFO_ALLTOTAL:
            {
                [self doRespUserInfo:resp];
            }
                break;
                // 抽疯
                // 抽疯首页广告
            case REQ_SNATCH_HOME_ADS:
                // 抽疯首页列表
            case REQ_SNATCH_HOME_LIST:
                // 购物车列表
            case REQ_SNATCH_CART_LIST:
                // 分类浏览
            case REQ_SNATCH_CLASSIFY:
                // 往期揭晓
            case REQ_SNATCH_PASSED_LIST:
                // 晒单列表
            case REQ_SNATCH_SHAIDAN_LIST:
                // 夺宝记录
            case REQ_SNATCH_RECORD_LIST:
                // 我的中奖
            case REQ_SNATCH_MYWINNER_LIST:
                // 抽疯商品第三方支付后获取数据
            case  REQ_KWELFARE_RESULT_SNATCHPAY:
                
                // 我的抢宝
            case REQ_MYBAG_LIST:
                // 我的抢宝详情
            case REQ_MYBAG_DETAIL:
                // 首页
                // 首页列表
            case REQ_HOME_LIST:
                // 随时赚列表
            case REQ_ANYTIMEBUY_LIST:
                // 随心兑列表
            case REQ_GOODSBUY_LIST:
                
                // 我要抽列表
            case REQ_ANYTHINGLAY_LIST:
                // 资产明细
            case REQ_MYINFO_PROPERTY_LIST:
                //我的任务随时赚列表
            case REQ_MYTASKS_BUY_LIST:
                //我的任务随心兑列表
            case REQ_MYGOODS_LIST:
                //我的任务随时抽列表
            case REQ_MYTASKS_LAY_LIST:
                // 随时赚详情
            case REQ_ANYTIMEBUY_DETAIL:
                // 随心兑详情
            case REQ_GOODSBUY_DETAIL:
                
                // 地址列表
            case REQ_ADDRESS_LIST:
                // 我的消息
            case REQ_MYNEWS_LIST:
                // 我的关注
            case REQ_MYCON_LIST_BUY:
            case REQ_MYCON_LIST_GOODS:
                //兴趣爱好
            case REQ_HOBBIES:
                //我的随心兑详情
            case REQ_MYEXCHAGE_DETAIL:
                //我的银行卡列表
            case REQ_MYBANKCARD_LIST:
                // 开机广告
            case REQ_LOADINGAD:
            {
                [self doRespListInfo:resp];
            }
                break;
                
                //注册 获取验证码
            case REQ_GETCODE:
                // 验证验证码
            case REQ_VERIFY:
                //修改信息
            case REQ_MODIFYINFO:
                // 新增/编辑地址
            case REQ_ADDRESS_ADD:
                // 删除地址
            case REQ_ADDRESS_DELETE:
                // 关注
            case REQ_FAV:
                //领取随时赚任务
            case REQ_ANYTIMEBUY_GETTASK:
                //做随时赚的任务
            case REQ_ANYTIMEBUY_DOTASK:
                // 修改头像
            case REQ_EDITHEAD:
                // 是否实名
            case REQ_ISREALNAME:
                // 随心兑兑换
            case REQ_GOODSBUY_BUY:
                // 上传评论
            case REQ_COMMENT_SEND:
                // 取消兑换
            case REQ_MYEXCHAGE_CLOSE:
                // 确认兑换
            case REQ_MYEXCHAGE_SURE:
                // 修改手机号
            case REQ_MODIFY_PHONE:
                // 修改登录密码
            case REQ_MODIFY_LOGINPWD:
                // 修改支付密码
            case REQ_MODIFY_PAYPWD:
                // 网页扫码登录
            case REQ_HOME_LOGINWEB:
                // 删除我的银行卡
            case REQ_MYBANKCARD_DELETE:
                // 删除消息
            case REQ_MYNEWS_DELETE:
                // 我的随心兑删除
            case REQ_MYGOODS_DELETE:
                // 我的随时赚删除
            case REQ_MYTASKS_BUY_DELETE:
                // 我的随时赚终止
            case REQ_MYTASKS_BUY_END:
                // 银行网点
            case REQ_BANK_BRANCH:
                // 提现
            case REQ_MONEY_APPLY:
                // 余额查询
            case REQ_GETBALANCE:
                // 可用余额查询
            case REQ_GETBALANCE_FREE:
                // 获取支付宝充值订单
            case REQ_PAY_ZFB_ORDER:
                // 获取微信充值订单
            case REQ_PAY_WX_ORDER:
                
                // ==== 抽疯 ====
                // 获取购物车数量
            case REQ_SNATCH_CART_COUNT:
                // 加入购物车
            case REQ_SNATCH_CART_ADD:
                // 移除购物车
            case REQ_SNATCH_CART_LESS:
                // 我的中奖状态
            case REQ_SNATCH_MYWINNER_DETAILS:
                //设置奖品收货地址
            case REQ_SNATCH_MYWINNER_ADDRESS:
                //确认奖品收货
            case REQ_SNATCH_MYWINNER_SURE:
                // 获取可参与数据
            case REQ_SNATCH_CANADD:
                // 立即支付
            case REQ_SNATCH_PAYNOW:
                // ==== 口令抢宝 ====
                
                // 领取抽奖码
                // 输入抽奖码
            case REQ_KL_GETCODE:
                // 加入抽奖
            case REQ_KL_JOIN:
                // 进行支付
            case REQ_KWELFARE_CREATE:
                // 进行支付-群
            case REQ_KWELFARE_CREATE_GROUP:
                // 第三方支付后获取数据
            case  REQ_KWELFARE_RESULT:
                
            {
                if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
                    [_delegate requestFinished:resp];
                    
                }
            }
                break;
            default:
                break;
        }
    }
    else
    {
 
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ErrorCodeList" ofType:@"plist"];
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        //        NSLog(@"%@", data);//直接打印数据
//        NSString *errorcode = [resp objectForKey:RESP_ERRORCODE];
//        NSString *errmsg = [data objectForKey:errorcode];
        NSString *errorinfo = [resp objectForKey:@"info"];
        NSString *errmsg = [resp objectForKey:RESP_ERRORMSG];

        if (errmsg){
            [resp setObject:errmsg forKey:RESP_MSG];

        }
        
        if (reqCode == REQ_MODIFY_LOGINPWD && [errorinfo isEqualToString:@"000000"] ) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
                [_delegate requestFinished:resp];
                
            }
            return;
        }
//        if (reqCode == REQ_MODIFY_PAYPWD && [errorinfo isEqualToString:@"000000"] ) {
//            if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
//                [_delegate requestFinished:resp];
//                
//            }
//            return;
//        }
        if (errmsg) {
            [resp setObject:errmsg forKey:RESP_MSG];
 
        }else{
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ErrorCodeList" ofType:@"plist"];
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            //            NSLog(@"%@", data);//直接打印数据
            NSString *errorcode = [resp objectForKey:RESP_ERRORCODE];
            NSString *errmsg = [data objectForKey:errorcode];
            [resp setObject:errmsg forKey:RESP_MSG];

        }
        if (_delegate && [_delegate respondsToSelector:@selector(requestFailed:)]) {
            [_delegate requestFailed:resp];
        }
    }
    
    if (1 >= _httpQueue.requestsCount && _delegate && [_delegate respondsToSelector:@selector(allRequestDone)]) {
        [_delegate allRequestDone];
    }
}

//TODO:请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    isupdate = YES;
    
    NSError *error = [request error];
    NSDictionary *userInfo = request.userInfo;
    NSMutableDictionary *resp = [NSMutableDictionary dictionary];
    [resp setObject:[userInfo objectForKey:REQ_CODE] forKey:REQ_CODE];
    [resp setObject:error forKey:REQ_ERROR];
    NSString *err = [resp objectForKey:RESP_ERRORCODE];
    
    switch ([err integerValue]) {
        case 0:
            [resp setObject:@"网络请求失败" forKey:RESP_ERRORCODE];
            
            break;
            
        default:
            break;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestFailed:)]) {
        [_delegate requestFailed:resp];
    }
    
    if (1 >= _httpQueue.requestsCount && _delegate && [_delegate respondsToSelector:@selector(allRequestDone)]) {
        [_delegate allRequestDone];
    }
}

//TODO:进度
-(void)setProgress:(float)newProgress
{
    if (_delegate && [_delegate respondsToSelector:@selector(setProgress:)]) {
        [_delegate setProgress:newProgress];
    }
    NSLog(@"progress %f",newProgress);
}

@end
