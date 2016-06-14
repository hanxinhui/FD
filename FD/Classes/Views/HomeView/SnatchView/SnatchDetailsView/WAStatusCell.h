//
//  WAStatusCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 中奖确认-奖品状态

#import <UIKit/UIKit.h>
#import "WinningAffirmNode.h"

@protocol WAStatusCellDelegate <NSObject>

//TODO:获得cell位置
- (void)doAnyPressed:(id)sender;

@end

@interface WAStatusCell : UIView
{
    NSInteger    winStatus;//状态值
}


@property (nonatomic, strong) UILabel       *timeLab;//获得奖品时间
@property (nonatomic, strong) UILabel       *addressTimeLab;// 确认地址时间
@property (nonatomic, strong) UILabel       *expressTimeLab;// 奖品派发时间
@property (nonatomic, strong) UILabel       *finishTimeLab;// 确认收货时间


@property (nonatomic, strong) WinningAffirmNode      *node;// 数据
@property (nonatomic, assign) id<WAStatusCellDelegate>      delegate;// 

@end


