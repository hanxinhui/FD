//
//  MissionHeadView.h
//  FD
//
//  Created by Leo on 15-7-10.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PropertyNode;

@protocol MissionHeadViewDelegate <NSObject>

@optional
- (void)clickHeadView:(NSInteger )row;

@end

@interface MissionHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) PropertyNode *propertyNode;

@property (nonatomic, weak) id<MissionHeadViewDelegate> delegate;

+(instancetype)headViewWithTableView:(UITableView *)tableView getRow:(NSInteger)row;

@end
