//
//  FeedViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:反馈

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface FeedViewController : BaseViewController<UITextViewDelegate>
{
    float setHeight;//设置高度
    
    float enterNum;//输入字数
}

@property (nonatomic, strong) UITextView  *feedtextView;// 输入内容
@property (nonatomic, strong) UILabel     *limitLab;// 限制字数
@property (nonatomic, strong) UILabel     *hintLab;// 提示文字

@end

