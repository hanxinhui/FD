//
//  FindViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:发现

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface FindViewController : BaseViewController<UIScrollViewDelegate>
{
    float setHeight;//设置高度
   
}

@property  (nonatomic, strong) UIImageView  *perfectIImgView;// 完善资料图片
@property  (nonatomic, strong) UIImageView  *inviteFImgView;// 邀请好友图片
@property (nonatomic , strong) UIScrollView     *mainScrollView;//

//TODO: 获取网络数据
- (void)getHttpData;
//TODO: 登录
- (void)getLoginPressed;
@end

