//
//  MyCarsViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "MyCarsViewController.h"

@interface MyCarsViewController ()

@end

@implementation MyCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navBar setNavTitle:@"我的爱车"];
    
    CustomLabel * topLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight+20, self.viewWidth, 20)];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text          = @"高端车辆正在开放中，敬请期待";
    [self.view addSubview:topLabel];
    
    CustomButton * bottomBtn  = [[CustomButton alloc] initWithFrame:CGRectMake(0, self.viewHeight-40, self.viewWidth, 40)];
    bottomBtn.backgroundColor = [UIColor blackColor];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"一键呼叫管家" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- method resopnse
- (void)bottomPress:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008693911"]];
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
