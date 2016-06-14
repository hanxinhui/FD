//
//  PropertyListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyListNode.h"

@interface PropertyListCell : UITableViewCell


@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *timeLab;//时间
@property (nonatomic, strong) UILabel       *priceLab;//价格

@property (nonatomic, strong) PropertyListNode      *node;// 数据

@end


