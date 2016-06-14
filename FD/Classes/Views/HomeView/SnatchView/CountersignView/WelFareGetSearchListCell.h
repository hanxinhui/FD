//
//  WelFareGetSearchListCell.h
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelFareGetSearchGoodsView.h"


@protocol WelFareGetSearchListCellDelegate <NSObject>

- (void)chooseGoodsPreesd:(NSInteger )tag;// 选择产品

@end

@interface WelFareGetSearchListCell : UITableViewCell<WelFareGetSearchGoodsViewDelegate>

@property (nonatomic, strong) WelFareGetSearchGoodsView *firstGoodsView;// 第一个界面

@property (nonatomic, strong) WelFareGetSearchGoodsView *secondGoodsView;// 第二个界面
@property (nonatomic, assign) NSInteger theSection;// 传入section

@property (nonatomic, assign) id<WelFareGetSearchListCellDelegate>          delegate;//



@end
