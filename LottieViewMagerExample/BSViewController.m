//
//  BSViewController.m
//  LottieViewMagerExample
//
//  Created by lujh on 2018/8/7.
//  Copyright © 2018年 Vio Wpaper. All rights reserved.
//

#import "BSViewController.h"
#import "LottieViewManager.h"
@interface BSViewController ()
@property (nonatomic,strong) LottieViewManager *hud;
@end

@implementation BSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)showLoadingView
{
    LottieViewManager *hud = [LottieViewManager showHUDAddedTo:self.navigationController.view animated:YES animationJson:@"vio"];
    self.hud = hud;
}

- (void)hideLoadingView
{
    [self.hud removeFromSuperview];
    self.hud = nil;
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
