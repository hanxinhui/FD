//
//  ScreenScrollView.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScreenScrollViewDelegate <NSObject>

- (void)ScreenSelectBtnTag:(NSInteger)tag;//当前选择

@end

@interface ScreenScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *nameArray;
    NSInteger userSelectedChannelID;        //点击按钮选择名字ID
    NSInteger scrollViewSelectedChannelID;  //滑动列表选择名字ID
    
    UIImageView *shadowImageView;   //选中阴影
}
@property (nonatomic, retain) NSArray *nameArray;

@property(nonatomic,retain)NSMutableArray *buttonOriginXArray;
@property(nonatomic,retain)NSMutableArray *buttonOriginYArray;
@property(nonatomic,retain)NSMutableArray *buttonWithArray;

@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;

@property (nonatomic, assign) NSInteger     nowSelectTag;// 当前选择
@property (nonatomic, assign) NSInteger     varTag;// 变量tag
@property (nonatomic, assign) id<ScreenScrollViewDelegate>          btnDelegate;//
@property (nonatomic, assign) BOOL          isEarn;//是否是随时赚 否为随心兑


/**
 *  加载顶部标签
 */
- (void)initWithNameButtons;
/**
 *  滑动撤销选中按钮
 */
- (void)setButtonUnSelect;
/**
 *  滑动选择按钮
 */
- (void)setButtonSelect;
/**
 *  滑动顶部标签位置适应
 */
-(void)setScrollViewContentOffset;

//点击顶部条滚动标签
- (void)selectNameButton:(UIButton *)sender;

@end

