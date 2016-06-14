//
//  SnatchClassifyListCell.h
//  FD
//
//  Created by leoxu on 15/12/16.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnatchHomeListNode.h"


@protocol SnatchClassifyListCellDelegate <NSObject>

- (void)addCart:(id)sender;// 加入购物车
- (void)showDetail:(id)sender;// 详情


@end

@interface SnatchClassifyListCell : UITableViewCell

@property (nonatomic, assign) id<SnatchClassifyListCellDelegate>          delegate;//


@property (nonatomic, strong) UIImageView   *goodsImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UIProgressView    *progressView;//进度条
@property (nonatomic, strong) UIButton    *addBtn;//加入清单
@property (nonatomic, strong) UILabel       *needLab;//总需
@property (nonatomic, strong) UILabel       *residueLab;//剩余
@property (nonatomic ,strong) UIButton    *showBtn;//详情


@property (nonatomic, strong) SnatchHomeListNode      *node;// 数据


@end
