//
//  LocalStorage.h
//  simplr
//
// 本地存储
//
//  Created by snowingsea on 11/22/14.
//  Copyright (c) 2014 jidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalStorage : NSObject

#pragma mark - 路径定义
typedef enum
{
    EDocuments,
    ECaches
} PathType;
/* 沙盒中Document位置 */
#define DocumentsDirectory      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/* 沙盒中Caches位置 */
#define CachesDirectory         [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/* 相对Document路径的完整路径 */
#define DOCUMENTS_PATH(path)    [DocumentsDirectory stringByAppendingPathComponent:path]

/* 相对Caches路径的完整路径 */
#define CACHES_PATH(path)       [CachesDirectory stringByAppendingPathComponent:path]

#pragma mark - 文件信息获取
/* 获取文件路径 */
+ (NSString *)getFilepath:(NSString *)relpath pathtype:(PathType)type;

/* 判断文件是否存在 */
+ (BOOL)existFile:(NSString *)realPath;

#pragma mark - 文件操作
/* 创建文件夹 */
+ (void)createDir:(NSString *)dirPath pathtype:(PathType)type;


@end
