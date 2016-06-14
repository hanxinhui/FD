//
//  GoodsListNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GoodsListNode : NSObject


@property (nonatomic, strong) NSString *Gid;      //id
@property (nonatomic, strong) NSString *Gdesc;      //详情
@property (nonatomic, strong) NSString *Gcid;      //类别id
@property (nonatomic, strong) NSString *Gname;      //标题
@property (nonatomic, strong) NSString *Gprice;      //价格
@property (nonatomic, strong) NSString *Gstock;      //库存
@property (nonatomic, strong) NSString *Gthumb;      //图片



-(id)initWithDict:(NSDictionary *)dict;

@end
