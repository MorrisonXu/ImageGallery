//
//  AFAppNetClients.m
//  simplr
//
//  Created by snowingsea on 11/27/14.
//  Copyright (c) 2014 jidu. All rights reserved.
//

#import "AFAppNetClients.h"
#import <AFHTTPRequestOperationManager.h>

@implementation AFAppNetClients

- (id)init {
    self = [super init];
    if (self) {
        _clients = [[NSMutableDictionary alloc]init];
    }
    return self;
}

/**
 *  单态
 *
 *  @return 单态对象
 */
+ (AFAppNetClients *)sharedClients {
    static AFAppNetClients *_sharedClients;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClients = [[[self class] alloc] init];
    });
    return _sharedClients;
}

/**
 *  获取baseURL对应的client
 *
 *  @param baseURL 基础URL
 *
 *  @return 对应client
 */
- (AFHTTPSessionManager *)clientWithURLString:(NSString *)baseURLString {
    id client = [_clients objectForKey:baseURLString];
    if (!client) {
        client = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseURLString]];
        [_clients setObject:client forKey:baseURLString];
        
    }
    return client;
}

@end
