//
//  ViewController3.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "UserViewController.h"
#import "MyCarsViewController.h"
#import "TempServerViewController.h"

@interface UserViewController ()

@property (nonatomic, strong) CustomImageView * backImageView;

@property (nonatomic, strong) CustomButton    * myCarBtn;

@property (nonatomic, strong) UIScrollView    * backScrollView;

@end

@implementation UserViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initWidget];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- layout
- (void)initWidget
{
    
    self.backScrollView = [[UIScrollView alloc] init];
    self.backImageView  = [[CustomImageView alloc] init];
    self.myCarBtn       = [[CustomButton alloc] init];
    
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.backImageView];
    [self.backScrollView addSubview:self.myCarBtn];
    
    [self.myCarBtn addTarget:self action:@selector(myCarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self configUI];
    
}

- (void)configUI
{
    
    self.backScrollView.frame                        = CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-kTabBarHeight);
    self.backScrollView.showsVerticalScrollIndicator = NO;
    self.backScrollView.backgroundColor              = [UIColor colorWithHexString:ColorBackGray];
    
    [self.backImageView setImage:[UIImage imageNamed:@"vip_bg"]];
    self.backImageView.frame       = CGRectMake(0, 0, self.viewWidth, 200);
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self drawBackImage];

    self.myCarBtn.backgroundColor            = [UIColor whiteColor];
    self.myCarBtn.frame                      = CGRectMake(0, self.backImageView.bottom, self.viewWidth, 50);
    self.myCarBtn.titleEdgeInsets            = UIEdgeInsetsMake(0, 10, 0, 0);
    self.myCarBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, self.viewWidth-25, 0, 0);
    self.myCarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.myCarBtn.titleLabel.font            = [UIFont systemFontOfSize:15];
    [self.myCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myCarBtn setTitle:GlobalString(@"UserMyCar") forState:UIControlStateNormal];
    [self.myCarBtn setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];

    UIView * line        = [[UIView alloc] initWithFrame:CGRectMake(0, self.myCarBtn.height-1, self.viewWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
    [self.myCarBtn addSubview:line];
    
    CustomButton * membership             = [[CustomButton alloc] initWithFrame:CGRectMake(0, self.myCarBtn.bottom, self.viewWidth, 50)];
    membership.backgroundColor            = [UIColor whiteColor];
    membership.titleEdgeInsets            = UIEdgeInsetsMake(0, 10, 0, 0);
    membership.imageEdgeInsets            = UIEdgeInsetsMake(0, self.viewWidth-25, 0, 0);
    membership.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    membership.titleLabel.font            = [UIFont systemFontOfSize:15];
    [membership setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [membership setTitle:GlobalString(@"UserPresent") forState:UIControlStateNormal];
    [membership setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    [membership addTarget:self action:@selector(membershipPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.backScrollView addSubview:membership];
    
    UIView * line2        = [[UIView alloc] initWithFrame:CGRectMake(0, membership.height-1, self.viewWidth, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
    [membership addSubview:line2];
}

#pragma mark- method response

- (void)myCarPress:(id)sender
{
    MyCarsViewController * mcvc = [[MyCarsViewController alloc] init];
    [self pushVC:mcvc];
}

- (void)membershipPress:(id)sender
{
    TempServerViewController * tsvc = [[TempServerViewController alloc] init];
    tsvc.type                       = 3;
    [self pushVC:tsvc];
}

#pragma mark- private method
- (CGFloat)generateCommonListWithTop:(CGFloat)top andContent:(NSString *)content
{
    CustomImageView * descImageView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"list"]];
    descImageView.frame             = CGRectMake(15, top, 8, 8);
    [self.backScrollView addSubview:descImageView];
    
    CustomLabel * descLabel1 = [[CustomLabel alloc] initWithFrame:CGRectMake(descImageView.right+10, descImageView.y-3, self.viewWidth-48, 0)];
    descLabel1.numberOfLines = 0;
    descLabel1.font          = [UIFont systemFontOfSize:14];
    descLabel1.text          = content;
    [self.backScrollView addSubview:descLabel1];
    [descLabel1 sizeToFit];
    
    return descLabel1.bottom;
}

- (void)drawBackImage {
    
    CustomImageView * logoImageView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"vip_logo"]];
    logoImageView.frame = CGRectMake(kCenterOriginX(69), 15, 69, 69);

    CustomLabel * label1 = [[CustomLabel alloc] initWithFontSize:13];
    label1.frame         = CGRectMake(0, logoImageView.bottom+15, self.backImageView.width, 13);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor     = [UIColor colorWithHexString:@"D1B372"];
    label1.text          = @"品位环球--豪车管家 ● VIP";

    CustomLabel * label2 = [[CustomLabel alloc] initWithFontSize:12];
    label2.frame         = CGRectMake(0, label1.bottom+15, self.backImageView.width, 12);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor     = [UIColor colorWithHexString:@"D1B372"];
    label2.text          = @"您的私人豪车管家";
    
    CustomLabel * label3 = [[CustomLabel alloc] initWithFontSize:11];
    label3.frame         = CGRectMake(0, self.backImageView.height-27, self.backImageView.width, 11);
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor     = [UIColor colorWithHexString:@"D1B372"];
    label3.text          = @"详情请致电管家：400-8693-911";

    [self.backImageView addSubview:label1];
    [self.backImageView addSubview:label2];
    [self.backImageView addSubview:label3];
    [self.backImageView addSubview:logoImageView];
    
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
