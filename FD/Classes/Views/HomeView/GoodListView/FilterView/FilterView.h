//
//  FilterView.h
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectBtnScrollView.h"

@protocol FilterViewDelegate <NSObject>

@end

@interface FilterView : UIView<UIScrollViewDelegate,SelectBtnScrollViewDelegate>
{

  
}

@property (nonatomic, assign) id<FilterViewDelegate>          delegate;//
@property (nonatomic, strong) NSMutableArray  *listArr;// 数组

@property (nonatomic , strong) UIScrollView *conScorllView;//广告


@end
