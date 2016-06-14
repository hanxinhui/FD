//
//  InstructionsView.h
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InstructionsViewDelegate <NSObject>

- (void)cancelInsView;//关闭

@end

@interface InstructionsView : UIView<UITextViewDelegate>
{
    
}

@property (nonatomic, assign) id<InstructionsViewDelegate>          delegate;//
@property (nonatomic, strong) UITextView *insTextView;// 说明
@property (nonatomic, assign) NSInteger     insInt;// 说明 0 随时赚 1 随心兑


- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
