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
    // Dispose of any resources that can be recreated.
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
    
    [self.backImageView setImage:[UIImage imageNamed:@"global_back"]];
    self.backImageView.frame       = CGRectMake(0, 0, self.viewWidth, 170);
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
