//
//  PropertyListViewController.h
//  FD
//
//  Created by Leo on 15-7-10.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

// 账户明细

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PropertyListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isFirstIn;// 第一次进入
    NSInteger  nowSel;// 当前选择
}

@property (nonatomic, strong)  UITableView  *mainTableView;// 主列表
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, strong) UIImageView  *noImgView;// 没有数据显示视图

@end
