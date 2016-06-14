//
//  MyTaskLayCellNode.m
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyTaskLayCellNode.h"
#import "NSObject+Parser.h"


@implementation MyTaskLayCellNode

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Bid = [self stringFromDict:dict forKey:@"id"];
        self.Bicon = [self stringFromDict:dict forKey:@"cover"];
        self.Btitle = [self stringFromDict:dict forKey:@"title"];
        self.Bmargin = [self stringFromDict:dict forKey:@"sub_title"];
        self.Bcon = [self stringFromDict:dict forKey:@"con"];
        self.Bstate = [self stringFromDict:dict forKey:@"state"];
     
    }
    return self;
}
@end
