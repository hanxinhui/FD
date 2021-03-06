//
//  PayResultViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:支付结果

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PayResultHeadView.h"
#import "FHTableView.h"



@interface PayResultViewController : BaseViewController<PayResultHeadViewDelegate,FHTableViewDelegate>
{

    float setHeight;//设置高度
    BOOL  isLoading;//是否刷新
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, strong) NSDictionary      *listDic;//数据


@end

