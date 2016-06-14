   //
//  SnatchClassifyViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:抽疯 分类

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "SnatchHomeListNode.h"

typedef enum {
    ClassifyCountersign,// 抢宝分类
    ClassifySnatch // 意愿宝分类
    
} ClassifyStyle;



@interface SnatchClassifyViewController :  BaseViewController<FHTableViewDelegate>
{
    float setHeight;//设置高度
     BOOL  isLoading;//是否刷新
    
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, strong) UIImageView       *noImgView;// 没有数据显示视图

//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (nonatomic) ClassifyStyle       classifyStyle;// 请求类型

@end

