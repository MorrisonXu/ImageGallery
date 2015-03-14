//
//  ViewController.h
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDPreviewData.h"
#import "JDPreviewImage.h"
#import "JDDisplayGallery.h"

@interface ViewController : UIViewController <JDPreviewImageDelegate> {
    NSMutableArray *_previewDatas;
    NSMutableArray *_previewImages;
    JDDisplayGallery *_gallery;
    
    
    UIImageView *iv;
}

@end

