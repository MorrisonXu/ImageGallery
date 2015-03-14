//
//  WebService.m
//  simplr
//
//  网络服务支持，返回数据格式为JSON
//
//  Created by snowingsea on 11/26/14.
//  Copyright (c) 2014 jidu. All rights reserved.
//

#import "WebService.h"
#import <AFHTTPRequestOperationManager.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "AFAppNetClients.h"
#import "Error.h"

#define WEB_DEBUG           NO
#define WEB_QUERY_INFO_LEN  100

@interface WebService ()

+ (NSString *)getURLString:(NSString *)originalURL withArgs:(NSDictionary *)args;
+ (void)setHeader:(NSDictionary *)parameters withManager:(AFHTTPRequestOperationManager *)manager;

@end

@implementation WebService

+ (void)config {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [WebStorage sharedStorage];
}

/**
 *  http的get请求
 *
 *  @param baseURLString 域url
 *  @param pathURLString 子路径
 *  @param parameters    参数
 *  @param callback      回调
 *
 *  @return 对应的NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)GET:(NSString *)baseURLString pathURLString:(NSString *)pathURLString parameters:(id)parameters callback:(void (^)(NSDictionary *, NSError *))callback {
    AFHTTPSessionManager *client = [[AFAppNetClients sharedClients]clientWithURLString:baseURLString];
    if (WEB_DEBUG)
        NSLog(@"GET: %@", [self WebQueryInfo:pathURLString withArgs:parameters]);
    return [client GET:pathURLString
            parameters:parameters
               success:^(NSURLSessionDataTask *__unused task, id responseObject) {
                   if (callback)
                       callback(responseObject, [self findError:responseObject]);
               } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                   if (callback)
                       callback(nil, [self handleNetError:error]);
               }];
}

/**
 *  http带header参数的get请求
 *
 *  @param urlString  url字符串
 *  @param header     header参数
 *  @param parameters get参数
 *  @param callback   回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)GETWithHeader:(NSString *)urlString header:(NSDictionary *)header parameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *, NSError *))callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [WebService setHeader:header withManager:manager];
    if (WEB_DEBUG)
        NSLog(@"GET[AUTH]: %@", [self WebQueryInfo:urlString withArgs:parameters]);
    return [manager GET:urlString
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    if (callback)
                        callback(responseObject, [self findError:responseObject]);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    if (callback)
                        callback(nil, [self handleNetError:error]);
                }];
}

/**
 *  只带query参数的POST请求
 *
 *  @param baseURLString 域url
 *  @param pathURLString 子路径
 *  @param query         query参数
 *  @param callback      回调
 *
 *  @return task
 */
+ (NSURLSessionDataTask *)POST:(NSString *)baseURLString pathURLString:(NSString *)pathURLString query:(id)query callback:(void (^)(NSDictionary *, NSError *))callback {
    return [self POST:baseURLString
        pathURLString:pathURLString
                query:query
                 body:nil
             callback:callback];
}


/**
 *  只带body参数的POST请求
 *
 *  @param baseURLString 域url
 *  @param pathURLString 子路径
 *  @param body          body参数
 *  @param callback      回调
 *
 *  @return task
 */
+ (NSURLSessionDataTask *)POST:(NSString *)baseURLString pathURLString:(NSString *)pathURLString body:(id)body callback:(void (^)(NSDictionary *, NSError *))callback {
    return [self POST:baseURLString
        pathURLString:pathURLString
                query:nil
                 body:body
             callback:callback];
}

/**
 *  带query和body参数的POST请求
 *
 *  @param baseURLString 域url
 *  @param pathURLString 子路径
 *  @param query         query参数
 *  @param body          body参数
 *  @param callback      回调
 *
 *  @return task
 */
+ (NSURLSessionDataTask *)POST:(NSString *)baseURLString pathURLString:(NSString *)pathURLString query:(id)query body:(id)body callback:(void (^)(NSDictionary *, NSError *))callback {
    AFHTTPSessionManager *client = [[AFAppNetClients sharedClients]clientWithURLString:baseURLString];
    if (WEB_DEBUG)
        NSLog(@"POST: %@", [self WebQueryInfo:pathURLString withArgs:query]);
    return [client POST:[WebService getURLString:pathURLString withArgs:query]
             parameters:body
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    if (callback)
                        callback(responseObject, [self findError:responseObject]);
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if (callback)
                        callback(nil, [self handleNetError:error]);
                }];
    
}

/**
 *  http带header、query和body参数的post请求
 *
 *  @param urlString      url字符串
 *  @param header         header参数
 *  @param query          query参数
 *  @param body           body参数
 *  @param callback       回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)POSTWithHeader:(NSString *)urlString header:(NSDictionary *)header query:(id)query body:(id)body callback:(void (^)(NSDictionary *, NSError *))callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [WebService setHeader:header withManager:manager];
    if (WEB_DEBUG)
        NSLog(@"POST[AUTH]: %@", [self WebQueryInfo:urlString withArgs:query]);
    return [manager POST:[WebService getURLString:urlString withArgs:query]
              parameters:body
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     if (callback)
                         callback(responseObject, [self findError:responseObject]);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     if (callback)
                         callback(nil, [self handleNetError:error]);
                 }];
}

/**
 *  http带header和query参数的post请求
 *
 *  @param urlString  url字符串
 *  @param header     header参数
 *  @param query      query参数
 *  @param callback   回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)POSTWithHeader:(NSString *)urlString header:(NSDictionary *)header query:(id)query callback:(void (^)(NSDictionary *, NSError *))callback {
    return [self POSTWithHeader:urlString
                         header:header
                          query:query
                           body:nil
                       callback:callback];
}

/**
 *  http带header和body参数的post请求
 *
 *  @param urlString url字符串
 *  @param header    header参数
 *  @param body      body参数
 *  @param callback  回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)POSTWithHeader:(NSString *)urlString header:(NSDictionary *)header body:(id)body callback:(void (^)(NSDictionary *, NSError *))callback {
    return [self POSTWithHeader:urlString
                         header:header
                          query:nil
                           body:body
                       callback:callback];
}

/**
 *  上传文件
 *
 *  @param urlString  url字符串
 *  @param parameters 参数
 *  @param path       文件路径
 *  @param callback   回调
 */
+ (void)upload:(NSString *)urlString parameters:(id)parameters FilePath:(NSString *)path callback:(void (^)(NSDictionary *, NSError *))callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSURL *filePath = [NSURL fileURLWithPath:path];
    if (WEB_DEBUG)
        NSLog(@"Upload: %@", [self WebQueryInfo:urlString withArgs:parameters]);
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id formData) {
        [formData appendPartWithFileURL:filePath name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) callback(nil, error);
    }];
}

#pragma mark - 私有方法
/**
 *  向原始url中添加get参数
 *
 *  @param originalURL 原始url
 *  @param args        参数
 *
 *  @return 最终url(含?xxx=yyy)
 */
+ (NSString *)getURLString:(NSString *)originalURL withArgs:(NSDictionary *)args {
    NSString *url = [NSString stringWithString:originalURL];
//    NSString *url = [[NSString alloc]initWithString:originalURL];
    if (args && [args count] > 0) {
        if ([url rangeOfString:@"?"].location != NSNotFound)
            url = [url stringByAppendingString:@"&"];
        else
            url = [url stringByAppendingString:@"?"];
        BOOL first = YES;
        for (id key in args) {
            if (!first)
                url = [url stringByAppendingString:@"&"];
            first = NO;
            NSString *arg = [NSString stringWithFormat:@"%@=%@", key, args[key]];
            url = [url stringByAppendingString:arg];
        }
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

/**
 *  设置http的header
 *
 *  @param parameters header参数
 *  @param manager    HTTP操作类
 */
+ (void)setHeader:(NSDictionary *)parameters withManager:(AFHTTPRequestOperationManager *)manager {
    if (parameters && manager) {
        for (id key in parameters)
            [manager.requestSerializer setValue:parameters[key] forHTTPHeaderField:key];
    }
}


+ (NSError *)findError:(id)responseObject {
    if (responseObject) {
        int ret = [responseObject[KEY_NET_ERROR_NUMBER] intValue];
        if (ret != 0) {
            NSLog(@"RetErrorMSG:(%d)%@", ret, responseObject[@"msg"]);
            return [Error webError:ret];
        }
        return nil;
    }
    return [Error webError:ServerError];
}

+ (NSError *)handleNetError:(NSError *)err {
    NSLog(@"NetError: %@", err);
    return [Error webError:NetworkError];
}

+ (NSString *)WebQueryInfo:(NSString *)urlString withArgs:(NSDictionary *)args {
    NSString *url = [self getURLString:urlString withArgs:args];
    if (WEB_QUERY_INFO_LEN > 0 && [url length] > WEB_QUERY_INFO_LEN)
        return [[url substringToIndex:WEB_QUERY_INFO_LEN] stringByAppendingString:@"..."];
    return url;
}

@end
