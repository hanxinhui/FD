//
//  SkuBtnScrollView.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "SkuBtnScrollView.h"
#import "FontDefine.h"
#import "SkuNode.h"

//按钮空隙
#define BUTTONGAP 40
//滑条宽度
#define CONTENTSIZEX 320
//按钮id
#define BUTTONID sender.tag
//滑动id
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 100)


@implementation SkuBtnScrollView

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
        self.buttonWithArray = [NSMutableArray array];
    }
    return self;
}

- (void)initWithNameButtons
{
    float xPos = 20.0;
    float yPos = 7.0;
    NSInteger  line = 1;
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        SkuNode *node = [self.nameArray objectAtIndex:i];
        NSString *title = node.attr;
        [button setTag:i + _varTag];
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        //        [button setTitleColor:UIColorWithRGB(116, 116, 116, 1) forState:UIControlStateNormal];
        [button setTitleColor:UIColorWithRGB(125, 125, 125, 1) forState:UIControlStateNormal];
        [button setTitleColor:UIColorWithRGB(252, 62, 0, 1) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = [title sizeWithFont:button.titleLabel.font
                            constrainedToSize:CGSizeMake(150, 30)
                                lineBreakMode:NSLineBreakByClipping].width;
        
        //        if (xPos + buttonWidth + buttonWidth > self.frame.size.width){
        //            xPos = 20.0;
        //            yPos = yPos + 44;
        //            line = line + 1;
        //        }
        
        button.frame = CGRectMake(xPos, yPos, buttonWidth+BUTTONGAP, 30);
        
        [_buttonOriginXArray addObject:@(xPos)];
        
        xPos += buttonWidth+BUTTONGAP;
        
        [_buttonWithArray addObject:@(button.frame.size.width)];
        
        [self addSubview:button];
        
        //        if (i == 0) {
        //            button.selected = YES;
        //        }
    }
    
    self.contentSize = CGSizeMake(xPos, 44 * line);
    
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP + 20, 43, [[_buttonWithArray objectAtIndex:0] floatValue] - 40, 3)];
    [shadowImageView setImage:[UIImage imageNamed:@"MyTask_Select_Red.png"]];
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
    
    //如果更换按钮
    if (sender.tag != userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x + 20, 43, [[_buttonWithArray objectAtIndex:BUTTONID - _varTag] floatValue] - 40, 1)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                if (_btnDelegate && [_btnDelegate respondsToSelector:@selector(selectBtnTag:)]) {
                    [_btnDelegate selectBtnTag:sender];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID- _varTag] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID -  _varTag] floatValue];
    
    if (sender.frame.origin.x - self.contentOffset.x > self.frame.size.width-(BUTTONGAP+width) && _buttonWithArray.count > 3) {
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (sender.frame.origin.x - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}

//滚动内容页顶部滚动
- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIButton *lastButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    lastButton.selected = NO;
}

- (void)setButtonSelect
{
    //滑动选中按钮
    UIButton *button = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [shadowImageView setFrame:CGRectMake(button.frame.origin.x + 20, 43, [[_buttonWithArray objectAtIndex:button.tag - _varTag] floatValue] - 40 , 1)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!button.selected) {
                button.selected = YES;
                userSelectedChannelID = button.tag;
            }
        }
    }];
    
}

-(void)setScrollViewContentOffset
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    
    if (originX - self.contentOffset.x > self.frame.size.width-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (originX - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}





@end
