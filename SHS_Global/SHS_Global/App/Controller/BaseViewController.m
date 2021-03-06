//
//  ViewController.h
//  JLXCSNS_iOS
//
//  Created by 李晓航 on 15/5/8.
//  Copyright (c) 2015年 JLXC. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBaseVC];
}

#pragma layout
//初始化基类内部
- (void)initBaseVC
{
    
    self.view.backgroundColor = [UIColor colorWithHexString:ColorBackGray];
    self.viewWidth            = [DeviceManager getDeviceWidth];
    self.viewHeight           = [DeviceManager getDeviceHeight];

}

#pragma mark- override method
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark- public method
/*!出栈*/
- (void)popToTabBarViewController
{
    [self popToTabBarViewControllerWithAnimate:YES];
}

/*!无动画出栈*/
- (void)popToTabBarViewControllerNoAnimation
{
    [self popToTabBarViewControllerWithAnimate:NO];
}

#pragma mark- private method
- (void)popToTabBarViewControllerWithAnimate:(BOOL)yesOrNo
{
    for (int i=0; i<[self.navigationController viewControllers].count; i++) {
        UIViewController *viewController = [[self.navigationController viewControllers] objectAtIndex:i];
        if ([NSStringFromClass([viewController class]) isEqual:@"MainViewController"]) {
            UIViewController *main = [self.navigationController.viewControllers objectAtIndex:i];
            [self.navigationController popToViewController:main animated:yesOrNo];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
