//
//  SnatchAdView.h
//  SnatchAdView
//
//  Created by Mark on 15/3/30.
//  Copyright (c) 2015年 yq. All rights reserved.
//

//TODO:首页顶部广告View

#import <UIKit/UIKit.h>
#import "SnatchAdsNode.h"

@class SnatchAdView;
@protocol SnatchAdViewDelegate <NSObject>
@optional
- (void)loopViewDidSelectedImage:(SnatchAdView *)snatchAdView index:(int)index;// 选择广告
@end

@interface SnatchAdView : UIView
@property (nonatomic, weak) id<SnatchAdViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoPlay;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSArray *images;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;
@end
