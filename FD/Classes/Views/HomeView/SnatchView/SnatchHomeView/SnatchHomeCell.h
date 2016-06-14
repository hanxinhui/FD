//
//  GoodsListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//
//TODO:首页列表cell

#import <UIKit/UIKit.h>
#import "SnatchHomeListNode.h"
#import "SnatchGoodsView.h"

@protocol SnatchHomeCellDelegate <NSObject>

- (void)addCart:(id)sender;// 加入购物车
- (void)showDetail:(id)sender;// 详情

@end
@interface SnatchHomeCell : UITableViewCell<SnatchGoodsViewDelegate>

@property (nonatomic, strong) SnatchGoodsView *firstGoodsView;// 第一个界面
@property (nonatomic, strong) SnatchGoodsView *secondGoodsView;// 第二个界面
@property (nonatomic, assign) id<SnatchHomeCellDelegate>          delegate;//

@end


