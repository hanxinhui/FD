//
//  MyTaskLayCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTaskLayCellNode.h"

@interface MyTaskLayCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *conLab;//说明
@property (nonatomic, strong) UILabel       *marginLab;//保证金
@property (nonatomic, strong) UIButton       *stateBtn;//状态

@property (nonatomic, strong) MyTaskLayCellNode      *node;// 数据

@end


