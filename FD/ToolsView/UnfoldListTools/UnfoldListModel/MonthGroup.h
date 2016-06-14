//
//  MonthGroup.h
//  FD
//
//  Created by Leo on 15-7-10.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthGroup : NSObject

@property (nonatomic, strong) NSArray *missions;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *allMission;
@property (nonatomic, copy) NSString *haveMission;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

+ (instancetype)MonthGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
