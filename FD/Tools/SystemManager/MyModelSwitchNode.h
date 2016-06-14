//
//  MyModelSwitchNode.h
//  JSNews
//
//  Created by Leo xu on 14-10-16.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModelNode.h"


@interface MyModelSwitchNode : NSObject

@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSMutableArray *child;

@end
