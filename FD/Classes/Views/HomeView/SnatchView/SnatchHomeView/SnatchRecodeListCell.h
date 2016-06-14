//
//  SnatchRecodeListCell.h
//  FD
//
//  Created by leoxu on 15/12/16.
//  Copyright © 2015年 leoxu. All rights reserved.
//

// 已揭晓

#import <UIKit/UIKit.h>

#import "SnatchRecordListNode.h"
#import "MMLabel.h"

@protocol SnatchRecodeListCellDelegate <NSObject>

- (void)lookDetail:(id)sender;// 查看详情

@end


@interface SnatchRecodeListCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *goodsImgView;//图片
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *issueLab; //期号
@property (nonatomic, strong) UILabel       *needLab; //总需
@property (nonatomic, strong) MMLabel       *joinLab; //本期参与
@property (nonatomic, strong) UIButton      *detailBtn; //查看详情

@property (nonatomic, strong) UILabel       *awardLab; //获奖者
@property (nonatomic, strong) MMLabel       *allJoinLab; //本期参与
@property (nonatomic, strong) UILabel       *luckyLab; //幸运号码
@property (nonatomic, strong) UILabel       *dataLab; //揭晓时间


@property (nonatomic, strong) SnatchRecordListNode      *node;// 数据
@property (nonatomic, assign) id <SnatchRecodeListCellDelegate>      delegate;//




@end
