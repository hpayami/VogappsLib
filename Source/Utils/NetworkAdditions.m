//
//  NetworkAdditions.m
//  VogappsLib
//
//  Created by Ogan Topkaya on 8/1/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import "NetworkAdditions.h"

@implementation NSString (NSStringNetworkAdditions)

+ (NSString *)stringWithData:(NSData *)data{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString*)urlEscapeString:(NSString *)unencodedString{
    CFStringRef originalStringRef = (__bridge_retained CFStringRef)unencodedString;
    NSString *s = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,originalStringRef, NULL, NULL,kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return s;
}


+ (NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary{
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQuerystring rangeOfString:@"?"].location == NSNotFound) {
            [urlWithQuerystring appendFormat:@"?%@=%@", [keyString urlEndodedString], [valueString urlEndodedString]];
        } else {
            [urlWithQuerystring appendFormat:@"&%@=%@", [keyString urlEndodedString], [valueString urlEndodedString]];
        }
    }
    return urlWithQuerystring;
}

- (NSString *)urlEndodedString{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@":!*();@/&?#[]+$,='%’\""]];
}

@end


@implementation NSURL (NSURLQuery)

- (NSArray *)queryArray {
	
	if (![self query]) return nil;
	NSScanner *scanner = [NSScanner scannerWithString:[self query]];
	if (!scanner) return nil;
	
	NSMutableArray *array = [NSMutableArray array];
	
	NSString *key;
	NSString *val;
	while (![scanner isAtEnd]) {
		if (![scanner scanUpToString:@"=" intoString:&key]) key = nil;
		[scanner scanString:@"=" intoString:nil];
		if (![scanner scanUpToString:@"&" intoString:&val]) val = nil;
		[scanner scanString:@"&" intoString:nil];
		
		key = [key stringByRemovingPercentEncoding];
		val = [val stringByRemovingPercentEncoding];
		
		if (key) [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   key, @"key", val, @"value", nil]];
	}
	return array;
}

- (NSDictionary *)queryDictionary {
	if (![self query]) return nil;
	NSArray *parameterArray = [self queryArray];
	
	NSArray *keys = [parameterArray valueForKey:@"key"];
	NSArray *values = [parameterArray valueForKey:@"value"];
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	return dictionary;
}

@end
