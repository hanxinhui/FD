//
//  BuyDetailViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:兑换详情

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ExchangeDetailNode.h"



@interface ExchangeDetailViewController : BaseViewController
{
    float setHeight;//设置高度

}

@property (nonatomic, strong) NSString  *goodID;//商品id
@property (nonatomic, strong) ExchangeDetailNode  *dNode;//详情
@property (nonatomic, strong) UIButton      *exBtn;//兑换按钮


@end

