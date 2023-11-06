//
//  NSData+DES.m
//  VogappsLib
//
//  Created by Ogan Topkaya on 29/01/14.
//  Copyright (c) 2014 Vogapps. All rights reserved.
//

#import "NSData+DES.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (DES)

- (NSData*) encryptDES:(NSString *) key{
    return [self encryptDES:key encrypt:YES];
}

- (NSData *) decryptDES: (NSString *) key{
    return [self encryptDES:key encrypt:NO];
}

- (NSData*) encryptDES: (NSString *) key encrypt:(BOOL)encrypt{
    CCOperation operation = (encrypt ? kCCEncrypt : kCCDecrypt);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    size_t numBytesEncrypted = 0;
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeDES;
    void *buffer = malloc(bufferSize);
    
    CCCryptorStatus result = CCCrypt(operation, kCCAlgorithmDES, kCCOptionPKCS7Padding | kCCOptionECBMode,
                                     cKey, kCCKeySizeDES,
                                     NULL,
                                     [self bytes], [self length],
                                     buffer, bufferSize,
                                     &numBytesEncrypted );
    
    if( result == kCCSuccess )
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    
    return nil;
}



@end
