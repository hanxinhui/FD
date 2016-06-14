//
//  ScreenScrollView.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "ScreenScrollView.h"
#import "HobbiesChildNode.h"
#import "FontDefine.h"

//按钮空隙
#define BUTTONGAP 20
//滑条宽度
#define CONTENTSIZEX 320
//按钮id
#define BUTTONID sender.tag
//滑动id
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 100)


@implementation ScreenScrollView

@synthesize nameArray;
@synthesize scrollViewSelectedChannelID;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        userSelectedChannelID = 0;
        scrollViewSelectedChannelID = 100;
        
        self.buttonOriginXArray = [NSMutableArray array];
        self.buttonOriginYArray = [NSMutableArray array];
        self.buttonWithArray = [NSMutableArray array];
    }
    return self;
}

- (void)initWithNameButtons
{
    float xPos = 10.0;
    float yPos = 9.0;
     NSInteger  line = 1;
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.nameArray objectAtIndex:i];
        
        [button setTag:i + _varTag];
        button.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
              [button setTitleColor:UIColorWithRGB(94, 95, 95, 1) forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:UIColorWithRGB(258, 95, 80, 1) forState:UIControlStateSelected];
//        [button setTitleColor:UIColorWithRGB(255, 103, 103, 1) forState:UIControlStateSelected];

        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//      [button.layer setMasksToBounds:YES];
//       [button.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
//       [button.layer setBorderWidth:1.0]; //边框宽度
//        CGColorRef colorref = UIColorWithRGB(258, 95, 80, 1).CGColor;
//        CGColorRef colorref = [UIColor grayColor].CGColor;
        [button setBackgroundImage:[UIImage imageNamed:@"screen_num_g.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"screen_num_r.png"] forState:UIControlStateSelected];

//        [button.layer setBorderColor:colorref];//边框颜色
        
  
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
//        if (node.selected == 1) {
//            button.selected = YES;
//            CGColorRef colorref = UIColorWithRGB(252, 208, 139, 1).CGColor;
//
//            [button.layer setBorderColor:colorref];//边框颜色
//        }
        int buttonWidth;
        if (_isEarn){
            // 随时赚
            buttonWidth = ((iPhoneWidth / 5 *4+20)-40) / 3 -10;
            if (xPos + buttonWidth  > self.frame.size.width){
                xPos = 10.0;
                yPos = yPos + 40;
                line = line + 1;
            }
            
            button.frame = CGRectMake(xPos, yPos, buttonWidth+10, 35);

        }else{
            buttonWidth  = [title sizeWithFont:button.titleLabel.font
                             constrainedToSize:CGSizeMake(150, 30)
                                 lineBreakMode:NSLineBreakByClipping].width;
            if (xPos + buttonWidth + buttonWidth > self.frame.size.width){
                xPos = 20.0;
                yPos = yPos + 44;
                line = line + 1;
            }
            
            button.frame = CGRectMake(xPos, yPos, buttonWidth+10, 30);

        }
        
        //        button.tag = [node.Hid integerValue];
        [_buttonOriginXArray addObject:@(xPos)];
        [_buttonOriginYArray addObject:@(yPos)];
        
        xPos += buttonWidth+BUTTONGAP;
        
        [_buttonWithArray addObject:@(button.frame.size.width)];
        
        [self addSubview:button];
        
    
    }
    
    self.contentSize = CGSizeMake(xPos, 44 * line);
    
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP, 0, [[_buttonWithArray objectAtIndex:0] floatValue], 44)];
    [shadowImageView setImage:[UIImage imageNamed:@"red_line_and_shadow.png"]];
    [self addSubview:shadowImageView];
    
        for(id obj in [self subviews])
        {
            if([(UIButton *)obj isKindOfClass:[UIButton class]])
            {
    //            NSLog(@"obj is %@",obj);
                UIButton *btn = obj;
                NSInteger tag = btn.tag;
                if (tag-_varTag == _nowSelectTag){
                    [self selectNameButton:obj];
                }
            }
        }
}

//点击顶部条滚动标签
- (void)selectNameButton:(UIButton *)sender
{
    [self adjustScrollViewContentX:sender];
    
//        //如果更换按钮
//        if (sender.tag != userSelectedChannelID) {
//            //取之前的按钮
//            UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];
//            lastButton.selected = NO;
//            //赋值按钮ID
//            userSelectedChannelID = sender.tag;
//        }
    
    //按钮选中状态
    if (!sender.selected) {

        for (UIButton *subView in self.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                if (![subView isEqual:sender]) {
//                    CGColorRef colorref = [UIColor grayColor].CGColor;
//                    [subView.layer setBorderColor:colorref];//边框颜色
                    subView.selected = NO;
                }else{
//                    CGColorRef colorref = UIColorWithRGB(252, 208, 139, 1).CGColor;
//                    [subView.layer setBorderColor:colorref];//边框颜色
                    subView.selected = YES;

 
                }

            }
        }
        sender.selected = YES;
//        CGColorRef colorref = UIColorWithRGB(239, 239, 239, 1).CGColor;
//        [sender.layer setBorderColor:colorref];//边框颜色
//        [sender setTitleColor:UIColorWithRGB(255, 103, 103, 1) forState:UIControlStateSelected];
        [UIView animateWithDuration:0.25 animations:^{
            
           [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, [[_buttonWithArray objectAtIndex:BUTTONID - _varTag] floatValue], 44)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                if (_btnDelegate && [_btnDelegate respondsToSelector:@selector(ScreenSelectBtnTag:)]) {
                    UIButton *btn = (UIButton *)sender;
                    NSInteger tag = btn.tag;
                    
                    [_btnDelegate ScreenSelectBtnTag:tag];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
//        sender.selected = NO;
//        CGColorRef colorref = UIColorWithRGB(239, 239, 239, 1).CGColor;
//        [sender.layer setBorderColor:colorref];//边框颜色
//        [UIView animateWithDuration:0.25 animations:^{
//            
//            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, [[_buttonWithArray objectAtIndex:BUTTONID - _varTag] floatValue], 44)];
//            
//        } completion:^(BOOL finished) {
//            if (finished) {
//                if (_btnDelegate && [_btnDelegate respondsToSelector:@selector(ScreenSelectBtnTag:)]) {
//                    UIButton *btn = (UIButton *)sender;
//                    NSInteger tag = btn.tag ;
//                    [_btnDelegate ScreenSelectBtnTag:tag];
//                }
//            }
//        }];
        
    }
}

- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID- _varTag] floatValue];
    float originY = [[_buttonOriginYArray objectAtIndex:BUTTONID- _varTag] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID -  _varTag] floatValue];
    
    if (sender.frame.origin.x - self.contentOffset.x > self.frame.size.width-(BUTTONGAP+width)) {
        
        if (!_isEarn){
        [self setContentOffset:CGPointMake(originX - 30, originY)  animated:YES];
        }

        
    }
    
    if (sender.frame.origin.x - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,originY)  animated:YES];
    }
}

//滚动内容页顶部滚动
- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIButton *lastButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    lastButton.selected = NO;
//    CGColorRef colorref = UIColorWithRGB(239, 239, 239, 1).CGColor;
//    [lastButton.layer setBorderColor:colorref];//边框颜色
}

- (void)setButtonSelect
{
    //滑动选中按钮
    UIButton *button = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [shadowImageView setFrame:CGRectMake(button.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:button.tag - _varTag] floatValue], 44)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!button.selected) {
                button.selected = YES;
//                CGColorRef colorref = UIColorWithRGB(252, 208, 139, 1).CGColor;
//                [button.layer setBorderColor:colorref];//边框颜色
//                
                userSelectedChannelID = button.tag;
            }
        }
    }];
    
}

-(void)setScrollViewContentOffset
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    float originY = [[_buttonOriginYArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    
    if (originX - self.contentOffset.x > self.frame.size.width-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, originY)  animated:YES];
    }
    
    if (originX - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,originY)  animated:YES];
    }
}





@end
