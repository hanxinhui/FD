//
//  ScreenBuyBgView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ScreenBuyBgView.h"
#import "FontDefine.h"



@implementation ScreenBuyBgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        
        self.backgroundColor = [UIColor clearColor];
        [self commHeadInit];
        
    }
    return self;
}


//TODO:初始化数组
-(void)commHeadInit{

    
    UIButton *hiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    hiddenBtn.backgroundColor = [UIColor  blackColor];
    hiddenBtn.alpha = 0.5;
//    [hiddenBtn addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hiddenBtn];
    
    
}


- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}
@end
