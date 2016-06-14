//
//  SnatchRecordListViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:夺宝记录

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"
#import "SnatchRecodeListCell.h"
#import "SnatchRecodingListCell.h"
#import "SnatchUnRecodeListCell.h"
#import "SnatchDetailNode.h"
#import "AddCountersignView.h"


@interface SnatchRecordListViewController : BaseViewController<FHTableViewDelegate,SnatchRecodeListCellDelegate,SnatchRecodingListCellDelegate,SnatchUnRecodeListCellDelegate,AddCountersignViewDelegate>
{
    float setHeight;//设置高度
     NSInteger  seType;// 选中
    
        
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (nonatomic, strong) UIImageView       *noImgView;// 没有数据显示视图
@property (nonatomic, strong) SnatchDetailNode  *detaiNode;//数据
@property (nonatomic, strong) AddCountersignView   *addCountersignView;//参与
@property (nonatomic, strong) UIButton  *bgHiddenBtn;//
@end

