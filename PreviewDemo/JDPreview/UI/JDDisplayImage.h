//
//  JDDisplayImage.h
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDPreviewData.h"

@protocol JDDisplayImageDelegate <NSObject>

- (void)displayImageTappedWithObject:(id)sender;

@end

@interface JDDisplayImage : UIScrollView <UIScrollViewDelegate> {
    UIImageView *_ivDisplay;
    
    // 记录图片缩放的Frame
    CGRect _frameDisplay;
    // 图片Display初始状态(zoom = 1.0)的Size
    // 用于调整缩放比例
    CGSize _sizeOrigin;
    // Preview时的Frame
    CGRect _framePreview;
}

@property (nonatomic, strong)id<JDDisplayImageDelegate> displayDelegate;

- (void)setPreviewFrame:(CGRect)framePreview;
- (void)setImageData:(JDPreviewData *)previewData withType:(DisplayType)type withCache:(BOOL)toCache;
- (void)setAnimationFrame;
- (void)resetFrame;

@end
