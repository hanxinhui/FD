//
//  UIAlertView+Quick.m
//  FD
//
//  Created by Leo Xu on 15/4/18.
//  Copyright (c) 2015年 FD. All rights reserved.
//

#import "UIAlertView+Quick.h"

@implementation UIAlertView (Quick)

+ (void)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    [alertView show];
}

@end
