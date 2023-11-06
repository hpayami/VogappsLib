//
//  NSObject+PerformSelectorAddition.h
//  VogappsLib
//
//  Created by Ogan Topkaya on 5/8/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformSelectorAddition)

- (void)performSelector:(SEL)selector withObjects:(id)obj,... NS_REQUIRES_NIL_TERMINATION;
- (void)performSelector:(SEL)selector withObject:(id)obj arguments:(va_list)argList;
// TODO: performVariadicSelector:(SEL)selector withObjects:(id)obj, ...

@end


@protocol NSObjectAdditionProtocol <NSObject>
- (void)performSelector:(SEL)selector withObjects:(id)obj,... NS_REQUIRES_NIL_TERMINATION;
- (void)performSelector:(SEL)selector withObject:(id)obj arguments:(va_list)argList;

@end
