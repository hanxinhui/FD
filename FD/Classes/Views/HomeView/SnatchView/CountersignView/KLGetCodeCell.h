//
//  KLGetCodeCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLGetCodeNode.h"

@interface KLGetCodeCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *phoneLab;//电话
@property (nonatomic, strong) UILabel       *numLab;//号码数目
@property (nonatomic, strong) UILabel       *timeLab;//时间

@property (nonatomic, strong) KLGetCodeNode      *node;// 数据

@end


