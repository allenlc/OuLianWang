//
//  NewMD5.m
//  OuLianWang
//
//  Created by allenariel on 15/7/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "NewMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NewMD5
//md5 16位加密 （大写）
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
