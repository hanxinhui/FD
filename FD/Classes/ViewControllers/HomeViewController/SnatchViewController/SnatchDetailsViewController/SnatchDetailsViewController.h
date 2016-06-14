//
//  MyFavViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:奖品详情

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddCountersignView.h"
#import "SnatchDetailNode.h"


@interface SnatchDetailsViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate,AddCountersignViewDelegate>
{
    float setHeight;//设置高度
   
}


@property (nonatomic, strong) UIWebView  *detailWebView;// 详情
@property (nonatomic, strong) UIButton *addNowBtn;//立即参加
@property (nonatomic, strong) UIButton *addCartBtn;//加入购物车
@property (nonatomic, strong) UIButton *toCartBtn;//进入购物车
@property (nonatomic, strong) UILabel   *showLab;//说明lab
@property (nonatomic, strong) NSString          *goodID;//商品id
@property (nonatomic, strong) NSString          *jsonString;//数据
@property (nonatomic, strong) AddCountersignView   *addCountersignView;//参与
@property (nonatomic, strong) UIButton  *bgHiddenBtn;//
@property (nonatomic, strong) SnatchDetailNode  *detaiNode;//数据
@property (nonatomic, strong) NSString  *winGoodsIds;//

@end

