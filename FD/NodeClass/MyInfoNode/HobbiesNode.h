//
//  HobbiesNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HobbiesNode : NSObject


@property (nonatomic, strong) NSString *Hid;      //id
@property (nonatomic, strong) NSString *name;      //
@property (nonatomic, strong) NSString *pid;      //
@property (nonatomic, strong) NSString *sort;      //
@property (nonatomic, strong) NSString *status;      //
@property (nonatomic, strong) NSMutableArray  *childArr;           //

-(id)initWithDict:(NSDictionary *)dict;

@end
