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
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.navBar setNavTitle:@"我的爱车"];
    
    CustomLabel * topLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight+110, self.viewWidth, 15)];
    topLabel.font          = [UIFont systemFontOfSize:15];
    topLabel.textColor     = [UIColor colorWithHexString:@"646464"];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text          = @"高端车辆正在开放中，敬请期待";
    [self.view addSubview:topLabel];
    
    CustomButton * bottomBtn      = [[CustomButton alloc] initWithFrame:CGRectMake(kCenterOriginX(220), topLabel.bottom+155, 220, 45)];
    bottomBtn.backgroundColor     = [UIColor colorWithHexString:ColorWhite];
    bottomBtn.layer.cornerRadius  = 22.5;
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.borderWidth   = 1;
    bottomBtn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    bottomBtn.titleEdgeInsets     = UIEdgeInsetsMake(0, 20, 0, 0);
    bottomBtn.titleLabel.font     = [UIFont systemFontOfSize:14];
    [bottomBtn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [bottomBtn setTitle:GlobalString(@"GlobalCallBulter") forState:UIControlStateNormal];
    [bottomBtn setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
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
