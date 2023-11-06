//
//  NetworkAdditions.h
//  VogappsLib
//
//  Created by Ogan Topkaya on 8/1/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringNetworkAdditions)

/*! Converts the given NSData to NSString using NSUTF8StringEncoding
 */
+ (NSString *)stringWithData:(NSData *)data;

/*! Encodes NSString for URL usages using NSUTF8StringEncoding
 */

+ (NSString*)urlEscapeString:(NSString *)unencodedString __deprecated_msg("User urlEndodedString method instead");

/*! Adds query portion to the given string if not alread has query. Final evaluated url will be urlEncoded with UTF8
 \param urlString query will be added to urlString
 \param dictionary will be evaulated using key-value pairs of dictionary
 */
+ (NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary;


/*! Returns url encoded string using encoding UTF-8
 *  Default encoding in Foundation doesn't converts characters like &,?,/ which may cause problems
 */
- (NSString *)urlEndodedString;

@end


@interface NSURL (NSURLQuery)

/*! Returns the query of a given url in an array. The objects returned in the array will be dictionaries.
 \code
    NSURL *url = [NSURL URLWithString:@"http://someurl.php?query1=test1&query2=test2"];
    NSArray *queryArray = [url queryArray];
 
    [[[queryArray objectAtIndex:0] objectForKey:@"key"] isEqualToString:@"query1"]
    [[[queryArray objectAtIndex:0] objectForKey:@"value"] isEqualToString:@"test1"]
 \endcode
 */
- (NSArray *)queryArray;

/*! Returns the query of a given url in a dictionary.
 \code
     NSURL *url = [NSURL URLWithString:@"http://someurl.php?query1=test1&query2=test2"];
     NSDictionary *queryDictionary = [url queryDictionary];
     [[queryDictionary objectForKey:@"query1"] isEqualToString:@"test1"]
     [[queryDictionary objectForKey:@"query2"] isEqualToString:@"test2"]
 \endcode
 */
- (NSDictionary *)queryDictionary;

@end
