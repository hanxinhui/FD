//
//  ScreenBuyView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenScrollView.h"

@protocol ScreenBuyViewDelegate <NSObject>
- (void)cancelBuyView;//取消
- (void)sureBuyView:(NSString *)profit cycle:(NSString *)cycle isPayYE:(BOOL )ispay;// 确定

//TODO:是否可以使用余额
- (void)isCanpayYue;
@end

@interface ScreenBuyView : UIView<ScreenScrollViewDelegate>
{
        NSInteger  selectFirstTag;// 获得选择的tag
    NSInteger  selectSecondTag;// 获得选择的tag
    
}
@property (nonatomic, assign) id<ScreenBuyViewDelegate>          delegate;//
@property (nonatomic, strong) NSMutableArray  *earningsArr;//任务类型
@property (nonatomic, strong) NSMutableArray  *deadlineArr;//任务期限
@property (nonatomic, strong) NSString      *earningsStr;//任务类型
@property (nonatomic, strong) NSString      *deadlineStr;//任务期限
@property (nonatomic, strong) UISwitch      *delSwitch;// 选择是否只看
@property (nonatomic, assign) BOOL isOpen;// 是否为只看余额


- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
