//
//  MLNavigationController.h
//  MultiLayerNavigation
//
//  Created by Feather Chan on 13-4-12.
//  Copyright (c) 2013年 Feather Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLNavigationController : UINavigationController <UIGestureRecognizerDelegate>
{
    BOOL stateBarLight;
    BOOL stateBarHidden;
    UIPanGestureRecognizer *_pan;
}


// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;


- (void)setStateBarLight;
- (void)setStateBarDark;
-(void)setstateBarHidden:(BOOL)hidden;
@end
