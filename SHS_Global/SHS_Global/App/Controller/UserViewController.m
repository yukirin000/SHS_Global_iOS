//
//  ViewController3.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "UserViewController.h"
#import "MyCarsViewController.h"

@interface UserViewController ()

@property (nonatomic, strong) CustomImageView  * backImageView;

@property (nonatomic, strong) CustomButton * myCarBtn;

@end

@implementation UserViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initWidget];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout
- (void)initWidget
{
    self.backImageView = [[CustomImageView alloc] init];
    self.myCarBtn      = [[CustomButton alloc] init];
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.myCarBtn];
    
    [self configUI];
}

- (void)configUI
{
    self.view.backgroundColor                = [UIColor lightGrayColor];

    self.backImageView.backgroundColor       = [UIColor greenColor];
    self.backImageView.frame                 = CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, 150);

    self.myCarBtn.backgroundColor            = [UIColor whiteColor];
    self.myCarBtn.frame                      = CGRectMake(0, self.backImageView.bottom+10, self.viewWidth, 40);
    self.myCarBtn.titleEdgeInsets            = UIEdgeInsetsMake(0, 10, 0, 0);
    self.myCarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.myCarBtn addTarget:self action:@selector(myCarPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myCarBtn setTitle:@"我的爱车" forState:UIControlStateNormal];
    
    CustomLabel * descLabel1 = [[CustomLabel alloc] initWithFrame:CGRectMake(5, self.myCarBtn.bottom+10, self.viewWidth-10, 0)];
    descLabel1.numberOfLines = 0;
    descLabel1.font          = [UIFont systemFontOfSize:14];
    descLabel1.text          = @"注册成为“品味•环球”尊贵的会员，您将享有平台内所有联盟商家提供的会员VIP礼遇，无需另外办理门店会员卡。";
    [self.view addSubview:descLabel1];
    [descLabel1 sizeToFit];
    
    CustomLabel * descLabel2 = [[CustomLabel alloc] initWithFrame:CGRectMake(5, descLabel1.bottom+10, self.viewWidth-10, 0)];
    descLabel2.numberOfLines = 0;
    descLabel2.font          = [UIFont systemFontOfSize:14];
    descLabel2.text          = @"豪车管家24小时电话问诊及资讯，专业的豪车管家将为您提供一切关于您爱车的最佳解决方案。";
    [self.view addSubview:descLabel2];
    [descLabel2 sizeToFit];
    
    CustomLabel * descLabel3 = [[CustomLabel alloc] initWithFrame:CGRectMake(5, descLabel2.bottom+10, self.viewWidth-10, 0)];
    descLabel3.numberOfLines = 0;
    descLabel3.font          = [UIFont systemFontOfSize:14];
    descLabel3.text          = @"会员卡价格享受爱车精洗项目，无需再办理门店会员卡。此礼遇适用于全平台联盟商家。";
    [self.view addSubview:descLabel3];
    [descLabel3 sizeToFit];
    
    CustomLabel * descLabel4 = [[CustomLabel alloc] initWithFrame:CGRectMake(5, descLabel3.bottom+10, self.viewWidth-10, 0)];
    descLabel4.numberOfLines = 0;
    descLabel4.font          = [UIFont systemFontOfSize:14];
    descLabel4.text          = @"豪车维修与保养将由专业的豪车管家为您一站式打理，轻松，高效的完成每一个环节。";
    [self.view addSubview:descLabel4];
    [descLabel4 sizeToFit];
    
}

#pragma mark- method response

- (void)myCarPress:(id)sender
{
    MyCarsViewController * mcvc = [[MyCarsViewController alloc] init];
    [self pushVC:mcvc];
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
