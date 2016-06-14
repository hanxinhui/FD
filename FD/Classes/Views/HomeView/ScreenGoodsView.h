//
//  ScreenGoodsView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenScrollView.h"

@protocol ScreenGoodsViewDelegate <NSObject>
- (void)cancelBuyView;//取消
- (void)sureBuyView:(NSString *)firstStr;// 确定
@end

@interface ScreenGoodsView : UIView<ScreenScrollViewDelegate>
{
    
    
}
@property (nonatomic, assign) id<ScreenGoodsViewDelegate>          delegate;//
@property (nonatomic, strong) NSMutableArray    *firstArr;//收 益
@property (nonatomic, strong) NSString          *firstStr;//收 益

- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
