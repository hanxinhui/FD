//
//  Encryption.m
//  FD
//
//  Created by leoxu on 15/7/7.
//  Copyright (c) 2015年 leoxu. All rights reserved.
//

#import "Encryption.h"
#import <CommonCrypto/CommonCryptor.h>


#define SECRET_KEY    @"7l0p4js9fu6yfwfweu83u41ndbi1ejn2"
#define SECRET_VEC    @"70503102"




static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";



@implementation NSData (Encryption)


//TODO:加密
- (NSData *)AES256EncryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

//TODO:解密
- (NSData *)AES256DecryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}


- (NSString *)newStringInBase64FromData            //追加64编码

{
    
    NSMutableString *dest = [[NSMutableString alloc] initWithString:@""];
    
    unsigned char * working = (unsigned char *)[self bytes];
    
    NSInteger srcLen = [self length];
    
    for (int i=0; i<srcLen; i += 3) {
        
        for (int nib=0; nib<4; nib++) {
            
            int byt = (nib == 0)?0:nib-1;
            
            int ix = (nib+1)*2;
            
            if (i+byt >= srcLen) break;
            
            unsigned char curr = ((working[i+byt] << (8-ix)) & 0x3F);
            
            if (i+nib < srcLen) curr |= ((working[i+nib] >> ix) & 0x3F);
            
            [dest appendFormat:@"%c", base64[curr]];
            
        }
        
    }
    
    return dest;
    
}



+ (NSString*)base64encode:(NSString*)str

{
    
    if ([str length] == 0)
        
        return @"";
    
    const char *source = [str UTF8String];
    
    int strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    
    if (characters == NULL)
        
        return nil;
    
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    
    while (i < strlength) {
        
        char buffer[3] = {0,0,0};
        
        short bufferLength = 0;
        
        while (bufferLength < 3 && i < strlength)
            
            buffer[bufferLength++] = source[i++];
        
        characters[length++] = base64[(buffer[0] & 0xFC) >> 2];
        
        characters[length++] = base64[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        
        if (bufferLength > 1)
            
            characters[length++] = base64[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        
        else characters[length++] = '=';
        
        if (bufferLength > 2)
            
            characters[length++] = base64[buffer[2] & 0x3F];
        
        else characters[length++] = '=';
        
    }
    
    NSString *g = [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] ;
    
    return g;
    
}

//+ (NSString*)TripleAES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key {
//
//    NSString *result;
//    if (kCCEncrypt) {
//        //加密
//        NSData *plain = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSData *cipher = [plain AES256EncryptWithKey:key];
//        
//        result = [GTMBase64 stringByEncodingData:cipher];
//        NSLog(@"加密 0 ======== %@",result);
//
//        
//    }else{
//        //解密
//        NSData* data = [GTMBase64 decodeString:plainText];
//        NSData *plain1 = [data AES256DecryptWithKey:key];
//        result = [[NSString alloc] initWithData:plain1 encoding:NSUTF8StringEncoding];
//        NSLog(@"jie密 1 ========%@", result);
//    }
//
//    
//    return result;
//    
//}
//
////对3des进行加密
//+ (NSString *)encryptString:(NSString *)string {
//    return [self TripleAES:string encryptOrDecrypt:kCCEncrypt key:SECRET_KEY];
//}
//
////对3des进行解密
//+ (NSString *)decryptString:(NSString *)string {
//    return [self TripleAES:string encryptOrDecrypt:kCCDecrypt key:SECRET_KEY];
//
//}


@end
