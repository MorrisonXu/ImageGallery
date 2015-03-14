//
//  JDPreviewData.m
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import "JDPreviewData.h"

@implementation JDPreviewData

- (void)initWithURLBlur:(NSString *)urlBlur URLHD:(NSString *)urlHD pathBlur:(NSString *)pathBlur pathHD:(NSString *)pathHD {
    self.urlBlur = urlBlur;
    self.urlHD = urlHD;
    self.pathBlur = pathBlur;
    self.pathHD = pathHD;
}

@end
