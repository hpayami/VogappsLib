//
//  NSObject+PerformSelectorAddition.m
//  VogappsLib
//
//  Created by Ogan Topkaya on 5/8/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import "NSObject+PerformSelectorAddition.h"

@implementation NSObject (PerformSelectorAddition)


- (void)performSelector:(SEL)selector withObjects:(id)obj,... NS_REQUIRES_NIL_TERMINATION{
    va_list ap;
    va_start(ap, obj);
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation;
    
    if (signature) {
        invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:selector];
        
        int index = 2;
        while (obj != nil) {
            [invocation setArgument:&obj atIndex:index];
            obj = va_arg(ap, id);
            index++;
        }
        va_end(ap);
        [invocation invoke];
    }
    
//   TODO: Set return value with primitive types & objects
//    if (signature.methodReturnLength) {
//        id anObject;
//        [invocation getReturnValue:&anObject];
//        return anObject;
//    }
//    else{
//        return nil;
//    }
    
    va_end(ap);
}

- (void)performSelector:(SEL)selector withObject:(id)obj arguments:(va_list)argList{
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation;
    
    if (signature) {
        invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:selector];

        int index = 2;
        do {
            [invocation setArgument:&obj atIndex:index];
            obj = va_arg(argList, id);
            index++;

        } while (obj != nil);
        
        va_end(argList);
        [invocation invoke];
    }
}




@end
