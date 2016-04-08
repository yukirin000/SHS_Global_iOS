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
    
    [self.myCarBtn addTarget:self action:@selector(myCarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self configUI];
    
    
}

- (void)configUI
{
    [self.backImageView setImage:[UIImage imageNamed:@"global_back"]];
    self.backImageView.frame       = CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, 170);
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;

    self.myCarBtn.backgroundColor            = [UIColor whiteColor];
    self.myCarBtn.frame                      = CGRectMake(0, self.backImageView.bottom, self.viewWidth, 50);
    self.myCarBtn.titleEdgeInsets            = UIEdgeInsetsMake(0, 10, 0, 0);
    self.myCarBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, self.viewWidth-25, 0, 0);
    self.myCarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.myCarBtn.titleLabel.font            = [UIFont systemFontOfSize:15];
    [self.myCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myCarBtn setTitle:@"我的爱车" forState:UIControlStateNormal];
    [self.myCarBtn setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    
    UIView * line        = [[UIView alloc] initWithFrame:CGRectMake(0, self.myCarBtn.height-1, self.viewWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
    [self.myCarBtn addSubview:line];
    
    CGFloat bottom1 = [self generateCommonListWithTop:self.myCarBtn.bottom+25 andContent:@"注册成为“品味•环球”尊贵的会员，您将享有平台内所有联盟商家提供的会员VIP礼遇，无需另外办理门店会员卡。"];
    CGFloat bottom2 = [self generateCommonListWithTop:bottom1+20 andContent:@"豪车管家24小时电话问诊及资讯，专业的豪车管家将为您提供一切关于您爱车的最佳解决方案。"];
    CGFloat bottom3 = [self generateCommonListWithTop:bottom2+20 andContent:@"会员卡价格享受爱车精洗项目，无需再办理门店会员卡。此礼遇适用于全平台联盟商家。"];
    [self generateCommonListWithTop:bottom3+20 andContent:@"豪车维修与保养将由专业的豪车管家为您一站式打理，轻松，高效的完成每一个环节。"];
}

#pragma mark- method response

- (void)myCarPress:(id)sender
{
    MyCarsViewController * mcvc = [[MyCarsViewController alloc] init];
    [self pushVC:mcvc];
}

#pragma mark- private method
- (CGFloat)generateCommonListWithTop:(CGFloat)top andContent:(NSString *)content
{
    CustomImageView * descImageView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"list"]];
    descImageView.frame             = CGRectMake(15, top, 8, 8);
    [self.view addSubview:descImageView];
    
    CustomLabel * descLabel1 = [[CustomLabel alloc] initWithFrame:CGRectMake(descImageView.right+10, descImageView.y-3, self.viewWidth-48, 0)];
    descLabel1.numberOfLines = 0;
    descLabel1.font          = [UIFont systemFontOfSize:14];
    descLabel1.text          = content;
    [self.view addSubview:descLabel1];
    [descLabel1 sizeToFit];
    
    return descLabel1.bottom;
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
