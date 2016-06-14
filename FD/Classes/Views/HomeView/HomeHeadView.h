//
//  HomeHeadView.h
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeadViewDelegate <NSObject>

- (void)taskListPressed;// 任务列表
- (void)goodsListPressed;// 商品列表
- (void)layPressed;// 抽奖
- (void)registerPressed;//签到
- (void)toSetPressed;//进入设置界面
@end

@interface HomeHeadView : UIView<UIScrollViewDelegate>
{

  
}
@property (nonatomic, assign) id<HomeHeadViewDelegate>          delegate;//
@property (nonatomic, strong) UIButton  *taskbtn;//进入任务列表按钮
@property (nonatomic, strong) UIButton  *goodsbtn;//进入商品列表按钮
@property (nonatomic, strong) UIButton  *laybtn;//抽奖按钮
@property (nonatomic, strong) UIButton  *registerbtn;//签到按钮
@property (nonatomic, strong) UIImageView  *headImgView;//用户头像
@property (nonatomic, strong) UIButton  *loginBtn;//登录按钮
@property (nonatomic, strong) UILabel   *userNameLab;//用户名
@property (nonatomic, strong) UILabel   *conLab;//说明
@property (nonatomic, strong) UILabel   *conpLab;//说明
@property (nonatomic, strong) UIImageView    *loadImgView;//加载图片


@end
