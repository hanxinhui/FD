//
//  MyFavViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:常见问题

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface SnatchQuestionViewController : BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
   
}
@property (nonatomic, strong) UIWebView *conWebView;//加载界面


@end

