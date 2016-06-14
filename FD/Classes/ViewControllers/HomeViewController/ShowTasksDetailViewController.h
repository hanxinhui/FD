//
//  ShowTasksDetailViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:任务

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BuyDetailNode.h"


@interface ShowTasksDetailViewController : BaseViewController<UIWebViewDelegate,UIAlertViewDelegate>
{
    float setHeight;//设置高度
    BOOL isFirst;// 第一次今入
}


@property (nonatomic, strong) UIWebView *conWebView;//加载界面
@property (nonatomic, strong) NSString  *jsonString;//数据
@property (nonatomic, strong) NSString  *nextjsonString;//数据
@property (nonatomic, strong) BuyDetailNode  *detailNode;//
@property (nonatomic, assign) BOOL          isMyTask;//来自我的任务

@end

