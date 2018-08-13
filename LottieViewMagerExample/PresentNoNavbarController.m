//
//  PresentNoNavbarController.m
//  LottieViewMagerExample
//
//  Created by lujh on 2018/8/13.
//  Copyright © 2018年 Vio Wpaper. All rights reserved.
//

#import "PresentNoNavbarController.h"

@interface PresentNoNavbarController ()

@end

@implementation PresentNoNavbarController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 25, 25, 25);
    [leftButton setImage:[UIImage imageNamed:@"icons8-left_4"] forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = NO;
    
    //    [leftButton setBackgroundColor:[UIColor greenColor]];
    
    [leftButton addTarget:self action:@selector(vioBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [self showLoadingView];
    
    self.view.backgroundColor = [UIColor orangeColor];
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
