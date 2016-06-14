//
//  MHCommonTool.m
//  XinHua
//
//  Created by qu pengbin on 11-11-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MHCommonTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "QuartzCore/QuartzCore.h"
#import <CoreLocation/CoreLocation.h>

@implementation MHCommonTool




+ (NSString *)calculate:(float)time
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSString  *timeOut=[self calculateMarrySpacing:date endDate:[NSDate date]];
    NSLog(@"%@",timeOut);
    return  timeOut;
    
}
+ (NSString *)calculateMarrySpacing:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:@"yyyy-MM-dd"];
    [dateFormate setLocale:[NSLocale currentLocale]];
    startDate = [dateFormate dateFromString:[dateFormate stringFromDate:startDate]];
    endDate = [dateFormate dateFromString:[dateFormate stringFromDate:endDate]];
    
    NSLog(@"start Date is %@",startDate);
    NSLog(@"endDate date is %@",endDate);
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned int unitFlags = NSDayCalendarUnit;
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    
    NSInteger days = [comps day];
    
    NSString *marryForwordDays = [NSString stringWithFormat:@"%ld",(long)days];
    
    [gregorian release];
    [dateFormate release];
    return marryForwordDays;
}

/**   函数名称 :dateToString
 **   函数作用 :date根据formatter转换成string
 **   函数参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           timeInterval       ---时间戳
 **   函数返回值:格式
 **/
+(NSString*)dateToString:(NSString *)formatter timeInterval:(NSTimeInterval)timeInterval{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:formatter];
    return[dateFormatter stringFromDate:date];
}

//函数作用 :date根据formatter转换成string
+(NSString*)dateToString:(NSString *)formatter date:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:formatter];
    return[dateFormatter stringFromDate:date];
}

/**   函数名称 :dateToString
 **   函数作用 :date根据formatter转换成string
 **   函数参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           secs       ---日期的时间辍
 **   函数返回值:格式
 **/
+(NSString*)dateToString:(NSString *)formatter secs:(NSTimeInterval)secs{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:secs];
    return [self dateToString:formatter date:date];
}

/**   函数名称 :getCurrentTime
 **   函数作用 :获取当前时间
 **   函数参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **   函数返回值:格式
 **/
+(NSString *)getCurrentTime:(NSString *)formatter{
    NSDate *date=[NSDate date];
    return [self dateToString:formatter date:date];
}

//函数作用 :将日期从原格式转换成需要的格式
+(NSString*)convertDateFormatter:(NSString*)sourceFormatter 
                  targetFormatter:(NSString*)targetFormatter  
                       dateString:(NSString*)dateString
{   
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:sourceFormatter];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:targetFormatter];
    return[dateFormatter stringFromDate:date];
}

//函数作用 :将日期字符串转换成date
+(NSDate *)stringToDate:(NSString *)formatter dateString:(NSString *)dateString{
	NSDateFormatter *dateFormatter= [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:formatter];
	return [dateFormatter dateFromString:dateString];
}

//将char数据转换成utf8格式的string
+(NSString *)charToUTF8String:(const char *)charData
{
    NSString *string = [NSString stringWithUTF8String:charData];
    return string;
}

//将string转换成MD5格式数据,需引进库<CommonCrypto/CommonDigest.h>
+ (NSString *)stringToMD5Value:(NSString *)string
{
	if (string==nil) 
    {
		return nil;
	}
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}


//将string转换成Sha格式数据,需引进库<CommonCrypto/CommonDigest.h>
+(NSString *)stringToShaValue:(NSString *)string{
    const char *cStr = [string UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:string.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//函数作用 :得到随机数字
+(int)randNumber:(int)max
{
    return arc4random()%max+1;
}

//函数作用 :替换不必要的字符
+(NSString *)replaceStringToString:(NSString *)needReplaceStr
                     replaceString:(NSString *)replaceString
                   toReplaceString:(NSString *)toReplaceString
{
    NSString *string = [needReplaceStr stringByReplacingOccurrencesOfString:replaceString withString:toReplaceString];
    return string;
}

//函数作用 :去除首尾空格
+ (NSString *)trimString:(NSString *)buf
{    
    NSString *string = [[[NSMutableString alloc] initWithString:buf] autorelease];
    
    CFStringTrimWhitespace((CFMutableStringRef)string);
    
    return string;
}

//将data类型的数据,转成UTF8的数据
+(NSString *)dataToUTF8String:(NSData *)data
{
	NSString *buf = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return [buf autorelease];
}

//角度转弧度  
+ (CGFloat)toRadians:(CGFloat)degree {  
    return degree / 180.0 * M_PI;  
}  
//弧度转角度  
+ (CGFloat)toDegrees:(CGFloat)radian {  
    return radian / M_PI * 180.0;  
}  

//将string转换为指定编码 
+(NSString *)changeDataToEncodinString:(NSData *)data encodin:(NSStringEncoding )encodin{
    NSString *buf = [[[NSString alloc] initWithData:data encoding:encodin] autorelease];
    return buf;
}

//uialert提醒
+(void)alertWithTitle:(NSString *)title 
              Message:(NSString *)message 
             delegate:(id)delegate 
         cancelButton:(NSString *)cancelButton
          otherButton:(NSString *)otherButton
{    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:delegate cancelButtonTitle:cancelButton otherButtonTitles:otherButton,nil];
	
	[alert show];
	[alert release];
}

+ (BOOL)stringIsValidEmail:(NSString *)checkString
{  
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";   
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString]; 
    
    return [emailTest evaluateWithObject:checkString];  
}


//截屏
+(UIImage *)getScreenShot:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**   函数名称 :SaveDataToUserDefaults
 **   函数作用 :将信息写入沙盒
 **   函数参数 : 
 **   函数返回值:
 **/
+(void)saveDataToUserDefaults:(NSString *)key value:(NSString *)vallue{
    [[NSUserDefaults standardUserDefaults] setObject:vallue forKey:key];
}

/**   函数名称 :GetDataFromUserDefaults
 **   函数作用 :从沙盒中读取信息
 **   函数参数 : 
 **   函数返回值:
 **/
+(id)getDataFromUserDefaults:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/**   函数名称 :createUUID
 **   函数作用 :创建UUID
 **   函数参数 : 
 **   函数返回值:
 **/
+(NSString *)createUUID{
    // create a new UUID which you own
	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	
	// create a new CFStringRef (toll-free bridged to NSString)
	// that you own
	NSString *uuidString = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
	// release the UUID
	CFRelease(uuid);
    
    // transfer ownership of the string
	// to the autorelease pool
	return [uuidString autorelease];
}

@end
