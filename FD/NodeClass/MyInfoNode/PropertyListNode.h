//
//  PropertyListNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PropertyListNode : NSObject


@property (nonatomic, strong) NSString *pid;      //id
@property (nonatomic, strong) NSString *pcode;      //
@property (nonatomic, strong) NSString *pmoney;      //图片
@property (nonatomic, strong) NSString *ptime;      //
@property (nonatomic, strong) NSString *pdesc;      //备注

-(id)initWithDict:(NSDictionary *)dict;

@end
