//
//  MyBagListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBagListNode.h"
#import "MMLabel.h"

@interface MyBagListCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) MMLabel     *formLab;//来自
@property (nonatomic, strong) UILabel       *timeLab;//时间&人次
@property (nonatomic, strong) UILabel       *conLab;//商品说明
@property (nonatomic, strong) UILabel       *typeLab;//第二种状态

@property (nonatomic, strong) MyBagListNode      *node;// 数据
@property (nonatomic, assign) BOOL          isMyin;// 是否我参加/我发起

@end


