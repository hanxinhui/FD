//
//  CustomTextField.h
//  lightsOut
//
//  Created by Leoxu on 13-7-13.
//  Copyright (c) 2013年 Leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property (nonatomic, retain)UIFont *placeHoldFont;
@property (nonatomic, retain)UIColor *placeHoldColor;
@property (nonatomic, assign) float verticalPadding;
@property (nonatomic, assign) float horizontalPadding;
@end
