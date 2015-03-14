//
//  WebStorage.h
//  simplr
//
//  Created by snowingsea on 1/27/15.
//  Copyright (c) 2015 jidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebStorage : NSObject {
    NSMutableArray *_cache;
}

// 单态
+ (WebStorage *)sharedStorage;

// 添加图片缓存队列
- (void)addImageCache:(NSURL *)url localPath:(NSString *)path;

// 清空队列，缓存所有图片
- (void)synchronize;

@end
