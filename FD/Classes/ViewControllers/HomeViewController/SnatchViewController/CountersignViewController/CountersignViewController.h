//
//  CountersignViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:暗号抽疯

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface CountersignViewController : BaseViewController<UITextFieldDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) UITextField  *countersTextField;// 数据加载tab
@property (nonatomic, strong) UIButton      *goBtn;// 参加按钮


@end

