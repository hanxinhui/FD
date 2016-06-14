//
//  MonthGroup.m
//  QQ好友列表
//  FD
//
//  Created by Leo on 15-7-10.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "MonthGroup.h"
#import "Mission.h"

@implementation MonthGroup

+ (instancetype)MonthGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _missions) {
            Mission *missions = [Mission missionWithDict:dict];
            [tempArray addObject:missions];
        }
        _missions = tempArray;
    }
    return self;
}

@end
