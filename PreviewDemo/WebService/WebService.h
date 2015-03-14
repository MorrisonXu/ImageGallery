//
//  WebService.h
//  simplr
//
//  网络服务基础类，接收JSON数据的网络请求
//
//  Created by snowingsea on 11/26/14.
//  Copyright (c) 2014 jidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperation.h>
#import "UIImageView+AFNetworking.h"
#import "WebStorage.h"


@interface WebService : NSObject

#define KEY_NET_ERROR_NUMBER        @"ret"

// 初始化配置
+ (void)config;

// GET请求
+ (NSURLSessionDataTask *)GET:(NSString *)baseURLString
                pathURLString:(NSString *)pathURLString
                   parameters:(id)parameters
                     callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);
+ (AFHTTPRequestOperation *)GETWithHeader:(NSString *)urlString
                                   header:(NSDictionary *)header
                               parameters:(NSDictionary *)parameters
                                 callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);


// POST请求
+ (NSURLSessionDataTask *)POST:(NSString *)baseURLString
                 pathURLString:(NSString *)pathURLString
                         query:(id)query
                      callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);
+ (NSURLSessionDataTask *)POST:(NSString *)baseURLString
                 pathURLString:(NSString *)pathURLString
                          body:(id)body
                      callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);
+ (NSURLSessionDataTask *)POST:(NSString *)baseURLString
                 pathURLString:(NSString *)pathURLString
                         query:(id)query
                          body:(id)body
                      callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);

+ (AFHTTPRequestOperation *)POSTWithHeader:(NSString *)urlString
                                    header:(NSDictionary *)header
                                     query:(id)query
                                      body:(id)body
                                  callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);
+ (AFHTTPRequestOperation *)POSTWithHeader:(NSString *)urlString
                                    header:(NSDictionary *)header
                                     query:(id)query
                                  callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);
+ (AFHTTPRequestOperation *)POSTWithHeader:(NSString *)urlString
                                    header:(NSDictionary *)header
                                      body:(id)body
                                  callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);

// 上传
+ (void)upload:(NSString *)urlString
    parameters:(id)parameters
      FilePath:(NSString *)path
      callback:(void (^)(NSDictionary *data, NSError *error))callback NS_AVAILABLE_IOS(4_0);

@end
