//
//  ShowMeNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

// 晒单数据
#import <Foundation/Foundation.h>


@interface ShowMeNode : NSObject


@property (nonatomic, strong) NSString *avatar;      //
@property (nonatomic, strong) NSString *code;      //
@property (nonatomic, strong) NSString *content;      //
@property (nonatomic, strong) NSString *nickname;      //
@property (nonatomic, strong) NSString *src;      //
@property (nonatomic, strong) NSString *subject;      //
@property (nonatomic, strong) NSString *time;      //
@property (nonatomic, strong) NSString *title;      //


-(id)initWithDict:(NSDictionary *)dict;

@end
