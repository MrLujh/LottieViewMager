//
//  ViewPresentController.m
//  LottieViewMagerExample
//
//  Created by lujh on 2018/8/13.
//  Copyright © 2018年 Vio Wpaper. All rights reserved.
//

#import "ViewPresentController.h"

@interface ViewPresentController ()

@end

@implementation ViewPresentController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"带导航栏";
    
    UIBarButtonItem *vioBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icons8-left_4"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(vioBtn)];
    vioBtn.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = vioBtn;
    
    [self showLoadingView];
    
    self.view.backgroundColor = [UIColor greenColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideLoadingView];
        
    });
}
- (void)vioBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
