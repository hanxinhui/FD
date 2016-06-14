//
//  MyTasksDetailViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:我的任务详情

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyTaskAnyCellNode.h"
#import "BuyDetailNode.h"



@interface MyTasksDetailViewController : BaseViewController<UIAlertViewDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic , strong) UIButton *tasksBtn;// 任务按钮
@property (nonatomic , strong) MyTaskAnyCellNode *node;// 数据
@property (nonatomic, strong) NSString  *jsonString;//数据
@property (nonatomic, strong) BuyDetailNode  *buyDetailNode;//数据
@property (nonatomic, strong) UIButton      *courseBtn;//进程
@property (nonatomic, strong) UILabel   *surplusLab;//剩余天数

@end

