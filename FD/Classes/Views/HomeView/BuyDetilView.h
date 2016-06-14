//
//  BuyDetilView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyDetailNode.h"

@protocol BuyDetilViewDelegate <NSObject>
- (void)cancelBuyView;//取消
- (void)sureBuyView;// 确定

@end

@interface BuyDetilView : UIView
{
    
    
}
@property (nonatomic, assign) id<BuyDetilViewDelegate>          delegate;//

@property (nonatomic, strong) BuyDetailNode *dnode;// 数据

- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
