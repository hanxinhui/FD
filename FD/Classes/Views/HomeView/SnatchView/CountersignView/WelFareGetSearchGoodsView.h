//
//  WelFareGetSearchGoodsView.h
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnatchHomeListNode.h"


@protocol WelFareGetSearchGoodsViewDelegate <NSObject>

- (void)chooseGoods:(NSInteger )tag;// 选择产品


@end

@interface WelFareGetSearchGoodsView : UIView

@property (nonatomic, strong) UIImageView   *goodsImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *moneyLab;//钱数
@property (nonatomic, strong) UIButton      *chooseBtn; //选择商品

@property (nonatomic, strong) SnatchHomeListNode      *node;// 数据

@property (nonatomic, assign) id<WelFareGetSearchGoodsViewDelegate>

delegate;//
@end
