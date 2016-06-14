//
//  MyFavViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:抢宝详情

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyBagDetailHeadView.h"
#import "MyBagOpenHeadView.h"
#import "MyBagPublishHeadView.h"
#import "FHTableView.h"
#import "MyBagDetailCell.h"
#import "AddCountersignView.h"
#import "SnatchDetailNode.h"

typedef enum {
    WelfareCountersign,// 土豪抽疯
    GroupCountersign // 集体抽疯
    
} CountersignStyle;

@interface MyCountersignDetailViewController : BaseViewController<FHTableViewDelegate,MyBagDetailHeadViewDelegate,MyBagOpenHeadViewDelegate,MyBagPublishHeadViewDelegate,MyBagDetailCellDelegate,AddCountersignViewDelegate>
{
    
    float setHeight;//设置高度
 
    BOOL  isLoading;
    
    NSInteger nowStatus;
    
    NSInteger   goodID;
}

@property (nonatomic) CountersignStyle       countersignStyle;// 请求类型

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, strong) UIImageView       *noImgView;// 没有数据显示视图

//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;

@property (assign, nonatomic) int page; //当前页
@property (nonatomic, strong) UIView    *showHeadView;//显示头部界面
@property (nonatomic, strong) MyBagDetailHeadView  *detailHeadView;//进行
@property (nonatomic, strong) MyBagOpenHeadView     *openHeadView;//开奖
@property (nonatomic, strong) MyBagPublishHeadView  *publishHeadView;//揭晓


@property (nonatomic, strong) NSString      *detailID;//详情id
@property (nonatomic, assign) BOOL          isMyJoin;//是否我参与&我发起
@property (nonatomic, assign) BOOL          isKLjoin;//是否口令进入

@property (nonatomic, strong) UIButton       *shareWXBtn;//分享微信进入
@property (nonatomic, strong) NSDictionary       *coderesultDic;//数据
@property (nonatomic, assign) BOOL          isGroupjoin;//是否已经参加的群抢宝进入
@property (nonatomic, strong) AddCountersignView   *addCountersignView;//参与
@property (nonatomic, strong) UIButton  *bgHiddenBtn;//
@property (nonatomic, strong) SnatchDetailNode  *detaiNode;//数据

@end

