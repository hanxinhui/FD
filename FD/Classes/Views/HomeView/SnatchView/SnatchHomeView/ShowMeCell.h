//
//  ShowMeCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowMeNode.h"

// 晒单
@interface ShowMeCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *bgImgView;//背景
@property (nonatomic, strong) UIImageView   *headImgView;//头像
@property (nonatomic, strong) UILabel       *nikeNameLab;//昵称
@property (nonatomic, strong) UILabel       *timeLab;//时间
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *goodsLab;//商品信息
@property (nonatomic, strong) UILabel       *codeLab;//期号
@property (nonatomic, strong) UILabel       *subjectLab;//说明
@property (nonatomic, strong) UIView       *showPhotoView;//显示图片界面

@property (nonatomic, strong) ShowMeNode      *snode;// 数据

@end


