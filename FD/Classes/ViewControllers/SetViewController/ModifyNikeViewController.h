//
//  ModifyNikeViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:修改昵称

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"

typedef enum {
    ModifyNikename,// 修改昵称
    ModifyRealname // 修改真实姓名
} ModifyNameStyle;

@interface ModifyNikeViewController : BaseViewController<UITextFieldDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) UILabel *slab;// 提示语
@property (nonatomic, strong) CustomTextField *nikeTextField;// 昵称输入框

@property (nonatomic) ModifyNameStyle modifyStyle;//


// 出入类型
- (void)initWithStyle:(ModifyNameStyle)style;

@end

