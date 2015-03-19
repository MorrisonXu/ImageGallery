//
//  JDDisplayGallery.m
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import "JDDisplayGallery.h"
#import "JDDisplayImage.h"
#import "JDPreviewImage.h"

@interface JDDisplayGallery ()

- (void)addDisplayImage:(JDPreviewData *)previewData withPreviewImage:(JDPreviewImage *)previewImage withIndex:(int)index;

@end

@implementation JDDisplayGallery

- (instancetype)init {
    self = [super init];
    if (self) {
        [self create];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self create];
    }
    return self;
}

- (void)create {
    [self setBackgroundColor:[UIColor blackColor]];
    [self setAlpha:0.0];
    
    _photoBrowser = [[UIScrollView alloc] initWithFrame:self.frame];
    _photoBrowser.pagingEnabled = YES;
    _photoBrowser.delegate = self;
    [self addSubview:_photoBrowser];
    // Initilization
    _previewDatas = [[NSMutableArray alloc] init];
    _displayImages = [[NSMutableArray alloc] init];
    _curIndex = 0;
}

#pragma mark - 功能函数

- (void)addDisplayImages:(NSMutableArray *)previewDatas withPreviewFrames:(NSMutableArray *)previewImages {
    NSLog(@"addDisplayImages", nil);
    [self clearDisplayImages];
    _previewDatas = [previewDatas mutableCopy];
    
    if ([previewDatas count] != [previewImages count])
        return;
    int num = (int)[previewDatas count];
    // 设置ContentSize
    CGSize contentSize = _photoBrowser.contentSize;
    contentSize.width = num * self.frame.size.width;
    [_photoBrowser setContentSize:contentSize];
    
    for (int i = 0; i < num; i ++) {
        [self addDisplayImage:(JDPreviewData *)previewDatas[i] withPreviewImage:(JDPreviewImage *)previewImages[i] withIndex:i];
    }
}

/**
 *  添加图片到Gallery
 *
 *  @param previewData  所添加图片的URL信息
 *  @param previewFrame 所添加图片的预览时的Frame
 */
- (void)addDisplayImage:(JDPreviewData *)previewData withPreviewImage:(JDPreviewImage *)previewImage withIndex:(int)index {
    NSLog(@"addDisplayImage", nil);
    // 将某个控件中的Frame转为全局界面的Frame
    CGRect convertedFrame = [[previewImage superview] convertRect:previewImage.frame toView:[self superview]];
    
    JDDisplayImage *displayImage = [[JDDisplayImage alloc] initWithFrame:CGRectMake(index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [displayImage setPreviewFrame:convertedFrame];
    [displayImage setImageData:previewData withType:EDisplayBlur withCache:YES];
    displayImage.tag = index;
    displayImage.displayDelegate = self;
//    [displayImage setAnimationFrame];
    
    [_displayImages addObject:displayImage];
    [_photoBrowser addSubview:displayImage];
}

/**
 *  清空Gallery
 */
- (void)clearDisplayImages {
    NSLog(@"clearDisplayImages", nil);
    [[_photoBrowser subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_previewDatas removeAllObjects];
    [_displayImages removeAllObjects];
    _curIndex = 0;
}

- (void)showGalleryAt:(int)index {
    NSLog(@"showGalleryAt", nil);
    CGPoint contentOffset = _photoBrowser.contentOffset;
    contentOffset.x = index * self.frame.size.width;
    _photoBrowser.contentOffset = contentOffset;
    
    JDDisplayImage *display = _displayImages[index];
    
    // 当前页面的高清图片加载
    [display setImageData:_previewDatas[index] withType:EDisplayHD withCache:YES];
    
    _curIndex = index;
    
    [display resetFrame];
    [UIView animateWithDuration:DISPLAY_ANIMATION_DURATION
                     animations:^{
                         [display setAnimationFrame];
                         [self setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                     }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating", nil);
    int posIndex = (int)(scrollView.contentOffset.x / self.frame.size.width);
    if (posIndex != _curIndex) {
        [(JDDisplayImage *)_displayImages[_curIndex] setAnimationFrame];
        _curIndex = posIndex;
        // 滑动到对应图片位置时加载对应的高清图片
        [_displayImages[posIndex] setImageData:_previewDatas[posIndex] withType:EDisplayHD withCache:YES];
    }
}

#pragma mark - JDDisplayImageDelegate

- (void)displayImageTappedWithObject:(id)sender {
    NSLog(@"displayImageTappedWithObject", nil);
    JDDisplayImage *imgDisplay = sender;
    [UIView animateWithDuration:DISPLAY_ANIMATION_DURATION
                     animations:^{
                         [self setAlpha:0.0];
                         [imgDisplay resetFrame];
                     }
                     completion:^(BOOL finished) {
                         [imgDisplay setAnimationFrame];
                     }];
}

@end
