//
//  WinningRecordNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WinningRecordNode : NSObject


@property (nonatomic, strong) NSString *Cid;      //id
@property (nonatomic, strong) NSString *Cname;      //名称

-(id)initWithDict:(NSDictionary *)dict;

@end
