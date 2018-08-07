//
//  DKProgressHUD.m
//  DKProgressHUD
//
//  Created by 庄槟豪 on 2016/10/8.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKProgressHUD.h"

@implementation DKProgressHUD

#pragma mark - Customization

+ (DKProgressHUDStyle)progressHUDStyle
{
    return DKProgressHUDStyleBlack;
}

+ (DKProgressHUDMode)progressHUDMode
{
    return DKProgressHUDModeDeterminate;
}

+ (CGFloat)progressHUDIntervalDismiss
{
    return 1.5;
}

+ (CGFloat)progressHUDIntervalOvertime
{
    return MAXFLOAT;
}

+ (BOOL)useCoverMask
{
    return YES;
}

#pragma mark - Getter && Setter

+ (UIColor *)tintColor
{
    return [self progressHUDStyle] == DKProgressHUDStyleBlack ? [UIColor whiteColor] : [UIColor blackColor];
}

+ (UIColor *)backgroundColor
{
    return [self progressHUDStyle] == DKProgressHUDStyleBlack ? [UIColor blackColor] : [UIColor whiteColor];
}

#pragma mark - Show Methods

/**** Loading ****/

+ (instancetype)showLoading
{
    return [self showLoadingToView:nil];
}

+ (instancetype)showLoadingToView:(UIView *)view
{
    [self dismissForView:view];
    
    view = view ? view : [[UIApplication sharedApplication].windows firstObject];
    
    DKProgressHUD *hud = [self showHUDAddedTo:view animated:YES animationJson:nil];
    hud.bezelView.color = [self backgroundColor];
    hud.bezelView.layer.backgroundColor = [[self backgroundColor] CGColor];
    hud.contentColor = [self tintColor];
    hud.userInteractionEnabled = [self useCoverMask];
    
    [hud hideAnimated:YES afterDelay:[self progressHUDIntervalOvertime]];
    
    return hud;
}

+ (instancetype)showLoadingWithStatus:(NSString *)status
{
    return [self showLoadingWithStatus:status toView:nil];
}

+ (instancetype)showLoadingWithStatus:(NSString *)status toView:(UIView *)view
{
    DKProgressHUD *hud = [self showLoadingToView:view];
    hud.label.text = status;
    
    return hud;
}

/**** Progress ****/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wenum-conversion"
+ (instancetype)showProgress
{
    DKProgressHUD *hud = [self showLoading];
    hud.mode = [self progressHUDMode];
    return hud;
}

+ (instancetype)showProgressToView:(UIView *)view
{
    DKProgressHUD *hud = [self showLoadingToView:view];
    hud.mode = [self progressHUDMode];
    
    return hud;
}

+ (instancetype)showProgressWithStatus:(NSString *)status
{
    DKProgressHUD *hud = [self showLoadingWithStatus:status];
    hud.mode = [self progressHUDMode];
    
    return hud;
}

+ (instancetype)showProgressWithStatus:(NSString *)status toView:(UIView *)view
{
    DKProgressHUD *hud = [self showLoadingWithStatus:status toView:view];
    hud.mode = [self progressHUDMode];
    
    return hud;
}
#pragma clang diagnostic pop

/**** Success ****/

+ (void)showSuccess
{
    [self showSuccessToView:nil];
}

+ (void)showSuccessToView:(UIView *)view
{
    [self showStatus:nil statusImage:DKProgressHUDSuccessImageName view:view];
}

+ (void)showSuccessWithStatus:(NSString *)status
{
    [self showSuccessWithStatus:status toView:nil];
}

+ (void)showSuccessWithStatus:(NSString *)status toView:(UIView *)view
{
    [self showStatus:status statusImage:DKProgressHUDSuccessImageName view:view];
}

/**** Error ****/

+ (void)showError
{
    [self showErrorToView:nil];
}

+ (void)showErrorToView:(UIView *)view
{
    [self showStatus:nil statusImage:DKProgressHUDErrorImageName view:view];
}

+ (void)showErrorWithStatus:(NSString *)status
{
    [self showErrorWithStatus:status toView:nil];
}

+ (void)showErrorWithStatus:(NSString *)status toView:(UIView *)view
{
    [self showStatus:status statusImage:DKProgressHUDErrorImageName view:view];
}

/**** Info ****/

+ (void)showInfo
{
    [self showInfoToView:nil];
}

+ (void)showInfoToView:(UIView *)view
{
    [self showStatus:nil statusImage:DKProgressHUDInfoImageName view:view];
}

+ (void)showInfoWithStatus:(NSString *)status
{
    return [self showInfoWithStatus:status toView:nil];
}

+ (void)showInfoWithStatus:(NSString *)status toView:(UIView *)view
{
    [self showStatus:status statusImage:DKProgressHUDInfoImageName view:view];
}

/**** Callback ****/

+ (void)showCallbackMessage:(DKCallbackMessage *)callbackMessage
{
    if (callbackMessage.successMessage.length) {
        [self showSuccessWithStatus:callbackMessage.successMessage];
    } else if (callbackMessage.infoMessage.length) {
        [self showInfoWithStatus:callbackMessage.infoMessage];
    } else if (callbackMessage.errorMessage.length) {
        [self showErrorWithStatus:callbackMessage.errorMessage];
    } else if (callbackMessage.loadingMessage.length) {
        [self showLoadingWithStatus:callbackMessage.loadingMessage];
    } else if (callbackMessage.progressMessage.length) {
        [self showProgressWithStatus:callbackMessage.progressMessage];
    } else if (callbackMessage.dismiss) {
        [self dismissForKeyWindow];
    }
}

+ (void)showCallbackMessage:(DKCallbackMessage *)callbackMessage toView:(UIView *)view
{
    if (callbackMessage.successMessage.length) {
        [self showSuccessWithStatus:callbackMessage.successMessage toView:view];
    } else if (callbackMessage.infoMessage.length) {
        [self showInfoWithStatus:callbackMessage.infoMessage toView:view];
    } else if (callbackMessage.errorMessage.length) {
        [self showErrorWithStatus:callbackMessage.errorMessage toView:view];
    } else if (callbackMessage.loadingMessage.length) {
        [self showLoadingWithStatus:callbackMessage.loadingMessage toView:view];
    } else if (callbackMessage.progressMessage.length) {
        [self showProgressWithStatus:callbackMessage.progressMessage toView:view];
    } else if (callbackMessage.dismiss) {
        [self dismissForView:view];
    }
}

/**** Dismiss ****/

+ (void)dismiss
{
    [self dismissForKeyWindow];
    
    [self dismissForView:nil];
}

+ (void)dismissForKeyWindow
{
    UIView *keyWindow = [[UIApplication sharedApplication].windows firstObject];
    [self hideHUDForView:keyWindow animated:YES];
}

+ (void)dismissForView:(UIView *)view
{
    if (view) [self hideHUDForView:view animated:YES];
}

#pragma mark - Private Method

+ (void)showStatus:(NSString *)status statusImage:(NSString *)statusImage view:(UIView *)view
{
    [self dismissForView:view];
    
    view = view ? view : [[UIApplication sharedApplication].windows firstObject];
    
    DKProgressHUD *hud = [self showHUDAddedTo:view animated:YES animationJson:nil];
    hud.mode = LottieViewManagerModeCustomView;
    hud.bezelView.color = [self backgroundColor];
    hud.label.text = status;
    hud.contentColor = [self tintColor];
    hud.userInteractionEnabled = [self useCoverMask];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:DKProgressHUDBundleName withExtension:nil];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *statusImg = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:statusImage ofType:nil]];
    if ([self progressHUDStyle] == DKProgressHUDStyleBlack) {
        statusImg = [statusImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    hud.customView = [[UIImageView alloc] initWithImage:statusImg];
    
    [hud hideAnimated:YES afterDelay:[self progressHUDIntervalDismiss]];
}

#pragma mark - Events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DKProgressHUDDidClickedNotification object:nil];
}

@end
