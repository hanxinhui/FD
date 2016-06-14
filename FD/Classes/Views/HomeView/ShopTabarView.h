//
//  BuyTabarView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopTabarViewDelegate <NSObject>

//TODO:综合排序
- (void)allAction;
//TODO:最新上线
- (void)newlAction;
//TODO:奖励最多
- (void)awardAction;
//TODO:时间最长
- (void)timeAction;
@end

@interface ShopTabarView : UIView
{

  
}
@property (nonatomic, assign) id<ShopTabarViewDelegate>          delegate;//
@property (nonatomic, strong) UIButton  *allBtn;
@property (nonatomic, strong) UIButton  *newlBtn;
@property (nonatomic, strong) UIButton  *awardBtn;
@property (nonatomic, strong) UIButton  *timeBtn;



@end
