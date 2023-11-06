//
//  SKProduct+CurrencyCode.m
//  VogappsLib
//
//  Created by Ogan on 09/06/14.
//  Copyright (c) 2014 Vogapps. All rights reserved.
//

#import "SKProduct+CurrencyCode.h"

@implementation SKProduct (CurrencyCode)

-(NSString *)currencyCode{
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:self.priceLocale];
        [numberFormatter setMaximumFractionDigits:2];
    });
    return numberFormatter.currencyCode;
}


@end
