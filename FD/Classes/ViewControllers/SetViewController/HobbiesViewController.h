//
//  HobbiesViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:兴趣爱好

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HobbiesBtnScrollView.h"


@interface HobbiesViewController : BaseViewController<UIScrollViewDelegate,HobbiesBtnScrollViewDelegate>
{
    float setHeight;//设置高度
   
}


@property (nonatomic, strong) UIScrollView      *mainScrollView;// 主界面滑动
@property (nonatomic, strong) NSMutableArray    *hDataArr;// 数据
@property (nonatomic, strong) NSMutableArray    *selectArr;// 选中数据



@end

