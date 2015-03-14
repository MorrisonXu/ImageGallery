//
//  JDDisplayImage.m
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import "JDDisplayImage.h"
#import "LocalStorage.h"
#import "WebService.h"

@implementation JDDisplayImage

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.backgroundColor = [UIColor clearColor];
        // 制定UIScrollViewDelegate，不是JDDisplayImageDelegate
        self.delegate = self;
        self.minimumZoomScale = 1.0;
        
        _ivDisplay = [[UIImageView alloc] init];
        _ivDisplay.clipsToBounds = YES;
        _ivDisplay.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_ivDisplay];
    }
    return self;
}

#pragma mark - 功能函数

/**
 *  用于放大缩小时的Animation动画效果
 *
 *  @param framePreview Preview时小图片的Frame信息
 */
- (void)setPreviewFrame:(CGRect)framePreview {
    _framePreview = framePreview;
    [_ivDisplay setFrame:framePreview];
}

/**
 *  设置Display的图片
 *
 *  @param previewData 高清和预览图片的URL相关信息
 *  @param type        告知应该加载预览图还是高清图
 */
- (void)setImageData:(JDPreviewData *)previewData withType:(DisplayType)type withCache:(BOOL)toCache {
    NSURL *webUrl;
    NSString *localPath;
    switch (type) {
        case EDisplayBlur:
            webUrl = [NSURL URLWithString:previewData.urlBlur];
            localPath = [LocalStorage getFilepath:previewData.pathBlur pathtype:ECaches];
            break;
            
        case EDisplayHD:
            webUrl = [NSURL URLWithString:previewData.urlHD];
            localPath = [LocalStorage getFilepath:previewData.pathHD pathtype:ECaches];
            break;
            
        default:
            break;
    }
    
    if ([LocalStorage existFile:localPath]) {
        [_ivDisplay setImage:[UIImage imageWithContentsOfFile:localPath]];
    } else {
//        [_ivDisplay setImageWithURLRequest:url placeholderImage:nil success:<#^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)success#> failure:<#^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)failure#>]
        
        [_ivDisplay setImageWithURL:webUrl];
        if (toCache)
            [[WebStorage sharedStorage] addImageCache:webUrl localPath:localPath];
    }
    
    _sizeOrigin = _ivDisplay.image.size;
    
    // X & Y轴的缩放比例
    CGFloat scaleX = self.frame.size.width / _sizeOrigin.width;
    CGFloat scaleY = self.frame.size.height / _sizeOrigin.height;
    
    // 按照缩放少的为标准进行缩放，并设置最大缩放比例，不让图片放大超过满屏幕
    if (scaleX > scaleY) {
        CGFloat newWidth = _sizeOrigin.width * scaleY;
        self.maximumZoomScale = self.frame.size.width / newWidth;
        _frameDisplay = CGRectMake((self.frame.size.width - newWidth) / 2.0, 0, newWidth, self.frame.size.height);
    } else {
        CGFloat newHeight = _sizeOrigin.height * scaleX;
        self.maximumZoomScale = self.frame.size.height / newHeight;
        _frameDisplay = CGRectMake(0, (self.frame.size.height - newHeight) / 2.0, self.frame.size.width, newHeight);
    }
}

- (void)func {
    if (_ivDisplay.image == nil) {
        
        
    }
    
    
    
}

/**
 *  设置缩放后的Frame，用于UIView的Animation动画效果
 */
- (void)setAnimationFrame {
    self.zoomScale = 1.0;
    _ivDisplay.frame = _frameDisplay;
}

/**
 *  将frame设为Preview时候的，用于UIView的Animation动画效果
 */
- (void)resetFrame {
    self.zoomScale = 1.0;
    _ivDisplay.frame = _framePreview;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _ivDisplay;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = _ivDisplay.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width / 2.0, contentSize.height / 2.0);
    
    if (imgFrame.size.width <= boundsSize.width) {
        centerPoint.x = boundsSize.width / 2.0;
    }
    if (imgFrame.size.height <= boundsSize.height) {
        centerPoint.y = boundsSize.height / 2.0;
    }
    _ivDisplay.center = centerPoint;
}

#pragma mark - Touch Event

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.displayDelegate respondsToSelector:@selector(displayImageTappedWithObject:)]) {
        [self.displayDelegate displayImageTappedWithObject:self];
    }
}

@end
