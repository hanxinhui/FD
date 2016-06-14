//
//  HomeNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeNode : NSObject


@property (nonatomic, strong) NSString *Hid;      //id
@property (nonatomic, strong) NSString *Htitle;      //
@property (nonatomic, strong) NSString *Hsub_title;      //
@property (nonatomic, strong) NSString *Hcover;      //图片
@property (nonatomic, strong) NSString *Hpath;      //
@property (nonatomic, strong) NSString *Hdesc;      //

-(id)initWithDict:(NSDictionary *)dict;

@end
