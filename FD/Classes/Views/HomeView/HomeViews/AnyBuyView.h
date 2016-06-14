//
//  AnyBuyView.h
//  FD
//
//  Created by leoxu on 16/1/11.
//  Copyright © 2016年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuylistNode.h"

@class AnyBuyView;

typedef void (^AnyBuyViewBlock)(AnyBuyView *view,BuylistNode *buylistNode);


@protocol AnyBuyViewDelegate <NSObject>

//TODO:点击综合事件
- (void)selectNowPressed:(NSInteger )nowTag;

@end

@interface AnyBuyView : UIView
{
    
}

@property(nonatomic,strong)NSLayoutConstraint *contentViewHegithCons;

@property (copy, nonatomic)AnyBuyViewBlock block;

@property (assign, nonatomic)NSInteger currentIndex;// 当前选中
@property (nonatomic, assign) id<AnyBuyViewDelegate>          delegate;//


- (void)show;

@end
