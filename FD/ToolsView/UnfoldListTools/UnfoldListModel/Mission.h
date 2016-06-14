//
//  Mission.h
//  FD
//
//  Created by Leo on 15-7-10.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mission : NSObject

@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign, getter = isVip) BOOL vip;

+ (instancetype)missionWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
