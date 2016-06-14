//
//  KLGetCodeNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 领取口令list
#import <Foundation/Foundation.h>


@interface KLGetCodeNode : NSObject


@property (nonatomic, strong) NSString *Cid;      //id
@property (nonatomic, strong) NSString *Cname;      //名称
@property (nonatomic, strong) NSString *thumb;      //名称

-(id)initWithDict:(NSDictionary *)dict;

@end
