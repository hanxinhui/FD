//
//  ScreenBtnScrollView.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "ScreenBtnScrollView.h"
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


@implementation ScreenBtnScrollView

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
        
        userSelectedChannelID = 100;
        scrollViewSelectedChannelID = 100;
        
        self.buttonOriginXArray = [NSMutableArray array];
        self.buttonOriginYArray = [NSMutableArray array];
        self.buttonWithArray = [NSMutableArray array];
    }
    return self;
}

- (void)initWithNameButtons
{
    float xPos = 20.0;
    float yPos = 9.0;
    NSInteger  line = 1;
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        HobbiesChildNode *node = [self.nameArray objectAtIndex:i];
        NSString *title = node.name;
        
        [button setTag:i + _varTag];
        button.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        //        [button setTitleColor:UIColorWithRGB(116, 116, 116, 1) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:UIColorWithRGB(252, 208, 139, 1) forState:UIControlStateSelected];
        //        [button setBackgroundImage:[UIImage imageNamed:@"Hobbies_Kuang.png"] forState:UIControlStateNormal];
        //        [button setBackgroundImage:[UIImage imageNamed:@"Hobbies_Kuang_h.png"] forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:0.0]; //设置矩形四个圆角半径
        [button.layer setBorderWidth:1.0]; //边框宽度
        CGColorRef colorref = UIColorWithRGB(239, 239, 239, 1).CGColor;

        [button.layer setBorderColor:colorref];//边框颜色
        
        
        
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        if (node.selected == 1) {
            button.selected = YES;
            CGColorRef colorref = UIColorWithRGB(252, 208, 139, 1).CGColor;

            [button.layer setBorderColor:colorref];//边框颜色
        }
        int buttonWidth = [title sizeWithFont:button.titleLabel.font
                            constrainedToSize:CGSizeMake(150, 30)
                                lineBreakMode:NSLineBreakByClipping].width;
        
        if (xPos + buttonWidth + buttonWidth > self.frame.size.width){
            xPos = 20.0;
            yPos = yPos + 44;
            line = line + 1;
        }
        
        button.frame = CGRectMake(xPos, yPos, buttonWidth + 10, 30);
        //        button.tag = [node.Hid integerValue];
        [_buttonOriginXArray addObject:@(xPos)];
        [_buttonOriginYArray addObject:@(yPos)];
        
        xPos += buttonWidth+BUTTONGAP;
        
        [_buttonWithArray addObject:@(button.frame.size.width)];
        
        [self addSubview:button];
        
        //        if (i == 0) {
        //            button.selected = YES;
        //        }
    }
    
    self.contentSize = CGSizeMake(xPos, 44 * line);
    
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP, 0, [[_buttonWithArray objectAtIndex:0] floatValue], 44)];
    [shadowImageView setImage:[UIImage imageNamed:@"red_line_and_shadow.png"]];
    [self addSubview:shadowImageView];
    
    //    for(id obj in [self subviews])
    //    {
    //        if([(UIButton *)obj isKindOfClass:[UIButton class]])
    //        {
    ////            NSLog(@"obj is %@",obj);
    //            UIButton *btn = obj;
    //            NSInteger tag = btn.tag;
    ////            if (tag-_varTag == _nowSelectTag){
    ////                [self selectNameButton:obj];
    ////            }
    //        }
    //    }
}

//点击顶部条滚动标签
- (void)selectNameButton:(UIButton *)sender
{
    [self adjustScrollViewContentX:sender];
    
    //    //如果更换按钮
    //    if (sender.tag != userSelectedChannelID) {
    //        //取之前的按钮
    //        UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];
    //        lastButton.selected = NO;
    //        //赋值按钮ID
    //        userSelectedChannelID = sender.tag;
    //    }
    //
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        CGColorRef colorref = UIColorWithRGB(252, 208, 139, 1).CGColor;
        [sender.layer setBorderColor:colorref];//边框颜色
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, [[_buttonWithArray objectAtIndex:BUTTONID - _varTag] floatValue], 44)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                if (_btnDelegate && [_btnDelegate respondsToSelector:@selector(ScreenSelectBtnTag:)]) {
                    UIButton *btn = (UIButton *)sender;
                    NSInteger tag = btn.tag - _varTag;
                    HobbiesChildNode *node = [self.nameArray objectAtIndex:tag];
                    
                    [_btnDelegate ScreenSelectBtnTag:[node.Hid integerValue]];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        sender.selected = NO;
        CGColorRef colorref = UIColorWithRGB(239, 239, 239, 1).CGColor;
        [sender.layer setBorderColor:colorref];//边框颜色
        [UIView animateWithDuration:0.25 animations:^{
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, [[_buttonWithArray objectAtIndex:BUTTONID - _varTag] floatValue], 44)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                if (_btnDelegate && [_btnDelegate respondsToSelector:@selector(ScreenSelectBtnTag:)]) {
                    UIButton *btn = (UIButton *)sender;
                    NSInteger tag = btn.tag - _varTag;
                    HobbiesChildNode *node = [self.nameArray objectAtIndex:tag];
                    [_btnDelegate ScreenSelectBtnTag:[node.Hid integerValue]];                }
            }
        }];
        
    }
}

- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID- _varTag] floatValue];
    float originY = [[_buttonOriginYArray objectAtIndex:BUTTONID- _varTag] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID -  _varTag] floatValue];
    
    if (sender.frame.origin.x - self.contentOffset.x > self.frame.size.width-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, originY)  animated:YES];
        
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
    CGColorRef colorref = UIColorWithRGB(239, 239, 239, 1).CGColor;
    [lastButton.layer setBorderColor:colorref];//边框颜色
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
                CGColorRef colorref = UIColorWithRGB(252, 208, 139, 1).CGColor;
                [button.layer setBorderColor:colorref];//边框颜色
                
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
