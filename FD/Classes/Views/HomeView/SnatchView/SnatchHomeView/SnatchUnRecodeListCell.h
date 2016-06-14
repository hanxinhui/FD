//
//  SnatchUnRecodeListCell.h
//  FD
//
//  Created by leoxu on 15/12/16.
//  Copyright © 2015年 leoxu. All rights reserved.
//
// 揭晓中

#import <UIKit/UIKit.h>

#import "SnatchRecordListNode.h"
#import "MMLabel.h"

@protocol SnatchUnRecodeListCellDelegate <NSObject>

- (void)lookDetail:(id)sender;// 查看详情

@end


@interface SnatchUnRecodeListCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *goodsImgView;//图片
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *issueLab; //期号
@property (nonatomic, strong) UIProgressView    *progressView;//进度
@property (nonatomic, strong) UILabel       *needLab;//标题
@property (nonatomic, strong) MMLabel       *joinLab; //本期参与
@property (nonatomic, strong) UIButton      *detailBtn; //查看详情

@property (nonatomic, strong) UILabel       *residueLab;//剩余
@property (nonatomic, strong) UILabel       *showLab;//说明




@property (nonatomic, strong) SnatchRecordListNode      *node;// 数据
@property (nonatomic, assign) id <SnatchUnRecodeListCellDelegate>      delegate;//


@end
