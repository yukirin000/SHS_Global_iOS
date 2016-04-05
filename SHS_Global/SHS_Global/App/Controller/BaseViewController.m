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
    
    self.view.backgroundColor = [UIColor colorWithHexString:ColorMainBackground];
    self.viewWidth            = [DeviceManager getDeviceWidth];
    self.viewHeight           = [DeviceManager getDeviceHeight];

}

#pragma mark- override method
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

#pragma mark- private method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
