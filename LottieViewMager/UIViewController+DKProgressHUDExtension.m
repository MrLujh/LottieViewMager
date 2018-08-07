//
//  UIViewController+DKProgressHUDExtension.m
//  DKProgressHUD
//
//  Created by 庄槟豪 on 2016/10/22.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "UIViewController+DKProgressHUDExtension.h"
#import <objc/runtime.h>
#import "DKProgressHUD.h"

@implementation UIViewController (DKProgressHUDExtension)

+ (void)load
{
    Method didDisappearMethod = class_getInstanceMethod([self class], @selector(viewDidDisappear:));
    Method dkDidDisappearMethod = class_getInstanceMethod(self, @selector(dk_viewDidDisappear:));
    
    method_exchangeImplementations(didDisappearMethod, dkDidDisappearMethod);
}

- (void)dk_viewDidDisappear:(BOOL)animated
{
    [DKProgressHUD dismissForView:self.view];
    
    [self dk_viewDidDisappear:animated];
}


@end
