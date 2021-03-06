//
//  StringUtil.h
//  TwitterFon
//
//  Created by kaz on 7/20/08.
//  Copyright 2008 naan studio. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

#define kHappyFace		@"\ue415"
#define kUnhappyFace	@"\ue058"


@interface NSString (NSStringUtils)

/////weibo
- (NSString*)encodeAsURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;
+ (NSString*)localizedString:(NSString*)key;
+ (NSString*)base64encode:(NSString*)str;


////system
+ (NSString *)stringWithInt:(int)value;
+ (NSString *)GetUUID;
- (NSNumber *)toNumber;

- (NSString *)phoneNumberFilter;
- (NSString *)phoneNumberFilter2;

// example : "peng@163.com; hello@126.com, tom@tom.com"
- (NSArray *)emailStringToArray;
- (NSString *)stringByURLEncode;
- (NSString *)pinyinFirstLetter;

- (NSString *)stringByAddQueryParameter:(NSString*)parameter value:(NSString*)value;
- (NSString *)stringByAddQueryParameter:(NSString*)parameter boolValue:(BOOL)value;
- (NSString *)stringByAddQueryParameter:(NSString*)parameter intValue:(int)value;
- (NSString *)stringByAddQueryParameter:(NSString*)parameter doubleValue:(double)value;

+ (NSString*)formatPhone:(NSString*)phone countryTelPrefix:(NSString*)countryTelPrefix;

- (NSString*)insertHappyFace;
- (NSString*)insertUnhappyFace;

- (NSString*)encodeMD5Base64:(NSString*)key;

- (NSString*)encode3DESBase64:(NSString*)key;
- (NSString*)decodeBase643DES:(NSString*)key;

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;

- (NSString *)encodedURLParameterString;

- (NSMutableDictionary *)URLQueryStringToDictionary;

+ (NSString*)floatToStringWithoutZeroTail:(float)floatValue;

- (BOOL)isMobileInChina;

@end

extern BOOL NSStringIsValidEmail(NSString *checkString);
extern BOOL NSStringIsValidPhone(NSString *checkString);
extern NSString* pinyinStringFirstLetter(unsigned short hanzi);



