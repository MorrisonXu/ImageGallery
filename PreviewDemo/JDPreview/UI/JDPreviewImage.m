//
//  JDPreviewImage.m
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import "JDPreviewImage.h"
#import "LocalStorage.h"
#import "WebService.h"

@interface JDPreviewImage ()

- (void)setImageData:(JDPreviewData *)previewData withType:(DisplayType)type withCache:(BOOL)toCache;

@end

@implementation JDPreviewImage

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self create];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self create];
    }
    return self;
}

- (void)create {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapped:)];
    [self addGestureRecognizer:tap];
    
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
}

- (void)setImageData:(JDPreviewData *)previewData withCache:(BOOL)toCache {
    [self setImageData:previewData withType:EDisplayBlur withCache:toCache];
}

- (void)setImageData:(JDPreviewData *)previewData withType:(DisplayType)type withCache:(BOOL)toCache {
    NSString *url;
    NSString *path;
    switch (type) {
        case EDisplayBlur:
            url = previewData.urlBlur;
            path = previewData.pathBlur;
            break;
            
        case EDisplayHD:
            url = previewData.urlHD;
            path = previewData.pathHD;
            break;
            
        default:
            break;
    }
    
    if ([LocalStorage existFile:path]) {
        [self setImage:[UIImage imageWithContentsOfFile:path]];
    } else {
        [self setImageWithURL:[NSURL URLWithString:url]];
        if (toCache)
            [[WebStorage sharedStorage] addImageCache:[NSURL URLWithString:url] localPath:path];
    }
}

- (void)Tapped:(UIGestureRecognizer *)gesture {
    if ([self.previewDelegate respondsToSelector:@selector(previewImageTappedWithObject:)]) {
        [self.previewDelegate previewImageTappedWithObject:self];
    }
}

@end
