//
//  SKProduct+CurrencyCode.h
//  VogappsLib
//
//  Created by Ogan Topkaya on 09/06/14.
//  Copyright (c) 2014 Vogapps. All rights reserved.
//

#import <StoreKit/StoreKit.h>

@interface SKProduct (CurrencyCode)

- (NSString *)currencyCode;

@end
