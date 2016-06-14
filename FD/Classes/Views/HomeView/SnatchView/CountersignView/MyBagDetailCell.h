//
//  MyBagDetailCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBagDetailListNode.h"
#import "MMLabel.h"

typedef enum {
    WelfareCell,// 福利抢宝
    GroupCell // 群抢宝
    
} CellStyle;

@protocol MyBagDetailCellDelegate <NSObject>

//// 进行购买
//- (void)joinPayPressed;
// 显示详情
- (void)showDetailPressed:(id)sender;


@end

@interface MyBagDetailCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UIImageView   *luckImgView;//图标

@property (nonatomic, strong) UILabel       *luckLab;//抢宝人

@property (nonatomic, strong) UILabel       *timeLab;//时间
@property (nonatomic, strong) UILabel       *codeLab;//抢宝号码
@property (nonatomic, strong) MMLabel       *addnumLab;//参与次数
@property (nonatomic, strong) UIButton      *detailBtn;// 查看详情
@property (nonatomic, strong) UIButton      *addnowBtn;// 立即参加按钮
@property (nonatomic, strong) UIButton      *addmoreBtn;// 继续参加按钮

@property (nonatomic, strong) MyBagDetailListNode      *node;// 数据
@property (nonatomic) CellStyle      cellStyle;// 显示类型
@property (nonatomic, assign) BOOL      isJoinGroup;// 已经加入群抢宝
@property (nonatomic, assign) id<MyBagDetailCellDelegate>      delegate;//
@property (nonatomic, assign) NSInteger      detailTag;//传入tag

@end


