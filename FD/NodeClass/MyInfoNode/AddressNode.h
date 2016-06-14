//
//  AddressNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressNode : NSObject

@property (nonatomic, strong) NSString *AID;   //地址id
@property (nonatomic, strong) NSString *consignee;   // 姓名
@property (nonatomic, strong) NSString *mobile;     //电话
@property (nonatomic, strong) NSString *province;     //省id
@property (nonatomic, strong) NSString *city;   //市id
@property (nonatomic, strong) NSString *area;   //区id
@property (nonatomic, strong) NSString *addr;      //地址名称
@property (nonatomic, strong) NSString *def;   //是否默认

@property (nonatomic, strong) NSString *region;   //


-(id)initWithDict:(NSDictionary *)dict;

@end
