//
//  NSObject+Parser.m
//  cardPreferential
//
//  Created by leo xu on 13-4-10.
//  Copyright (c) 2013年 leo xu. All rights reserved.
//

#import "NSObject+Parser.h"

@implementation NSObject (Parser)

-(id)initWithDict:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]]) return nil;
    self = [self init];
    
    for (NSString *key in [dict allKeys]) {
        [dict objectEnumerator];
    
        @try {
            [self setValue:[dict objectForKey:key] forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"exception Catched Name:%@",[exception name]);
        }
        @finally {
            
        }
    }
    
    return self;
}


//TODO:获取字典信息
-(NSString *)stringFromDict:(NSDictionary *)dict forKey:(NSString *)key
{
    NSString *ret = [dict objectForKey:key];
    if ([ret isKindOfClass:[NSNumber class]]) {
        ret = [NSString stringWithFormat:@"%f",[(NSNumber *)ret floatValue]];
    }
    if (ret && [ret isKindOfClass:[NSString class]] && ![ret isEqualToString:@"null"]) return ret;
    else return @"";
}

@end
