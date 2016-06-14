//
//  ExchangeDetailNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ExchangeDetailNode : NSObject


@property (nonatomic, strong) NSString *Eid;      //id
@property (nonatomic, strong) NSString *addr_id;      //
@property (nonatomic, strong) NSString *address;      //
@property (nonatomic, strong) NSString *attr;      //
@property (nonatomic, strong) NSString *b_c;      //
@property (nonatomic, strong) NSString *code;      //
@property (nonatomic, strong) NSString *comment;      //
@property (nonatomic, strong) NSString *consignee;      //
@property (nonatomic, strong) NSString *createtime;      //
@property (nonatomic, strong) NSString *desc;      //
@property (nonatomic, strong) NSString *express_code;      //
@property (nonatomic, strong) NSString *express_time;      //
@property (nonatomic, strong) NSString *express_type;      //
@property (nonatomic, strong) NSString *gid;      //
@property (nonatomic, strong) NSString *mobile;      //
@property (nonatomic, strong) NSString *name;      //
@property (nonatomic, strong) NSString *price;      //
@property (nonatomic, strong) NSString *signtime;      //
@property (nonatomic, strong) NSString *sku;      //
@property (nonatomic, strong) NSString *status;      //
@property (nonatomic, strong) NSString *status_msg;      //
@property (nonatomic, strong) NSString *thumb;      //
@property (nonatomic, strong) NSString *uid;      //
@property (nonatomic, strong) NSString *remarks;      //兑换账户

-(id)initWithDict:(NSDictionary *)dict;

@end
