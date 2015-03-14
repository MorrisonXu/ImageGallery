//
//  WebStorage.m
//  simplr
//
//  Created by snowingsea on 1/27/15.
//  Copyright (c) 2015 jidu. All rights reserved.
//

#import "WebStorage.h"
#import <UIImageView+AFNetworking.h>

#define KEY_TYPE        @"type"
#define KEY_URL         @"url"
#define KEY_PATH        @"path"

#define TICK_NUM        5

typedef enum {
    EWSImage
} StorageType;

@interface WebStorage ()

- (void)tick;
- (BOOL)save;

@end

@implementation WebStorage

- (id)init {
    self = [super init];
    if (self) {
        _cache = [[NSMutableArray alloc]init];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(tick)
                                       userInfo:nil
                                        repeats:YES];
    }
    return self;
}

/**
 *  单态
 *
 *  @return 单态对象
 */
+ (WebStorage *)sharedStorage {
    static WebStorage *_sharedStorage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStorage = [[[self class] alloc] init];
    });
    return _sharedStorage;
}

- (void)addImageCache:(NSURL *)url localPath:(NSString *)path {
    [_cache addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                       [NSNumber numberWithInt:EWSImage], KEY_TYPE,
                       path, KEY_PATH,
                       url, KEY_URL,
                       nil]];
}

/**
 *  保存所有缓存
 */
- (void)synchronize {
    while ([_cache count] > 0) {
        NSDictionary *task = [_cache firstObject];
        if (task) {
            [self save];
            [_cache removeObject:task];
        }
    }
}

/**
 *  隔段执行
 */
- (void)tick {
    for (int i = 0; i < TICK_NUM; ++i) {
        NSDictionary *task = [_cache firstObject];
        if (task) {
            if ([self save])
                [_cache removeObject:task];
            else {
                id item = [_cache firstObject];
                [_cache removeObject:item];
                [_cache addObject:item];
            }
        }
    }
}

/**
 *  保存缓存
 */
- (BOOL)save {
    NSDictionary *task = [_cache firstObject];
    if (!task) return YES;
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:task[KEY_URL]];
    switch ([task[KEY_TYPE] intValue]) {
        case EWSImage:
        {
            UIImage *cachedImage = [[UIImageView sharedImageCache] cachedImageForRequest:urlRequest];
            if (cachedImage) {
                if ([task[KEY_PATH] length] > 0) {
                    NSData* imageData = UIImagePNGRepresentation(cachedImage);
                    [imageData writeToFile:task[KEY_PATH] atomically:YES];
                }
                return YES;
            }
            break;
        }
        default:
            break;
    }
    return NO;
}

@end
