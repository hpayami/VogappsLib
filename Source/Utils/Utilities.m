//
//  Utilities.m
//  VogappsLib
//
//  Created by Volkan Demircin on 5/13/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import "Utilities.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/ASIdentifierManager.h>
#import "NetworkAdditions.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
#include <sys/sysctl.h>

@implementation Utilities

+ (CGRect)screenBounds{
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenBounds = screen.bounds;
    
    if ([screen respondsToSelector:@selector(fixedCoordinateSpace)]) {
        screenBounds = [screen.coordinateSpace convertRect:screen.bounds toCoordinateSpace:screen.fixedCoordinateSpace];
    }
    return screenBounds;
}

+ (NSString*)platformRawString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

#pragma mark - String Methods

+ (NSString*)md5FromString:(NSString*) string
{
    
    if(string==nil) return nil;
    
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+(double) moneyValueFromString:(NSString*) string
{
    NSString *valString = [string stringByReplacingOccurrencesOfString:@"$" withString:@""];
    static NSNumberFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setLenient:YES];
		[formatter setGeneratesDecimalNumbers:YES];
    });
    
    return [[formatter numberFromString:valString] doubleValue];
}

+ (NSString *)moneyStringFromValue:(double) value withDollarSign:(BOOL) dollarSign showsFullNumber:(BOOL) fullNumber
{
    static NSNumberFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
    });
    
    value = value>0 ? value : 0; // if the server sends a number<0 - set it to 0.
    
    int numberOfDigits = 0;
    BOOL greaterThanMillion = NO;
    double valueCopy = value;
    
    while (valueCopy>=1) {
        valueCopy/= 10;
        numberOfDigits++;
    }
    
    if (numberOfDigits>6 && !fullNumber) { //we are in the millions - if fullNumber=YES - don't divide or put the M at the end
        value/=1000000;
        greaterThanMillion = YES;
    }
    
    formatter.maximumFractionDigits = greaterThanMillion ? 2 : 0;
    
    NSString *valueString = [formatter stringFromNumber:@(value)];
    
    if(greaterThanMillion) valueString = [NSString  stringWithFormat:@"%@ M",valueString];
    if(dollarSign) valueString = [NSString stringWithFormat:@"$%@",valueString];
    
    return valueString;
}

+ (NSString *)hideTheLastName:(NSString *)fullName
{
    if(fullName==nil) return @"";

    NSString *suppressedName = fullName;
    
    if (![suppressedName isKindOfClass:[NSNull class]]) {
        NSRange range = [suppressedName rangeOfString:@" " options:NSBackwardsSearch];
        if(range.length > 0)
            if(suppressedName.length > range.location+2)
                suppressedName = [NSString stringWithFormat:@"%@.",[suppressedName substringToIndex:range.location+2]];
    }
    
    return suppressedName;
}

+ (NSString *)timeStamp
{
    long long timeIntervalSinceReference = (long long)[[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%lli",timeIntervalSinceReference];
}

+ (NSString *)basicTimeStamp
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    }
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)humanReadableTimeForGivenTimeStamp:(NSTimeInterval)timeStamp
{
    if (timeStamp <= 0) {
        return @"";
    }
    
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] initWithTimeIntervalSince1970:timeStamp / 1000];
    NSDate *date2 = [NSDate date];
    
    // Get conversion to months, days, hours, minutes
    
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    
    if ([conversionInfo year] > 0) {
        return [NSString stringWithFormat:LocalizedString(@"YEARS"),[conversionInfo year]];
    }
    else if ([conversionInfo month] > 0) {
        return [NSString stringWithFormat:LocalizedString(@"MONTHS"),[conversionInfo month]];
    }
    else if ([conversionInfo day] > 0){
        return [NSString stringWithFormat:LocalizedString(@"DAYS"),[conversionInfo day]];
    }
    else if ([conversionInfo hour] > 0){
        return [NSString stringWithFormat:LocalizedString(@"HOURS"),[conversionInfo hour]];
    }
    else if ([conversionInfo minute] > 0){
        return [NSString stringWithFormat:LocalizedString(@"MINUTES"),[conversionInfo minute]];
    }
    else{
        return [NSString stringWithFormat:LocalizedString(@"MINUTES"), 15];
    }
}

+ (NSString *)formatTimeStamp:(NSTimeInterval)timeStamp{
    
    static NSDateFormatter *dateFormatter = nil;
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
    }
    NSDate *joinDate = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000.0f];
    return[dateFormatter stringFromDate:joinDate];
    
}
+ (NSString *)dateInFormat:(NSString*) stringFormat
{
	char buffer[80];
	const char *format = [stringFormat UTF8String];
	time_t rawTime;
	struct tm *timeInfo;
	time(&rawTime);
	timeInfo = localtime(&rawTime);
	strftime(buffer, 80, format, timeInfo);
	return [NSString  stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

+ (NSString *)encode:(const uint8_t *)input length:(NSInteger)length
{
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (BOOL)validateEmail:(NSString *)candidate
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}


+ (NSString *)formattedNumber:(NSDecimalNumber *)price locale:(NSLocale *)locale
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:locale];
    [numberFormatter setMaximumFractionDigits:2];

    NSString *numberString = [numberFormatter stringFromNumber:price];
    
    if([numberString rangeOfString:@"TRY"].location != NSNotFound || [numberString rangeOfString:@"TL"].location != NSNotFound)
    {
        numberString = [NSString stringWithFormat:@"%.2f TL", price.doubleValue];
    }
    
    return numberString;
}

+ (NSString*)base64forData:(NSData*)theData
{
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (NSString *)getServiceLinkWithBase:(NSString *)baseAdress service:(NSString *)serviceName {
    NSString *link = [NSString stringWithFormat:@"http://%@/%@", baseAdress, serviceName];
    
    // Default parameters for all messages
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"ios", @"client_os",
                            [Utilities currentAppVersion], @"client_app_version",
                            nil];
    NSString *linkWithParameters = [NSString addQueryStringToUrlString:link withDictionary:params];
    
    return linkWithParameters;
}

#pragma mark - Project Settings
+ (NSString *)currentAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

#pragma mark - App Settings
+ (void)setAppDefault:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getAppDefault:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeAppDefault:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteAllAppDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}

#pragma mark - Unique ID

+ (NSString *)generateUniqueID
{
    return [[NSUUID UUID] UUIDString];
}

+ (NSString *)getAdvertisingIdentifier
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getIdentifierForVendor
{
    static NSString *keyString = @"idfv";
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];

    UICKeyChainStore *keychain  = [UICKeyChainStore keyChainStoreWithService:bundleIdentifier];
    keychain.synchronizable     = NO;                                                       // Do not sync through iCloud. Prevents the same IDVA on different devices.
    keychain.accessibility      = UICKeyChainStoreAccessibilityAlwaysThisDeviceOnly;        // Do not Sync via Backup.
    
    NSString *identifierForVendor = [keychain stringForKey:keyString];
    if (!identifierForVendor)
    {
        identifierForVendor = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [keychain setString:identifierForVendor forKey:keyString];
    }
    
    return identifierForVendor;
}

@end

#pragma mark - C Type

NSString *LocalizedString(NSString *key)
{
    NSString *langCode = [NSLocale preferredLanguages][0];
    NSString *path= [[NSBundle mainBundle] pathForResource:langCode ofType:@"lproj"];
    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
    
    NSString* str = [languageBundle localizedStringForKey:key value:@"" table:nil];
    
    return str ? str : @"";
}

float lerp(float min, float max, float value) {
    return (1-value)*min + value*max;
}

float inverseLerp(float min,float max,float value){
    return (value - min) / (max - min);
}

