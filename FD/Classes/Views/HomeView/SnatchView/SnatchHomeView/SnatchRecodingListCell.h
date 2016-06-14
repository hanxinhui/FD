//
//  SnatchRecodingListCell.h
//  FD
//
//  Created by leoxu on 15/12/17.
//  Copyright © 2015年 leoxu. All rights reserved.
//

// 人未满

#import <UIKit/UIKit.h>
#import "SnatchRecordListNode.h"
#import "MMLabel.h"

@protocol SnatchRecodingListCellDelegate <NSObject>

- (void)addToPay:(id)sender;// 追加
- (void)lookDetail:(id)sender;// 查看详情

@end


@interface SnatchRecodingListCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *goodsImgView;//图片
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *issueLab; //期号
@property (nonatomic, strong) UIProgressView    *progressView;//进度
@property (nonatomic, strong) UILabel       *needLab;//总需
@property (nonatomic, strong) MMLabel       *joinLab; //本期参与
@property (nonatomic, strong) UIButton      *detailBtn; //查看详情

@property (nonatomic, strong) UILabel       *residueLab;//剩余

@property (nonatomic, strong) UIButton       *addToBtn; //追加


@property (nonatomic, strong) SnatchRecordListNode      *node;// 数据

@property (nonatomic, assign) id<SnatchRecodingListCellDelegate>      delegate;// 数据



@end
