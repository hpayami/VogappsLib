//
//  Utilities.h
//  VogappsLib
//
//  Created by Volkan Demircin on 5/13/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! Utilities class contains static methods that are frequently used throughout the application.
 *\
 */
@interface Utilities : NSObject

#pragma  mark - C Type
/*! Returns the localized string from the language bundle
 \param key NSString name key of the localized string
 */
NSString *LocalizedString(NSString *key);

/*! Interpolarates values between min&max
 When min = 10 , max = 20 , value = 0.5 => result = 15
 */
float lerp(float min, float max, float value);

/*! Inverse calculation of lerp
 When min = 10 , max = 20 , value = 15 => result = 0.5
 */
float inverseLerp(float min,float max,float value);

/**
 *  @return Returns screen size with actual pixel values besides orientation
 */
+ (CGRect)screenBounds;

/**
 *  @return Return device architecture model.
 */
+ (NSString*)platformRawString;

#pragma mark - String Methods
/*! Returns the md5 encoded string
 \param string NSString to encode
 */
+ (NSString *)md5FromString:(NSString*) string;

/*! Returns money value from money formatted string
 \param string String value of money
 */
+(double) moneyValueFromString:(NSString*) string;

/*! Returns formatted money string
 \param value Double value of money
 \param dollarSign BOOL value for adding dollar sign at the beginning of the formatted string
 \param fullNumber BOOL value for returning the full number or short version
 */
+ (NSString *)moneyStringFromValue:(double) value withDollarSign:(BOOL) dollarSign showsFullNumber:(BOOL) fullNumber;

/*! Returns string representation of the currency amount according to the specified locale
 \param price NSDecimalNumber
 \param locale NSLocale
 */
+ (NSString *)formattedNumber:(NSDecimalNumber *)price locale:(NSLocale *)locale;

/*! Returns the full name by only showing the first letter of the last name
 \param fullName NSString value of the full name
 */
+ (NSString *)hideTheLastName:(NSString *)fullName;

/*! Returns Base64 representation of given data
 \param theData NSData
 */
+ (NSString*)base64forData:(NSData*)theData;

/*! Returns service link by concatenating base adress with service name and default parameters; app version and platform.
 \param baseAdress NSString
 \param serviceName NSString
 */
+ (NSString *)getServiceLinkWithBase:(NSString *)baseAdress service:(NSString *)serviceName;

#pragma mark - Date / Time Methods

/*! Returns the NSString value of the interval between the receiver and the first instant of 1 January 2001, GMT
 */
+ (NSString *)timeStamp;

/*! Returns the NSString value of the currentDate in format HH:mm:ss
 */
+ (NSString *)basicTimeStamp;

/*! Returns the generic humanReadable time
 \param timeStamp NSTimeInterval
 */
+ (NSString *)humanReadableTimeForGivenTimeStamp:(NSTimeInterval)timeStamp;

/*! Returns base64 string representation of the data using ASCII encoding
 \param price NSDecimalNumber
 \param locale NSLocale
 */

#pragma mark - Project Settings
/*! Returns the current app version from CFBundleShortVersionString
 */
+ (NSString *) currentAppVersion;

#pragma mark - App Settings
/*! Save app setting values into NSUserDefaults
 \param object value to save
 \param key Key of the value to save
 */
+ (void)setAppDefault:(id)object forKey:(NSString *)key;

/*! Returns the app settings object that is saved to NSuserDefaults
 */
+ (id)getAppDefault:(NSString *)key;

/*! Removes the app settings value from NSUserDefaults
 \param key Key of the object to remove
 */
+ (void)removeAppDefault:(NSString *)key;

/*! Removes all values in NSUserDefaults
 */
+ (void)deleteAllAppDefaults;

#pragma mark - Unique ID
/*! Generates and returns a unique identifier
 */
+ (NSString *)generateUniqueID;


/*! Returns the advertising identifier for iOS 6 and later
 */
+ (NSString *)getAdvertisingIdentifier;

/*! Returns the identifier for vendor for iOS 6 and later.
 *  Stores the value to KeyChain and use the one in the keyChain if exists.
 */
+ (NSString *)getIdentifierForVendor;

/*! Returns NSString value of the date in given format
 */
+ (NSString *)dateInFormat:(NSString*) stringFormat;

/*! Returns NSString value of given timeStamp in dd/MM/yyyy format */
+ (NSString *)formatTimeStamp:(NSTimeInterval)timeStamp;

+ (NSString *)encode:(const uint8_t *)input length:(NSInteger)length;

+ (BOOL)validateEmail:(NSString *)candidate;

@end
