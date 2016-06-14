//
//  HomeMoreView.m
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "HomeMoreView.h"

#define MENUHEIHT 40

@implementation HomeMoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self commHeadInit];
    }
    return self;
}

//TODO:初始化数组
-(void)commHeadInit{
    // 背景
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgImgView];
    [bgImgView setImage:[UIImage imageNamed:@"Home_list_s_bg.png"]];
    
    UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, 1)];
    ImgView.backgroundColor = [UIColor whiteColor];
    ImgView.alpha = 0.5;
    [bgImgView addSubview:ImgView];
   

    // 列表
    for (int i = 0; i < 3; i++) {
        NSString *iconStr = [NSString stringWithFormat:@"Home_list_s_%d.png",i+1];

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 45*i + 15, self.frame.size.width, 45)];
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(goToMore:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setBackgroundImage:[UIImage imageNamed:@"narrowend.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:iconStr] forState:UIControlStateNormal];
        btn.tag = 100000 + i;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0,-10.0, 0.0, 0.0)];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        
        switch (i) {
            case 0:
                [btn setTitle:@"最新消息" forState:UIControlStateNormal];
                break;
            case 1:
                [btn setTitle:@"我的任务" forState:UIControlStateNormal];
                
                break;
            case 2:
                [btn setTitle:@"我的关注" forState:UIControlStateNormal];
                
                break;
//            case 3:
//                [btn setTitle:@"签到说明" forState:UIControlStateNormal];
//                
//                break;
         
            default:
                break;
        }

        
      
    }


}


//TODO:点击事件
- (void)goToMore:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(goToMorePressed:)]) {
        [_delegate goToMorePressed:sender];
    }
}

@end
