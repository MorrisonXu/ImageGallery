//
//  JDPreviewData.h
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EDisplayBlur,
    EDisplayHD
} DisplayType;

@interface JDPreviewData : NSObject

// Remote URLs
@property (nonatomic, strong)NSString *urlBlur;
@property (nonatomic, strong)NSString *urlHD;
// Local Paths
@property (nonatomic, strong)NSString *pathBlur;
@property (nonatomic, strong)NSString *pathHD;

- (void)initWithURLBlur:(NSString *)urlBlur URLHD:(NSString *)urlHD pathBlur:(NSString *)pathBlur pathHD:(NSString *)pathHD;

@end
