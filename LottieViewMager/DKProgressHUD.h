//
//  DKProgressHUD.h
//  DKProgressHUD
//
//  Created by 庄槟豪 on 2016/10/8.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//  基于LottieViewManager的二次开发,封装最常用的方法,模仿SV提供两套最常用的样式.

#import "LottieViewManager.h"
#import "DKProgressHUDConst.h"
#import "DKCallbackMessage.h"

typedef NS_ENUM(NSInteger, DKProgressHUDStyle) {
    DKProgressHUDStyleBlack,
    DKProgressHUDStyleLight
};

typedef NS_ENUM(NSInteger, DKProgressHUDMode) {
    DKProgressHUDModeDeterminate = 1,           // 圆饼进度条
    DKProgressHUDModeDeterminateHorizontalBar,  // 水平进度条
    DKProgressHUDModeAnnularDeterminate         // 圆环进度条
};

@interface DKProgressHUD : LottieViewManager

#pragma mark - Customization

/** 
 *  HUD样式
 *  默认返回DKProgressHUDStyleBlack:黑色
 */
+ (DKProgressHUDStyle)progressHUDStyle;

/** 
 *  进度条样式
 *  默认返回DKProgressHUDModeAnnularDeterminate:圆环进度条
 */
+ (DKProgressHUDMode)progressHUDMode;

/** 
 *  HUD隐藏的时间间隔(秒)
 *  Success || Error || Info
 *  默认1.5秒后隐藏
 */
+ (CGFloat)progressHUDIntervalDismiss;

/** 
 *  HUD超时的时间间隔(秒)
 *  Loading || Progress
 *  经过返回的时间后,HUD会被隐藏
 *  默认返回MAXFLOAT,不自动隐藏
 */
+ (CGFloat)progressHUDIntervalOvertime;

/**
 *  是否启用遮罩蒙版 默认为NO
 *  如果返回YES,当HUD显示的时候会有透明的遮罩层阻挡用户点击,并且用户点击蒙版时会发出通知:DKProgressHUDDidClickedNotification
 */
+ (BOOL)useCoverMask;

#pragma mark - Show Methods

// showXxx ...          : 把HUD展示到keyWindow上. 不推荐使用
// showXxx ... toView:  : 把HUD展示到view上.      建议使用这种方法

// 在同一个view上show多次时, 默认会将view上原有的HUD隐藏, 不需要手动dismiss.

+ (instancetype)showLoading;
+ (instancetype)showLoadingToView:(UIView *)view;
+ (instancetype)showLoadingWithStatus:(NSString *)status;
+ (instancetype)showLoadingWithStatus:(NSString *)status toView:(UIView *)view;

+ (instancetype)showProgress;
+ (instancetype)showProgressToView:(UIView *)view;
+ (instancetype)showProgressWithStatus:(NSString *)status;
+ (instancetype)showProgressWithStatus:(NSString *)status toView:(UIView *)view;

+ (void)showSuccess;
+ (void)showSuccessToView:(UIView *)view;
+ (void)showSuccessWithStatus:(NSString *)status;
+ (void)showSuccessWithStatus:(NSString *)status toView:(UIView *)view;

+ (void)showError;
+ (void)showErrorToView:(UIView *)view;
+ (void)showErrorWithStatus:(NSString *)status;
+ (void)showErrorWithStatus:(NSString *)status toView:(UIView *)view;

+ (void)showInfo;
+ (void)showInfoToView:(UIView *)view;
+ (void)showInfoWithStatus:(NSString *)status;
+ (void)showInfoWithStatus:(NSString *)status toView:(UIView *)view;

/** 根据回调消息模型创建一个HUD */
+ (void)showCallbackMessage:(DKCallbackMessage *)callbackMessage;
+ (void)showCallbackMessage:(DKCallbackMessage *)callbackMessage toView:(UIView *)view;

+ (void)dismiss;
+ (void)dismissForKeyWindow;
+ (void)dismissForView:(UIView *)view;

@end
