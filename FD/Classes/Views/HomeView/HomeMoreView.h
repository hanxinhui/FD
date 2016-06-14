//
//  HomeMoreView.h
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMoreViewDelegate <NSObject>

//点击事件
- (void)goToMorePressed:(id)sender;

@end

@interface HomeMoreView : UIView<UIScrollViewDelegate>
{

  
}
@property (nonatomic, assign) id<HomeMoreViewDelegate>          delegate;//


@end
