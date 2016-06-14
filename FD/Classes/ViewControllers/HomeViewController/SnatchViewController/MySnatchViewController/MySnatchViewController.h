//
//  MySnatchViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:我的抢宝

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface MySnatchViewController : BaseViewController<UIScrollViewDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic , strong) UIScrollView     *mainScrollView;//主页面

@end

