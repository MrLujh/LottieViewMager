//
//  RootViewController.m
//  LottieViewMagerExample
//
//  Created by lujh on 2018/8/7.
//  Copyright © 2018年 Vio Wpaper. All rights reserved.
//

#import "RootViewController.h"
#import "ViewPresentController.h"
#import "NavController.h"
#import "PresentNoNavbarController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"LottieViewMager json动画";
    
    [self showLoadingView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideLoadingView];
        
    });
}
- (IBAction)presentClick:(UIButton *)sender {
    
    ViewPresentController *vc = [[ViewPresentController alloc] init];
    NavController *nav = [[NavController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)presentNoBarClick:(UIButton *)sender {
    
    PresentNoNavbarController *vc = [[PresentNoNavbarController alloc] init];
    NavController *nav = [[NavController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
