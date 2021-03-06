//
//  ShopCartNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShopCartNode : NSObject


@property (nonatomic, strong) NSString *Sid;      //id
@property (nonatomic, strong) NSString *check;      //图片
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *codes_list;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *gid;
@property (nonatomic, strong) NSString *luck_code;
@property (nonatomic, strong) NSString *luck_time;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *progress;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *step;
@property (nonatomic, strong) NSString *sub_title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *update_time;





-(id)initWithDict:(NSDictionary *)dict;

@end
