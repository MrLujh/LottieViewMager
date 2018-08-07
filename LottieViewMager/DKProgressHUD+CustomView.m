//
//  DKProgressHUD+CustomView.m
//  TaiHealthy
//
//  Created by limai on 2017/7/20.
//  Copyright © 2017年 taiKang. All rights reserved.
//

#import "DKProgressHUD+CustomView.h"
#import <ImageIO/ImageIO.h>

@implementation DKProgressHUD (CustomView)

+ (UIImage *)animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    for (NSInteger i = scale; i > 0; i--) {
        NSString *pre = [NSString stringWithFormat:@"@%ldx", (long)i];
        if (i == 1) {
            pre = @"";
        }
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:pre] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [self animatedGIFWithData:data];
        }
    }
    
    return [UIImage imageNamed:name];
}

+ (UIImage *)animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
//            duration = (1.0f / 10.0f) * count;
            duration = 0.04 * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

+ (instancetype)showLoadingGifImage {
    return [self showLoadingGifImageToView:nil];
}

+ (instancetype)showLoadingGifImageToView:(UIView *)view {
    return [self showLoadingGifImageWithMessage:nil toView:view];
}

+ (instancetype)showLoadingGifImageWithMessage:(NSString *)message {
    return [self showLoadingGifImageWithMessage:message toView:nil];
}

//+ (instancetype)showLoadingGifImageWithMessage:(NSString *)message toView:(UIView *)view {
//    return [self showGifImageWithName:@"gif_loading" withMessage:message toView:view];
//}

+ (instancetype)showLoadingGifImageWithMessage:(NSString *)message toView:(UIView *)view {
    
    NSMutableArray<NSString *> *images = [NSMutableArray new];
    for (int i = 1; i < 3; i++) {
        [images addObject:[NSString stringWithFormat:@"loding-%d",i]];
    }
    return [self showGifImageWithNames:images withMessage:message toView:view];
//    return [self showGifImageWithName:@"gif_loading" withMessage:message toView:view];
}

+ (instancetype)showUploadingGifImage {
    return [self showUploadingGifImageToView:nil];
}

+ (instancetype)showUploadingGifImageToView:(UIView *)view {
    return [self showUploadingGifImageWithMessage:nil toView:view];
}

+ (instancetype)showUploadingGifImageWithMessage:(NSString *)message {
    return [self showUploadingGifImageWithMessage:message toView:nil];
}

+ (instancetype)showUploadingGifImageWithMessage:(NSString *)message toView:(UIView *)view {
    return [self showGifImageWithName:@"gif_uploading" withMessage:message toView:view];
}

+ (instancetype)showGifImageWithName:(NSString *)name {
    return [self showGifImageWithName:name toView:nil];
}

+ (instancetype)showGifImageWithName:(NSString *)name toView:(UIView *)view {
    return [self showGifImageWithName:name withMessage:nil toView:view];
}

+ (instancetype)showGifImageWithName:(NSString *)name withMessage:(NSString *)message {
    return [self showGifImageWithName:name withMessage:message toView:nil];
}

+ (instancetype)showGifImageWithImage:(UIImage *)image withMessage:(NSString *)message toView:(UIView *)view {
//    UIImage *image = [self animatedGIFNamed:name];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    [self dismissForView:view];
    
    view = view ? view : [[UIApplication sharedApplication].windows firstObject];
    
    DKProgressHUD *hud = [self showHUDAddedTo:view animated:YES animationJson:nil];
    //    hud.minSize = CGSizeMake(50, 135);
    hud.margin = 0;
    hud.mode = LottieViewManagerModeCustomView;
#if 1
    //    hud.bezelView.color = [UIColor colorWithHex:0x00A5F2 alpha:0.07];
    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.style = LottieViewManagerBackgroundStyleSolidColor;
    //    hud.bezelView.color = [UIColor colorWithHex:0x00A5F2 alpha:0.07];
    //    hud.bezelView.color = BACKGROUNDCOLOR;
    hud.contentColor = [UIColor clearColor];
#else
    hud.bezelView.color = [UIColor clearColor];
    hud.contentColor = [UIColor clearColor];
    hud.backgroundView.style = LottieViewManagerBackgroundStyleSolidColor;
    hud.bezelView.style = LottieViewManagerBackgroundStyleSolidColor;
#endif
    hud.detailsLabel.text = message;
    hud.userInteractionEnabled = YES;
    
    hud.customView = imageView;
    
    [hud hideAnimated:YES afterDelay:[self progressHUDIntervalOvertime]];
    
    return hud;
}

+ (instancetype)showGifImageWithNames:(NSArray<NSString *> *)names withMessage:(NSString *)message toView:(UIView *)view{
    NSMutableArray<UIImage *> *images = [NSMutableArray new];
    for (NSString *name in names) {
        UIImage *image = [UIImage imageNamed:name];
        if (image) {
            [images addObject:image];
        }
    }
    if (images.count) {
        NSTimeInterval duration = 1.0f;
        
        UIImage *animatedImage = [UIImage animatedImageWithImages:images duration:duration];
        return [self showGifImageWithImage:animatedImage withMessage:message toView:view];
    }
    return nil;
}

+ (instancetype)showGifImageWithName:(NSString *)name withMessage:(NSString *)message toView:(UIView *)view {
    UIImage *image = [self animatedGIFNamed:name];
    
    return [self showGifImageWithImage:image withMessage:message toView:view];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//
//    [self dismissForView:view];
//
//    view = view ? view : [[UIApplication sharedApplication].windows firstObject];
//
//    DKProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
////    hud.minSize = CGSizeMake(50, 135);
//    hud.margin = 0;
//    hud.mode = LottieViewManagerModeCustomView;
//#if 1
////    hud.bezelView.color = [UIColor colorWithHex:0x00A5F2 alpha:0.07];
//    hud.bezelView.color = [UIColor clearColor];
//    hud.bezelView.style = LottieViewManagerBackgroundStyleSolidColor;
////    hud.bezelView.color = [UIColor colorWithHex:0x00A5F2 alpha:0.07];
////    hud.bezelView.color = BACKGROUNDCOLOR;
//    hud.contentColor = [UIColor colorWithHex:0x00A5F2 alpha:0.07];
//#else
//    hud.bezelView.color = [UIColor clearColor];
//    hud.contentColor = [UIColor clearColor];
//    hud.backgroundView.style = LottieViewManagerBackgroundStyleSolidColor;
//    hud.bezelView.style = LottieViewManagerBackgroundStyleSolidColor;
//#endif
//    hud.detailsLabel.text = message;
//    hud.userInteractionEnabled = YES;
//
//    hud.customView = imageView;
//
//    [hud hideAnimated:YES afterDelay:[self progressHUDIntervalOvertime]];
//
//    return hud;
}

+ (instancetype)showCustomView:(UIView *)customView {
    return [self showCustomView:customView toView:nil];
}

+ (instancetype)showCustomView:(UIView *)customView toView:(UIView *)view {
    return [self showCustomView:customView withMessage:nil toView:view];
}

+ (instancetype)showCustomView:(UIView *)customView withMessage:(NSString *)message {
    return [self showCustomView:customView withMessage:message toView:nil];
}

+ (instancetype)showCustomView:(UIView *)customView withMessage:(NSString *)message toView:(UIView *)view {
    return [self showCustomView:customView withMessage:message toView:view hideTime:[self progressHUDIntervalDismiss]];
}

+ (instancetype)showCustomView:(UIView *)customView withMessage:(NSString *)message toView:(UIView *)view hideTime:(NSTimeInterval)hideTime {
    [self dismissForView:view];
    
    view = view ? view : [[UIApplication sharedApplication].windows firstObject];
    
    DKProgressHUD *hud = [self showHUDAddedTo:view animated:YES animationJson:nil];
    hud.mode = LottieViewManagerModeCustomView;
    if ([self progressHUDStyle] == DKProgressHUDStyleBlack) {
        hud.bezelView.color = [UIColor blackColor];
        hud.contentColor = [UIColor whiteColor];
    } else {
        hud.bezelView.color = [UIColor whiteColor];
        hud.contentColor = [UIColor blackColor];
    }
    hud.detailsLabel.text = message;
    hud.userInteractionEnabled = (hideTime >= [self progressHUDIntervalOvertime]);
    
    hud.customView = customView;
    
    [hud hideAnimated:YES afterDelay:hideTime];
    
    return hud;
}

@end
