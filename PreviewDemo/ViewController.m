//
//  ViewController.m
//  PreviewDemo
//
//  Created by 徐佳俊 on 15/3/4.
//  Copyright (c) 2015年 morrison. All rights reserved.
//

#import "ViewController.h"
#import "JDPreviewData.h"
#import "JDPreviewImage.h"

#import <UIImageView+AFNetworking.h>

@interface ViewController ()

- (void)initPreviewDatas;
- (void)createGallery;
- (void)createPreviews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
//    bt.frame = CGRectMake(0, 400, 100, 100);
//    [bt setBackgroundColor:[UIColor redColor]];
//    [bt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bt];
//    iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 200, 200)];
////    [iv setImageWithURL:[NSURL URLWithString:@"http://img3.douban.com/view/photo/thumb/public/p362707795.jpg"]];
//    [self.view addSubview:iv];
//    return;
    
    
    
    
    [self initPreviewDatas];
    [self createPreviews];
    [self createGallery];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)click {
    
    [iv setImageWithURL:[NSURL URLWithString:@"http://img3.douban.com/view/photo/thumb/public/p362707795.jpg"]];
    
    NSLog(@"%@", iv.image);
}

#pragma mark - 

- (void)initPreviewDatas {
    _previewDatas = [[NSMutableArray alloc] init];
    
    JDPreviewData *zero = [[JDPreviewData alloc] init];
//    [zero initWithURLBlur:@"http://img3.douban.com/view/photo/thumb/public/p362707795.jpg"
//                   URLHD:@"http://img3.douban.com/view/photo/photo/public/p362707795.jpg"
//                pathBlur:@"/var/mobile/Containers/Data/Application/523ED23C-67EC-4972-BA61-C5830A12D173/Library/Caches/photo/1422256253555"
//                  pathHD:@"/var/mobile/Containers/Data/Application/523ED23C-67EC-4972-BA61-C5830A12D173/Library/Caches/photo/1422256253555"];
    [zero initWithURLBlur:@"http://img3.douban.com/view/photo/thumb/public/p362707795.jpg"
                    URLHD:@"http://image.baidu.com/detail/newindex?col=壁纸&tag=全部&tag3=&filter=&hasstock=&dresstype=&dressid=-1&req=&pn=4&pid=14955649614&aid=401725956&setid=-1&user_id=580725873&sort=0&width=1920&height=1200&fr=&from=1"
                 pathBlur:@"/var/mobile/Containers/Data/Application/523ED23C-67EC-4972-BA61-C5830A12D173/Library/Caches/photo/1422256253555"
                   pathHD:@"/var/mobile/Containers/Data/Application/523ED23C-67EC-4972-BA61-C5830A12D173/Library/Caches/photo/1422256253555"];
    [_previewDatas addObject:zero];
    
    JDPreviewData *one = [[JDPreviewData alloc] init];
    [one initWithURLBlur:@"http://img3.douban.com/view/photo/thumb/public/p362708421.jpg"
                   URLHD:@"http://img3.douban.com/view/photo/photo/public/p362708421.jpg"
                pathBlur:@"/var/mobile/Containers/Data/Application/523ED23C-67EC-4972-BA61-C5830A12D173/Library/Caches/photo/1422256253556"
                  pathHD:@"/var/mobile/Containers/Data/Application/523ED23C-67EC-4972-BA61-C5830A12D173/Library/Caches/photo/1422256253556"];
    [_previewDatas addObject:one];
}

- (void)createGallery {
    _gallery = [[JDDisplayGallery alloc] initWithFrame:self.view.frame];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:_gallery];
    [self.view addSubview:_gallery];
}

- (void)createPreviews {
    _previewImages = [[NSMutableArray alloc] init];
    
    JDPreviewImage *preview0 = [[JDPreviewImage alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.0)];
    [preview0 setImageData:_previewDatas[0] withCache:YES];
    preview0.tag = 0;
    preview0.previewDelegate = self;
    [_previewImages addObject:preview0];
    
    JDPreviewImage *preview1 = [[JDPreviewImage alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2.0, self.view.frame.size.width, self.view.frame.size.height / 2.0)];
    [preview1 setImageData:_previewDatas[1] withCache:YES];
    preview1.tag = 1;
    preview1.previewDelegate = self;
    [_previewImages addObject:preview1];
    
    [self.view addSubview:preview0];
    [self.view addSubview:preview1];
}

#pragma mark - JDPreviewImageDelegate

- (void)previewImageTappedWithObject:(id)sender {
    JDPreviewImage *preview = sender;
//    CGPoint contentOffset = _gallery.contentOffset;
//    contentOffset.x = preview.tag * self.view.frame.size.width;
//    _gallery.contentOffset = contentOffset;
    
    [_gallery addDisplayImages:_previewDatas withPreviewFrames:_previewImages];
    
    [_gallery showGalleryAt:(int)preview.tag];
}

@end
