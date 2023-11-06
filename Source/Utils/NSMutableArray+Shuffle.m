//
//  NSMutableArray+Shuffle.m
//  VogappsLib
//
//  Created by Volkan Demircin on 26/01/15.
//  Copyright (c) 2015 Vogapps. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle {
    NSUInteger count = self.count;
    
    for (NSInteger i=count-1; i>0; i--) {
        NSInteger random = arc4random_uniform((uint32_t)i+1);
        [self exchangeObjectAtIndex:i withObjectAtIndex:random];
    }
}

- (void)shuffleAndFilterFirstNumberOfObjects:(NSUInteger)number {
    [self shuffle];
    
    while (self.count >= number) {
        [self removeLastObject];
    }
}

@end
