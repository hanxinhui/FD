//
//  BuyDetailViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:更多详情

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface MoreViewController : BaseViewController<UIWebViewDelegate>
{
    float setHeight;//设置高度
 
}


@property (nonatomic, strong) UIWebView *conWebView;//加载界面
@property (nonatomic, strong) NSString  *webUrl;//地址
@property (nonatomic, strong) NSString  *webName;//名称
@property (nonatomic, strong) NSString  *goodName;//评论名称
@property (nonatomic, strong) NSString  *typeS;//评论类型
@property (nonatomic, strong) NSString  *gID;//评论商品id
@property (nonatomic, strong) NSString  *cID;//评论id


@end

