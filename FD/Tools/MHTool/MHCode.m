//
//  MHCode.m
//  comic
//
//  Created by shenzhen on 12-7-3.
//  Copyright (c) 2012年 imohoo. All rights reserved.
//

#import "MHCode.h"

@implementation MHCode

/**   函数名称 :encodeBase64
 **   函数作用 :Base64加密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)encodeBase64:(NSData *)data{
    return [GTMBase64 encodeData:data];
}

/**   函数名称 :encodeBase64
 **   函数作用 :Base64解密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)decodeBase64:(NSData *)data{
    return [GTMBase64 decodeData:data];
}

/**   函数名称 :decodeString
 **   函数作用 :Base64解密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)decodeBase64String:(NSString *)string{
    return [GTMBase64 decodeString:string];
}

/**   函数名称 :encodeDES
 **   函数作用 :des加密
 **   函数参数 :        
 **   函数返回值:
 **/
+ (NSString *)encodeDES:(NSString *)string{
    return [DES encryptString:string];
}

/**   函数名称 :decodeDES
 **   函数作用 :des解密
 **   函数参数 :        
 **   函数返回值:
 **/
+ (NSString *)decodeDES:(NSString *)string{
    return [DES decryptString:string];
}

@end
