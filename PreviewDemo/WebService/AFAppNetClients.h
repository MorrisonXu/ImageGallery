//
//  AFAppNetClients.h
//  simplr
//
//  单态实现网络Clients
//
//  Created by snowingsea on 11/27/14.
//  Copyright (c) 2014 jidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AFAppNetClients : NSObject {
    NSMutableDictionary *_clients;
}

// 单态
+ (AFAppNetClients *)sharedClients;

// 获取baseURL对应的client
- (AFHTTPSessionManager *)clientWithURLString:(NSString *)baseURLString;

@end
