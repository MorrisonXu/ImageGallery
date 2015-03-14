//
//  JDPreviewImage.h
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDPreviewData.h"

@protocol JDPreviewImageDelegate <NSObject>

- (void)previewImageTappedWithObject:(id)sender;

@end

@interface JDPreviewImage : UIImageView

@property (nonatomic, strong)id<JDPreviewImageDelegate> previewDelegate;

- (void)setImageData:(JDPreviewData *)previewData withCache:(BOOL)toCache;

@end
