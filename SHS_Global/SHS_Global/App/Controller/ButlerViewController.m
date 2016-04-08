//
//  ViewController4.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ButlerViewController.h"

@interface ButlerViewController ()

@end

@implementation ButlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CustomButton * topBtn     = [[CustomButton alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, 45)];
    topBtn.backgroundColor    = [UIColor whiteColor];
    [topBtn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];

    CustomLabel * label1      = [[CustomLabel alloc] initWithFrame:CGRectMake(15, 0, 100, 45)];
    label1.font               = [UIFont systemFontOfSize:15];
    label1.text               = @"联系管家";
    [topBtn addSubview:label1];

    CustomLabel * label2      = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-115, 0, 100, 45)];
    label2.font               = [UIFont systemFontOfSize:15];
    label2.textColor          = [UIColor colorWithHexString:@"646464"];
    label2.textAlignment      = NSTextAlignmentRight;
    label2.text               = @"4008693911";
    [topBtn addSubview:label2];
    
    UIView * line        = [[UIView alloc] initWithFrame:CGRectMake(0, topBtn.bottom-1, self.viewWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
    [self.view addSubview:line];
    
    CustomImageView * descImageView1 = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"list"]];
    descImageView1.frame             = CGRectMake(15, topBtn.bottom+25, 8, 8);
    [self.view addSubview:descImageView1];
    
    CustomLabel * descLabel1 = [[CustomLabel alloc] initWithFrame:CGRectMake(descImageView1.right+10, descImageView1.y-3, self.viewWidth-48, 0)];
    descLabel1.numberOfLines = 0;
    descLabel1.font          = [UIFont systemFontOfSize:14];
    descLabel1.text          = @"品位环球”——专为高端商务人士打造的私人尊享服务平台，提供覆盖精英生活衣食住行方方面面的专属生活服务。专业、专注、高效的为用户带来超越期待的体验和感受。";
    [self.view addSubview:descLabel1];
    [descLabel1 sizeToFit];
    
    CustomImageView * descImageView2 = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"list"]];
    descImageView2.frame             = CGRectMake(15, descLabel1.bottom+20, 8, 8);
    [self.view addSubview:descImageView2];
    
    CustomLabel * descLabel2 = [[CustomLabel alloc] initWithFrame:CGRectMake(descImageView2.right+10, descImageView2.y-3, self.viewWidth-48, 0)];
    descLabel2.numberOfLines = 0;
    descLabel2.font          = [UIFont systemFontOfSize:14];
    descLabel2.text          = @"“豪车管家”——专为中高端车辆车主提供全方位车管家服务的商务管家平台、从洗车、保养、维修、线上诊断到保险业务等，我们都将有专人为您提供服务。现已开通4008693911官方服务电话，期待您的来电。";
    [self.view addSubview:descLabel2];
    [descLabel2 sizeToFit];
    
    [self.navBar setRightBtnWithContent:nil andBlock:^{
        
    }];
    [self.navBar setRightImage:[UIImage imageNamed:@"bell"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)call:(id)sender
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
