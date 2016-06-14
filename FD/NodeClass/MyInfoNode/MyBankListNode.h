//
//  MyBankListNode.h
//  FD
//
//  Created by leoxu on 14-9-11.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyBankListNode : NSObject

/**info =     (
            {
                bank = "\U4ea4\U901a\U94f6\U884c";
                bankcode = COM;
                cardno = 6222600210014351913;
                cardtype = 1;
                code = 201508211646102870;
                id = 1;
                idcard = "<null>";
                "insert_time" = 1440146769;
                mobile = 0;
                status = 1;
                uid = 10031;
                "update_time" = 1440149704;
                username = "\U675c\U9053\U5e73";
 
 bank = "\U4e2d\U56fd\U94f6\U884c";
 bankcode = BOC;
 cardno = 6216611200001347064;
 cardtype = 1;
 city = "\U5357\U4eac\U5e02";
 icon = "http://api-test.ihuluu.com/Public/Images/bank/BOC.jpg";
 id = 27;
 "insert_time" = 1447119302;
 lastno = 7064;
 point = "\U6c5f\U82cf\U7701\U5206\U884c";
 province = "\U6c5f\U82cf\U7701";
 status = 1;
 uid = 10000;
 username = "\U675c\U9053\U5e73";
            }**/
@property (nonatomic, strong) NSString *Bid;      //id
@property (nonatomic, strong) NSString *bank;      //名称
@property (nonatomic, strong) NSString *bankcode;      //
@property (nonatomic, strong) NSString *cardno;      //
@property (nonatomic, strong) NSString *cardtype;      // 1 借记卡  2 信用卡
@property (nonatomic, strong) NSString *city;      //
@property (nonatomic, strong) NSString *icon;      //
@property (nonatomic, strong) NSString *insert_time;      //
@property (nonatomic, strong) NSString *lastno;      //
@property (nonatomic, strong) NSString *point;      //
@property (nonatomic, strong) NSString *province;      //
@property (nonatomic, strong) NSString *status;      //
@property (nonatomic, strong) NSString *username;      //图片




-(id)initWithDict:(NSDictionary *)dict;

@end
