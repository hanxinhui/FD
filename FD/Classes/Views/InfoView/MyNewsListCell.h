//
//  MyNewsListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNewsListNode.h"

@interface MyNewsListCell : UITableViewCell

@property (nonatomic, strong) UILabel       *typeLab;//信息类别
@property (nonatomic, strong) UILabel       *formLab;//来源
@property (nonatomic, strong) UILabel       *contentLab;//正文
@property (nonatomic, strong) UILabel       *timeLab;//时间

@property (nonatomic, strong) MyNewsListNode      *node;// 数据

@end


