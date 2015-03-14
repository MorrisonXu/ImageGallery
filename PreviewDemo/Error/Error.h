//
//  Error.h
//  simplr
//
//  处理错误
//
//  Created by snowingsea on 12/7/14.
//  Copyright (c) 2014 jidu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Error : NSObject

enum {
    UnknownError =      -1,
    
    NoQuestion =        -3001,
    
    LoginError =        -2001,
    
    NO_MOBILE =         -1101,
    NO_SMS =            -1102,
    NO_PASSWORD =       -1103,
    
    NotJSON =           -1000,
    DataDeficient =     -1001,
    NetworkError =      1,
    
    ServerError =       1000,
    
    TokenTimeout =      2004,
    TokenBlack =        2005,
    FrequentRequest =   2006,
    
    Nonactivated =      3000,
    EmailIllegal =      3001,
    WrongSMSCode =      3002,
    MobileIllegal =     3003,
    PasswordIllegal =   3004,
    UserNotExist =      3005,
    
    WrongPassword =     3010,
    UserForbidden =     3011,
    
    UserCertified =     3030,
    UserCertifying =    3031,
    UploadExceed =      3040,
    
    Answered =          3050,
    
};

#define KEY_ERROR_MSG                   @"msg"
#define KEY_WEBERROR_DOMAIN             @"WebService"
#define KEY_LOCALERROR_DOMAIN           @"logic"
#define ERROR(domain, codeNum, msg)     [NSError errorWithDomain:domain code:codeNum userInfo:[NSDictionary dictionaryWithObjectsAndKeys:msg, KEY_ERROR_MSG, nil]]

#define ERROR_WEBSERVICE(code, msg)     ERROR(KEY_WEBERROR_DOMAIN, code, msg)
#define ERROR_LOCAL(code, msg)          ERROR(KEY_LOCALERROR_DOMAIN, code, msg)


+ (NSError *)webError:(int)code;
+ (NSError *)localError:(int)code;

@end
