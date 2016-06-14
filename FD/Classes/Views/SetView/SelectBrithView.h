//
//  SelectBrithView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectBrithViewDelegate <NSObject>
- (void)cancelBrithView;//取消选择生日
- (void)sureBrith:(NSString *)BrithS;// 确定传入生日
@end

@interface SelectBrithView : UIView
{
    
    
}
@property (nonatomic, assign) id<SelectBrithViewDelegate>          delegate;//
@property (nonatomic, strong)  NSString *brithStr;

- (void)showInView:(UIView *)view;

@end
