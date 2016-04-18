//
//  ViewController4.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ButlerViewController.h"
#import "LoginViewController.h"
#import "NotifyViewController.h"

@interface ButlerViewController ()

@end

@implementation ButlerViewController

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

- (void)initWidget {
    
    
    [self configUI];
}

- (void)configUI {
    
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
    
    __weak typeof(self) sself = self;
    [self.navBar setRightBtnWithContent:nil andBlock:^{
        //新用户提示注册
        if ([UserService sharedService].user.user_id < 1) {
            
            [YSAlertView showAlertWithTitle:StringCommonPrompt message:@"您还不是用户，请先成为用户" completionBlock:^(NSUInteger buttonIndex, YSAlertView *alertView) {
                if (buttonIndex == 1) {
                    LoginViewController * lvc    = [[LoginViewController alloc] init];
                    lvc.hideNavbar               = YES;
                    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lvc];
                    [sself presentViewController:nav animated:YES completion:^{
                    }];
                }
            } cancelButtonTitle:@"先看看" otherButtonTitles:@"成为用户", nil];
        }else{
            NotifyViewController * nvc = [[NotifyViewController alloc] init];
            [sself pushVC:nvc];
        }
    }];
    [self.navBar setRightImage:[UIImage imageNamed:@"bell"]];
}

#pragma mark- method response

#pragma mark- Delegate & Datasource

#pragma mark- private method
- (void)initData {
    
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
