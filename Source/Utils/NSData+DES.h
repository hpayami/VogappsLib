//
//  NSData+DES.h
//  VogappsLib
//
//  Created by Ogan Topkaya on 29/01/14.
//  Copyright (c) 2014 Vogapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DES)

- (NSData*) encryptDES: (NSString *) key;
- (NSData *) decryptDES: (NSString *) key;

@end
