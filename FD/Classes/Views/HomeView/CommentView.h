//
//  CommentView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentViewDelegate <NSObject>
- (void)cancelComView;//取消
- (void)sureComView;// 确定评论
- (void)upViewPressed;//上移
- (void)downViewPressed;// 下移
@end

@interface CommentView : UIView<UITextViewDelegate>
{
    
    
}
@property (nonatomic, assign) id<CommentViewDelegate>          delegate;//
@property (nonatomic, strong) UITextView    *conTextView;//评论输入界面


- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
