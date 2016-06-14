//
//  NSObject+Parser.h
//  cardPreferential
//
//  Created by leo xu on 13-4-10.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parser)

-(id)initWithDict:(NSDictionary *)dict;

-(NSString *)stringFromDict:(NSDictionary *)dict forKey:(NSString *)key;
@end
