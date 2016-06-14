//
//  GoodsListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListNode.h"

@interface GoodsListCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *desLab;//商品详情
@property (nonatomic, strong) UILabel       *priceLab;//价格
@property (nonatomic, strong) UILabel       *stockLab;//库存

@property (nonatomic, strong) GoodsListNode      *node;// 数据

@end


