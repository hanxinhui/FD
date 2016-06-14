//
//  MyGoodsListNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyGoodsListNode : NSObject


@property (nonatomic, strong) NSString *Gid;      //id
@property (nonatomic, strong) NSString *comment;      //
@property (nonatomic, strong) NSString *createtime;      //
@property (nonatomic, strong) NSString *express_code;      //
@property (nonatomic, strong) NSString *express_type;      //
@property (nonatomic, strong) NSString *Ggid;      //
@property (nonatomic, strong) NSString *name;      //
@property (nonatomic, strong) NSString *price;      //
@property (nonatomic, strong) NSString *signtime;      //
@property (nonatomic, strong) NSString *status;      //
@property (nonatomic, strong) NSString *status_msg;      //
@property (nonatomic, strong) NSString *thumb;      //图片



-(id)initWithDict:(NSDictionary *)dict;

@end
