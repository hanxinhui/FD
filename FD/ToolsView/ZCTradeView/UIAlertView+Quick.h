//
//  UIAlertView+Quick.h
//
//
//  Created by Leo Xu on 15/4/18.
//  Copyright (c) 2015年 FD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Quick)

+ (void)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

@end
