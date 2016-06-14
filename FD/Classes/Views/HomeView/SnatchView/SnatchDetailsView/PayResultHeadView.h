//
//  PayResultHeadView.h
//  PayResultHeadView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnatchHomeListNode.h"
#import "MMLabel.h"



@protocol PayResultHeadViewDelegate <NSObject>

//TODO:继续夺宝
- (void)goonSnatchPressed;
//TODO:查看夺宝记录
- (void)toSnatchRecordPressed;

@end
@interface PayResultHeadView : UIView

@property (nonatomic, strong) MMLabel *footLab;// 底部lab
@property (nonatomic, assign) id<PayResultHeadViewDelegate>          delegate;//

@end
