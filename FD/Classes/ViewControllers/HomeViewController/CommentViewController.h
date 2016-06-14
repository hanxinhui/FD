//
//  CommentViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:评论

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface CommentViewController : BaseViewController<UIWebViewDelegate,UITextViewDelegate>
{
    float setHeight;//设置高度
   
    
    
    
}


@property (nonatomic, strong) NSString      *commentID;//评论id
@property (nonatomic, strong) NSString      *goodID;//商品
@property (nonatomic, strong) NSString      *fID;//评论id
@property (nonatomic, strong) NSString      *typeStr;//类型
@property (nonatomic, strong) NSString      *nameStr;//类型
@property (nonatomic, strong) UITextView    *conTextView;//评论输入界面


@end

