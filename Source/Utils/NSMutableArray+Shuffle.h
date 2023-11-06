//
//  NSMutableArray+Shuffle.h
//  VogappsLib
//
//  Created by Volkan Demircin on 26/01/15.
//  Copyright (c) 2015 Vogapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Shuffle)

- (void)shuffle;
- (void)shuffleAndFilterFirstNumberOfObjects:(NSUInteger)number;

@end
