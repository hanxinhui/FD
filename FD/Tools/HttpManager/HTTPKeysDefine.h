//
//  HTTPKeysDefine.h
//  cardPreferential
//
//  Created by leo xu on 13-4-11.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#ifndef HTTPKeysDefine_h
#define HTTPKeysDefine_h

#define REQ_CODE                @"local_reqCode"
#define RESP_CONTENT            @"info"
#define RESP_STATUS             @"status"
#define REQ_ERROR               @"error"
#define RESP_NEXT               @"next"
#define RESP_UID                @"uid"
#define RESP_LIST               @"list"
#define RESP_CATE               @"cate"
#define RESP_USERINFO           @"userinfo"
#define RESP_ERRORCODE                @"errorCode"
#define RESP_PAGENUM                @"total"// 总计的页数
#define RESP_MSG           @"msg"// 提示信息
#define RESP_ERRORMSG           @"errorMsg"// 错误信息

#define RESP_NODE           @"node"// node数据

// 首页
#define REQ_HOMELIST        @"topicList"
#define REQ_MSGNUM        @"msgNum"


typedef enum{
#pragma mark === 注册登录 先保留===
    // 登录
    REQ_LOGIN = 10000,
    // 再次登录
    REQ_LOGIN_AGAIN,
    // 获取验证码
    REQ_GETCODE,
    // 验证验证码
    REQ_VERIFY,
    // 注册
    REQ_REGISTER,

    
#pragma mark === 首页 ===
    // 首页列表
    REQ_HOME_LIST = 20000,
    // 网页登陆
    REQ_HOME_LOGINWEB,
    // 随时赚列表
    REQ_ANYTIMEBUY_LIST,
    // 随时赚详情
    REQ_ANYTIMEBUY_DETAIL,
    // 评论详情
    REQ_COMMENT_DETAIL,
    // 评论
    REQ_COMMENT_SEND,
    // 领取随时赚任务
    REQ_ANYTIMEBUY_GETTASK,
    // 做随时赚的任务
    REQ_ANYTIMEBUY_DOTASK,
    // 随心兑列表
    REQ_GOODSBUY_LIST,
    // 随心兑详情
    REQ_GOODSBUY_DETAIL,
    // 随心兑 购买
    REQ_GOODSBUY_BUY,
    // 是否实名制
    REQ_ISREALNAME ,
    // 我要抽列表
    REQ_ANYTHINGLAY_LIST,
    // 我要抽详情
    REQ_ANYTHINGLAY_DETAIL,
    // 关注
    REQ_FAV,
    
#pragma mark === 签到 ===
    // 签到
    REQ_SIGN_DETAIL = 30000,
    // 签到说明
    REQ_SIGN_EXPLAIN,

    
#pragma mark === 抽疯 ===
    // 抽疯广告
    REQ_SNATCH_HOME_ADS = 40000,
    // 首页列表
    REQ_SNATCH_HOME_LIST,
    // 抽疯商品详情
    REQ_SNATCH_DETAILS,
    // 立即参与
    REQ_SNATCH_PAYNOW,
    // 获取可参与数据
    REQ_SNATCH_CANADD,
    // 获取购物车数量
    REQ_SNATCH_CART_COUNT,
    // 购物车列表
    REQ_SNATCH_CART_LIST,
    // 添加购物车
    REQ_SNATCH_CART_ADD,
    // 移除购物车
    REQ_SNATCH_CART_LESS,
////    // 预支付
////    REQ_SNATCH_PAYMENTING,
//    // 支付
//    REQ_SNATCH_PAYMENT,
    // 分类类别
    REQ_SNATCH_CLASSIFY,

    // 夺宝记录
    REQ_SNATCH_RECORD_LIST,
    // 我的中奖（中奖纪录）
    REQ_SNATCH_MYWINNER_LIST,
    // 中奖状态
    REQ_SNATCH_MYWINNER_DETAILS,
    // 确认奖品收货
    REQ_SNATCH_MYWINNER_SURE,
    // 设置奖品收货地址
    REQ_SNATCH_MYWINNER_ADDRESS,

    // 往期揭晓列表
    REQ_SNATCH_PASSED_LIST,
    // 晒单列表
    REQ_SNATCH_SHAIDAN_LIST,
#pragma mark === 口令抢宝 ===
    // 输入抽奖码
    REQ_KL_GETCODE = 50000,
    // 加入抽奖 口令
    REQ_KL_JOIN,
     // 进行支付 - 福利
    REQ_KWELFARE_CREATE,
    // 进行支付 - 群
    REQ_KWELFARE_CREATE_GROUP,
    // 第三方支付后获取数据
    REQ_KWELFARE_RESULT,
    // 参加抽疯奖品第三方支付后获取数据
    REQ_KWELFARE_RESULT_SNATCHPAY,

    // 我的抢宝- 我参与的
    REQ_MYBAG_LIST,
    // 详情
    REQ_MYBAG_DETAIL,

    
#pragma mark === 其他 ===
    // 一周排行
    REQ_WEEKRANK = 60000,


#pragma mark === 个人中心 ===
    // 资产明细
    REQ_MYINFO_PROPERTY_LIST = 70000,
    //余额查询
    REQ_GETBALANCE,
    // 获取可用余额
    REQ_GETBALANCE_FREE,

    // 我的随时赚列表
    REQ_MYTASKS_BUY_LIST,
    // 我的随时赚删除
    REQ_MYTASKS_BUY_DELETE,
    // 我的随时赚终止
    REQ_MYTASKS_BUY_END,
    // 我的随心兑列表
    REQ_MYGOODS_LIST,
    // 我的随心兑删除
    REQ_MYGOODS_DELETE,

    // 兑换详情
    REQ_MYEXCHAGE_DETAIL,
    // 兑换详情   取消订单
    REQ_MYEXCHAGE_CLOSE,
    // 兑换详情   确认订单
    REQ_MYEXCHAGE_SURE,
    // 我要抽
    REQ_MYTASKS_LAY_LIST,
    // 我的银行卡
    REQ_MYBANKCARD_LIST,
    // 删除我的银行卡
    REQ_MYBANKCARD_DELETE,

    // 我的消息
    REQ_MYNEWS_LIST,
    // 我的消息删除
    REQ_MYNEWS_DELETE,

    // 我的关注
    REQ_MYCON_LIST_BUY,
    REQ_MYCON_LIST_GOODS,
    // 修改个人信息
    REQ_MODIFYINFO,
    // 修改头像
    REQ_EDITHEAD,
    // 修改手机号
    REQ_MODIFY_PHONE,
    // 修改登录密码
    REQ_MODIFY_LOGINPWD,
    // 修改支付密码
    REQ_MODIFY_PAYPWD,
    
    // 我的地址列表
    REQ_ADDRESS_LIST,
    // 添加地址
    REQ_ADDRESS_ADD,
    // 删除地址
    REQ_ADDRESS_DELETE,
    // 兴趣爱好
    REQ_HOBBIES,
    // 申请提现
    REQ_MONEY_APPLY,
    // 获取银行网点接口
    REQ_BANK_BRANCH,
    // 获取支付宝充值订单
    REQ_PAY_ZFB_ORDER,
    // 获取微信充值订单
    REQ_PAY_WX_ORDER,
    // 获取总资产
    REQ_INFO_ALLTOTAL,
    
#pragma mark ===版本====
    REQ_VERSION = 80000,
    //模式请求
    REQ_MODEL,
    //开机广告
    REQ_LOADINGAD,
    //应用控制
    REQ_APPCONTROL
    
}HTTP_CODE;

//内网http://192.168.0.135
//外网http://139.196.38.105

// 链接前缀
//#define SERVER_URL              @"http://m.ihuluu.com/"
#define SERVER_URL              @"http://m-test.ihuluu.com/"


// 测试需要改的
//// 帮助反馈
//#define SERVER_HELPWEB             @"http://m.ihuluu.com/help/index.html"
//// 随心兑正文
//#define SERVER_GOODSBUY_CON          @"http://m.ihuluu.com/Goods/detail/id/"
//// 开机抽奖连接
//#define SERVER_HOME_LAY             @"http://m.ihuluu.com/Index/win/uid/"
// 帮助反馈
#define SERVER_HELPWEB             @"http://m-test.ihuluu.com/help/index.html"
// 随心兑正文
#define SERVER_GOODSBUY_CON          @"http://m-test.ihuluu.com/Goods/detail/id/"
// 开机抽奖连接
#define SERVER_HOME_LAY             @"http://m-test.ihuluu.com/Index/win/uid/"

// 随时赚正文
#define SERVER_ANYTIMEBUY_CON          @"Spread/detail/id/"
// 更多评论中的评论
#define SERVER_MORECOMMENT_COM          @"Comment/detail"
// 添加银行卡
#define SERVER_ADDBANK          @"Trade/addCard/uid/"

// 版本更新
#define SERVER_APPSTORE_VERSION         @"https://itunes.apple.com/lookup?id=1033843787"

#define SERVER_LOADINGAD         @"Api/Index/recommend/"


// 登录
#define SERVER_LOGIN                    @"Api/User/signin/"
// 网页登陆
#define SERVER_HOME_LOGINWEB                   @"Api/User/setPcSignIn/"

// 获取验证码
//#define SERVER_GETCODE                 @"/user/getverify/debug/1/"
#define SERVER_GETCODE                 @"Api/user/getverify/"
// 验证验证码
#define SERVER_VERIFY                 @"Api/user/checkverify/"
// 注册
#define SERVER_REGISTER                 @"Api/user/signup/"



// 首页
// 首页列表
#define SERVER_HOME_LIST             @"Api/Index/index"

// 签到
#define SERVER_SIGN_DETAIL             @"Sign/home"
// 签到说明
#define SERVER_SIGN_EXPLAIN            @"Sign/explain"

// 随时赚列表
#define SERVER_ANYTIMEBUY_LIST          @"Api/Spread/getList2"
// 随时赚详情
#define SERVER_ANYTIMEBUY_DETAIL          @"Api/Spread/getDetail"
// 评论详情
#define SERVER_COMMENT_DETAIL          @"http://api.ihuluu.com/Comment/index"
// 评论
#define SERVER_COMMENT_SEND          @"Api/Comment/add"

// 领取随时赚任务
#define SERVER_ANYTIMEBUY_GETTASK          @"Api/Mission/createSpread"
// 做随时赚的任务
#define SERVER_ANYTIMEBUY_DOTASK          @"Api/Mission/createSpreadProcess"

// 随心兑列表
#define SERVER_GOODSBUY_LIST          @"Api/Goods/getList"
// 随心兑详情
#define SERVER_GOODSBUY_DETAIL          @"Api/Goods/getDetail"

// 随心兑 兑
#define SERVER_GOODSBUY_BUY          @"Api/Goods/buy"
// 是否实名制
#define SERVER_ISREALNAME          @"Api/User/isRealy"

// 我要抽列表
#define SERVER_ANYTHINGLAY_LIST          @"Api/Draw/getList"
// 我要抽详情
#define SERVER_ANYTHINGLAY_DETAIL          @"Api/Draw/getDetail"

// 关注
#define SERVER_FAV          @"Api/Atten/edit"

//====== 抽疯 ======
// 抽疯广告
#define SERVER_SNATCH_HOME_ADS          @"Api/Indiana/getBanner"
// 首页列表
#define SERVER_SNATCH_HOME_LIST          @"Api/Indiana/getList"
// 详情
#define SERVER_SNATCH_DETAILS          @"Indiana/detail/"
// 获取可参与数据
#define SERVER_SNATCH_CANADD         @"Api/Indiana/getIndianaInfo"
// 立即参与
#define SERVER_SNATCH_PAYNOW         @"Api/Indiana/payCart"

// 常见问题
#define SERVER_SNATCH_QUESTION         @"indiana/help"

// 往期揭晓列表
#define SERVER_SNATCH_PASSED_LIST          @"Api/Indiana/getWangQi"
// 晒单列表
#define SERVER_SNATCH_SHAIDAN_LIST          @"Api/Indiana/getShaiDan"

// 我的中奖
#define SERVER_SNATCH_MYWINNER_LIST          @"Api/Indiana/getMyWinList"
// 中奖状态
#define SERVER_SNATCH_MYWINNER_DETAILS          @"Api/Indiana/getMyWinDetail"
// 设置奖品收货地址
#define SERVER_SNATCH_MYWINNER_ADDRESS          @"Api/Indiana/setMyWinAddr"
// 中奖状态
#define SERVER_SNATCH_MYWINNER_SURE          @"Api/Indiana/ensureReceiveGoods"

// 获取购物车数量
#define SERVER_SNATCH_CART_COUNT          @"Api/Indiana/getCartCount"

// 购物车列表
#define SERVER_SNATCH_CART_LIST          @"Api/Indiana/getCart"
// 添加购物车
#define SERVER_SNATCH_CART_ADD          @"Api/Indiana/addCart"
// 移除购物车
#define SERVER_SNATCH_CART_LESS          @"Api/Indiana/removeCart"

//// 预支付
//#define SERVER_SNATCH_PAYMENTING         @"Api/Indiana/prePayCart"
//// 支付
//#define SERVER_SNATCH_PAYMENT          @"Api/Indiana/payCart"


// 分类类别
#define SERVER_SNATCH_CLASSIFY          @"Api/Indiana/getCategory"

// 夺宝记录
#define SERVER_SNATCH_RECORD_LIST          @"Api/Indiana/getMyJoinList"





//======  口令抢宝 ===

// 输入抽奖码
#define SERVER_KL_GETCODE          @"Api/Indiana/getWelfareIndianaByCode"
// 加入抽奖 口令
#define SERVER_KL_JOIN         @"Api/Indiana/joinWelfareIndiana"


// 进行支付- 群
#define SERVER_KWELFARE_CREATE          @"Api/Indiana/createWelfareIndiana"
#define SERVER_KWELFARE_CREATE_GROUP          @"Api/Indiana/createCrowdIndiana"

// 第三方支付后获取数据
#define SERVER_KWELFARE_RESULT          @"Api/Indiana/getCodeByOutTradeNo"
// 参加抽疯奖品第三方支付后获取数据
#define SERVER_KWELFARE_RESULT_SNATCHPAY          @"Api/Indiana/getCodeByOutTradeNo"


// 我的抢宝
// 列表
#define SERVER_MYBAG_LIST          @"Api/Indiana/getMyIndianaPasswordList"
// 详情
#define SERVER_MYBAG_DETAIL          @"Api/Indiana/getIndianaPasswordDetail"




// 一周排行
#define SERVER_WEEKRANK          @"Api/Indiana/edit"


#pragma mark === 个人中心 ===
// 资产明细
#define SERVER_MYINFO_PROPERTY_LIST         @"Api/stream/getList"
//余额查询
#define SERVER_GETBALANCE        @"Api/Stream/getBalance"
//可用余额查询（兑换商品）
#define SERVER_GETBALANCE_FREE        @"Api/Stream/getFreeBalance"

//我的任务
// 随时赚
#define SERVER_MYTASKS_BUY_LIST             @"Api/Mission/getSpreadList"
// 我的随时赚删除
#define SERVER_MYTASKS_BUY_DELETE             @"Api/Spread/delSpread"
// 终止任务
#define SERVER_MYTASKS_DELETETASK             @"Api/Spread/delSpread"


// 我的随时赚终止
#define SERVER_MYTASKS_BUY_END             @"Api/Mission/cancelSpreadMission"

// 我的兑换
#define SERVER_MYGOODS_LIST             @"Api/Order/getList"
// 我的随心兑删除
#define SERVER_MYGOODS_DELETE             @"Api/Order/delOrder"

// 兑换详情
#define SERVER_MYEXCHAGE_DETAIL             @"Api/Order/getDetail"
// 兑换详情   取消订单
#define SERVER_MYEXCHAGE_CLOSE             @"Api/Order/closeOrder"
// 兑换详情   确认订单
#define SERVER_MYEXCHAGE_SURE             @"Api/Order/finishOrder"
// 物流详情
#define SERVER_EMAIL_DETAILES             @"http://m.ihuluu.com//goods/queryExpress/id/"

// 我要抽
#define SERVER_MYTASKS_LAY_LIST             @"Api/Mission/getGoodsList"

// 我的银行卡
#define SERVER_MYBANKCARD_LIST            @"Api/Card/getList"
// 删除我的银行卡
#define SERVER_MYBANKCARD_DELETE            @"Api/Card/delete"

// 我的消息
#define SERVER_MYNEW_LIST               @"Api/Index/getMsg"
// 我的消息删除
#define SERVER_MYNEW_DELETE               @"Api/Index/delMsg"

// 我的关注
#define SERVER_MYCON_LIST               @"Api/Atten/getList"

// 修改个人信息
#define SERVER_MODIFYINFO             @"Api/User/editInfo"
// 兴趣爱好
#define SERVER_HOBBIES             @"Api/Index/getInterest"
// 申请提现
#define SERVER_MONEY_APPLY             @"Api/Stream/withDraw"
// 获取银行网点接口
#define SERVER_BANK_BRANCH             @"Api/Card/getBankPointList"
// 获取总资产
#define SERVER_INFO_ALLTOTAL            @"Api/User/getinfo"
// 获取支付宝充值订单
#define SERVER_PAY_ZFB_ORDER            @"Api/Pay/getOrderInfo"
// 获取微信充值订单
#define SERVER_PAY_WX_ORDER            @"Api/Pay/getWxOrderInfo"



// 修改头像
#define SERVER_EDITHEAD             @"Api/user/uploadHead"

//三方登录
#define SERVER_LOGIN_OTHER            @""
//绑定手机号
#define SERVER_BANGDING_PHONE            @""
//解除绑定手机号
#define SERVER_BANGDING_MOVE            @""
//找回密码
#define SERVER_FIND_PWD         @""
//完善信息
#define SERVER_PERFECTINFO         @""
//修改用户信息
#define SERVER_CHANGEINFO       @""

// 修改手机号
#define SERVER_MODIFY_PHONE       @"Api/User/resetMobile/"

// 修改登录密码
#define SERVER_MODIFY_LOGINPWD       @"Api/User/setSigninPwd/"

// 修改支付密码
#define SERVER_MODIFY_PAYPWD       @"Api/User/setPayPwd/"

// 我的地址列表
#define SERVER_ADDRESS_LIST       @"Api/Addr/getList"

// 添加地址
#define SERVER_ADDRESS_ADD       @"Api/Addr/edit"

// 删除地址
#define SERVER_ADDRESS_DELETE       @"Api/Addr/delete"




// 当前版本
#define NOW_VERSION             @"1.0"
// AppStore版本
#define APPSTORE_VERSION        @"APPSTORE_VERSION"
// 下载链接
#define APPSTORE_URL            @"APPSTORE_URL"

// 版本信息
#define VERSION_NEWS            @"VERSION_NEWS"


// 信息加密 解密
#define SECRET_KEY    @"7l0p4js9fu6yfwfweu83u41ndbi1ejn2"
#define SECRET_VEC    @"70503102"

#endif
