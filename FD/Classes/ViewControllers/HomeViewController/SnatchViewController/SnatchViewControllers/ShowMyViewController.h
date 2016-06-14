//
//  ShowMyViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:晒单

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FHTableView.h"



@interface ShowMyViewController :  BaseViewController<FHTableViewDelegate>
{
    float setHeight;//设置高度
    
}

@property (nonatomic, strong) FHTableView   *conTabView;// 数据加载tab
@property (nonatomic, strong) NSMutableArray      *listDataArr;//列表数据
@property (nonatomic, assign) NSString      *goodsid;//传入商品id

//是否是刷新
@property (assign, nonatomic) BOOL isReLoad;
//当前页
@property (assign, nonatomic) int page;
@property (nonatomic, strong) UIImageView       *noImgView;// 没有数据显示视图

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

