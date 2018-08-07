//
//  DKProgressHUD+CustomView.h
//  TaiHealthy
//
//  Created by limai on 2017/7/20.
//  Copyright © 2017年 taiKang. All rights reserved.
//

#import "DKProgressHUD.h"

typedef NS_ENUM(NSInteger, DKProgressHUDGifImageType) {
    DKProgressHUDGifImageTypeLoading,
    DKProgressHUDGifImageTypeUploading
};

@interface DKProgressHUD (CustomView)

+ (instancetype)showLoadingGifImage;
+ (instancetype)showLoadingGifImageToView:(UIView *)view;
+ (instancetype)showLoadingGifImageWithMessage:(NSString *)message;
+ (instancetype)showLoadingGifImageWithMessage:(NSString *)message toView:(UIView *)view;

+ (instancetype)showUploadingGifImage;
+ (instancetype)showUploadingGifImageToView:(UIView *)view;
+ (instancetype)showUploadingGifImageWithMessage:(NSString *)message;
+ (instancetype)showUploadingGifImageWithMessage:(NSString *)message toView:(UIView *)view;

+ (instancetype)showGifImageWithName:(NSString *)name;
+ (instancetype)showGifImageWithName:(NSString *)name toView:(UIView *)view;
+ (instancetype)showGifImageWithName:(NSString *)name withMessage:(NSString *)message;
+ (instancetype)showGifImageWithName:(NSString *)name withMessage:(NSString *)message toView:(UIView *)view;

+ (instancetype)showCustomView:(UIView *)customView;
+ (instancetype)showCustomView:(UIView *)customView toView:(UIView *)view;
+ (instancetype)showCustomView:(UIView *)customView withMessage:(NSString *)message;
+ (instancetype)showCustomView:(UIView *)customView withMessage:(NSString *)message toView:(UIView *)view;
+ (instancetype)showCustomView:(UIView *)customView withMessage:(NSString *)message toView:(UIView *)view hideTime:(NSTimeInterval)hideTime;
@end
