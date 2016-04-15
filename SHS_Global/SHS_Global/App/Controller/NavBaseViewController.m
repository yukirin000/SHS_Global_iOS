//
//  NavBaseViewController.m
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/19.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"

@interface NavBaseViewController ()

@end

@implementation NavBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navBar = [[NavBar alloc] init];        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBase];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)initNavBase
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //创建导航栏
    [self createNavBar];
    //设置返回按钮
    [self setBackBtn];
    //处理原始的navBar
    [self handleOriginNavBar];
    
    if (self.hideNavbar == YES) {
        
        self.navigationController.navigationBarHidden = YES;
        //隐藏导航栏
        self.navBar.hidden = YES;
        
    }else if (self.hideLeftBtn == YES){
        //隐藏左边按钮
        self.navBar.leftBtn.hidden = YES;
    }
}

- (void)createNavBar
{
    [self.view addSubview:self.navBar];
}

- (void)setBackBtn
{
    __weak typeof(self) sself = self;
    //返回按钮
    [self.navBar.leftBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [self.navBar.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 0, 0)];
    [self.navBar.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 10, 0, 0)];
    self.navBar.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.navBar setLeftBtnWithFrame:CGRectMake(5, 21, 100, 30) andContent:self.returnTitle andBlock:^{
        [sself.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)handleOriginNavBar
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), false, 0);
    UIColor * color     = [UIColor clearColor];
    [color setFill];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, 100, 100), kCGBlendModeXOR);
    CGImageRef cgimage  = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    UIImage * backImage = [UIImage imageWithCGImage:cgimage];
    
    [self.navigationController.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:backImage];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout                         = UIRectEdgeAll;
    
    UIView * backView = [self.navigationController.navigationBar.subviews lastObject];
    if ([backView isKindOfClass:[backView class]]) {
        self.navigationController.navigationBar.topItem.title = @"";
        backView.frame = CGRectZero;
    }
    
}

#pragma mark- override method
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark- private method

/*!设置NavBarTitle*/
- (void)setNavBarTitle:(NSString *)title
{
    [self.navBar setNavTitle:title];
}

/*!入栈*/
- (void)pushVC:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
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
