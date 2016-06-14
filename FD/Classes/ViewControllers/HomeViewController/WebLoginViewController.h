//
//  DetailsViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:网页扫描 登陆和复制链接

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum {
    ShowLoginWeb,// 网页登陆界面
    ShowOtherWeb // 其他界面
} ShowWebStyle;

@interface WebLoginViewController : BaseViewController<UITextViewDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) NSString      *urlStr;// 传入网址
@property (nonatomic, strong) UITextView    *webTextView;// 扫描后地址
@property (nonatomic, strong) UIButton      *loginBtn;// 登陆
@property (nonatomic, strong) UIImageView      *comImgView;// 登陆图标
@property (nonatomic, strong) UILabel       *comLab;// 登陆说明
@property (nonatomic, strong) UIButton    *cancelBtn;//取消登陆
@property (nonatomic) ShowWebStyle  showWebStyle;//


// 出入类型
- (void)initWithStyle:(ShowWebStyle)style;

@end

