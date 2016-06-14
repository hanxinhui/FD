//
//  UserData.m
//  FD
//
//  Created by Leo xu on 10/17/13.
//  Copyright (c) 2013 Leo xu. All rights reserved.
//

#import "UserData.h"
#import <objc/runtime.h>
#import "NSObject+Parser.h"

@implementation UserData


//TODO:读取表单数据，加载时候使用
+(UserData *)userDataWithForm:(NSDictionary *)dict
{
    if (!dict) return nil;
    
    UserData *data = [[UserData alloc] init];
    
    NSArray *keys = [data allKeys];
    for (NSString *key in keys) {
        id object = [dict objectForKey:key];
        if (object) {
            [data setValue:object forKey:key];
        }
    }
    
    return data;

}

//TODO:创建一个仅有id和密码的userdata，游客登录用
+(UserData *)UserDataWithUID:(NSString *)uid Pwd:(NSString *)pwd
{
    UserData *data = [[UserData alloc] init];
    data.UName = uid;
    data.UPassWord = pwd;
    return data;
}

//TODO:读取
-(id)initWithDict:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]])        return nil;
    if (self = [super init]) {
        self.UID = [[self stringFromDict:dict forKey:@"id"] integerValue];
        self.UName = [self stringFromDict:dict forKey:@"username"];
        self.Uemail = [self stringFromDict:dict forKey:@"email"];
        self.UPhone = [self stringFromDict:dict forKey:@"mobile"];
        self.UAvatar = [self stringFromDict:dict forKey:@"avatar"];
        int x = arc4random() % 100;

        if (self.UAvatar == nil || [self.UAvatar isEqualToString:@""] || self.UAvatar.length == 0) {
            
        }else{
            self.UAvatar = [NSString stringWithFormat:@"%@?%d",self.UAvatar,x];
 
        }
        self.Unike = [self stringFromDict:dict forKey:@"nickname"];
        if ([self.Unike isEqualToString:@""] || self.Unike.length == 0  || self.Unike == nil) {
            self.Unike = self.UPhone;
        }
        self.RName = [self stringFromDict:dict forKey:@"realname"];
        self.Ubirthday = [self stringFromDict:dict forKey:@"birthday"];
        self.Uaddr = [self stringFromDict:dict forKey:@"addr"];
        self.Usex = [self stringFromDict:dict forKey:@"sex"];
        if ([self.Usex isEqualToString:@"1"]) {
            self.Usex = @"男";
        }
        if ([self.Usex isEqualToString:@"2"]) {
            self.Usex = @"女";
        }
        if ([self.Usex isEqualToString:@"0"]) {
            self.Usex = @"保密";
        }
        self.Uincome = [self stringFromDict:dict forKey:@"monthly_income"];
        self.Uinterest = [self stringFromDict:dict forKey:@"interest"];
        self.Ustatus = [self stringFromDict:dict forKey:@"status"];
        self.Utotal = [self stringFromDict:dict forKey:@"total"];
        self.UtodayIn = [self stringFromDict:dict forKey:@"todayIn"];
        self.UtotalIn = [self stringFromDict:dict forKey:@"totalIn"];
        self.Utotal_Free = [self stringFromDict:dict forKey:@"freeBalance"];
        self.Utotal_Freeze = [self stringFromDict:dict forKey:@"freezeBalance"];
        self.Utotal_Bail = [self stringFromDict:dict forKey:@"bail"];
        self.Utotal_FreeBail = [self stringFromDict:dict forKey:@"freeBail"];
        self.UweekIn = [self stringFromDict:dict forKey:@"weekIn"];
        self.UmouthIn = [self stringFromDict:dict forKey:@"monthIn"];

        if ([self.Utotal  isEqualToString:@""] || self.Utotal.length == 0 || self.Utotal == nil) {
            self.Utotal = @"0";
        }
        if ([self.UtodayIn  isEqualToString:@""] || self.UtodayIn.length == 0 || self.UtodayIn == nil) {
            self.UtodayIn = @"0";
        }
        if ([self.UtotalIn  isEqualToString:@""] || self.UtotalIn.length == 0 || self.UtotalIn == nil) {
            self.UtotalIn = @"0";
        }
        
        
        self.UaddTime = [self stringFromDict:dict forKey:@"add_time"];
        self.UlastTime = [self stringFromDict:dict forKey:@"last_time"];
        self.Umsg_num = [self stringFromDict:dict forKey:@"msg_num"];
        self.Utype = [self stringFromDict:dict forKey:@"user_type"];
        self.UPassWord = [self stringFromDict:dict forKey:@"password"];
        self.PayPassWord = [self stringFromDict:dict forKey:@"paypassword"];
        self.Uyy_num = [self stringFromDict:dict forKey:@"yy_num"];
        
//        [[NSUserDefaults standardUserDefaults] setObject:self.UIntegral forKey:SAVE_MYINTEGRAL];

    }
    
    return self;
}



//TODO:数据组成表单
- (NSDictionary *)dictFromUserData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *keys = [self allKeys];
    for (NSString *key in keys) {
        id object = [self valueForKey:key];
        if (object)
            [dict setObject:object forKey:key];
    }
    return dict;
}
//TODO:获取表单属性名
-(NSArray *)allKeys
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if (propertyName) [props addObject:propertyName];
    }
    free(properties);
    return props;
}

@end
