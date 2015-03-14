//
//  JDDisplayGallery.h
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDDisplayImage.h"
#import "JDPreviewImage.h"
#import "JDPreviewData.h"

#define DISPLAY_ANIMATION_DURATION      0.5

@interface JDDisplayGallery : UIView <UIScrollViewDelegate, JDDisplayImageDelegate> {
    UIScrollView *_photoBrowser;
    NSMutableArray *_previewDatas;
    NSMutableArray *_displayImages;
    int _curIndex;
}

- (void)addDisplayImages:(NSMutableArray *)previewDatas withPreviewFrames:(NSMutableArray *)previewImages;
- (void)showGalleryAt:(int)index;
- (void)clearDisplayImages;

@end
