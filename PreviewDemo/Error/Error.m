//
//  Error.m
//  simplr
//
//  Created by snowingsea on 12/7/14.
//  Copyright (c) 2014 jidu. All rights reserved.
//

#import "Error.h"

@implementation Error

/**
 *  网络错误相关
 *
 *  @param code 错误代码
 *
 *  @return 错误类
 */
+ (NSError *)webError:(int)code {
    NSString *msg = @"";
    int num = code;
    switch (code) {
        case NotJSON:
            msg = NSLocalizedStringFromTable(@"NotJSON", @"Error", nil);
            break;
        case NetworkError:
            msg = NSLocalizedStringFromTable(@"NetworkError", @"Error", nil);
            break;
        case DataDeficient:
            msg = NSLocalizedStringFromTable(@"DataDeficient", @"Error", nil);
            break;
        case TokenTimeout:
            msg = NSLocalizedStringFromTable(@"TokenTimeout", @"Error", nil);
            break;
        case TokenBlack:
            msg = NSLocalizedStringFromTable(@"TokenBlack", @"Error", nil);
            break;
        case FrequentRequest:
            msg = NSLocalizedStringFromTable(@"FrequentRequest", @"Error", nil);
            break;
        case Nonactivated:
            msg = NSLocalizedStringFromTable(@"Nonactivated", @"Error", nil);
            break;
        case EmailIllegal:
            msg = NSLocalizedStringFromTable(@"EmailIllegal", @"Error", nil);
            break;
        case WrongSMSCode:
            msg = NSLocalizedStringFromTable(@"WrongSMSCode", @"Error", nil);
            break;
        case MobileIllegal:
            msg = NSLocalizedStringFromTable(@"MobileIllegal", @"Error", nil);
            break;
        case PasswordIllegal:
            msg = NSLocalizedStringFromTable(@"PasswordIllegal", @"Error", nil);
            break;
        case WrongPassword:
            msg = NSLocalizedStringFromTable(@"WrongPassword", @"Error", nil);
            break;
        case UserForbidden:
            msg = NSLocalizedStringFromTable(@"UserForbidden", @"Error", nil);
            break;
        case UserCertified:
            msg = NSLocalizedStringFromTable(@"UserCertified", @"Error", nil);
            break;
        case UserCertifying:
            msg = NSLocalizedStringFromTable(@"UserCertifying", @"Error", nil);
            break;
        case UploadExceed:
            msg = NSLocalizedStringFromTable(@"UploadExceed", @"Error", nil);
            break;
        case Answered:
            msg = NSLocalizedStringFromTable(@"Answered", @"Error", nil);
            break;
        default:
            num = ServerError;
            msg = NSLocalizedStringFromTable(@"ServerError", @"Error", nil);
            break;
    }
    
    return ERROR_WEBSERVICE(num, msg);
}

/**
 *  本地错误相关
 *
 *  @param code 错误代码
 *
 *  @return 错误类
 */
+ (NSError *)localError:(int)code {
    NSString *msg;
    switch (code) {
        case NO_MOBILE:
            msg = NSLocalizedStringFromTable(@"NoMobile", @"Error", nil);
            break;
        case NO_SMS:
            msg = NSLocalizedStringFromTable(@"NoSMS", @"Error", nil);
            break;
        case NO_PASSWORD:
            msg = NSLocalizedStringFromTable(@"NoPassword", @"Error", nil);
            break;
        case LoginError:
            msg = NSLocalizedStringFromTable(@"LoginError", @"Error", nil);
            break;
        case NoQuestion:
            msg = NSLocalizedStringFromTable(@"NoQuestion", @"Error", nil);
            break;
            
        default:
            break;
    }
    
    return ERROR_WEBSERVICE(code, msg);
}

@end
