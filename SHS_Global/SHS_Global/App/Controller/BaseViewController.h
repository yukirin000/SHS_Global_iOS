//
//  ViewController.h
//  JLXCSNS_iOS
//
//  Created by 李晓航 on 15/5/8.
//  Copyright (c) 2015年 JLXC. All rights reserved.
//

#import <UIKit/UIKit.h>

//一级父类
@interface BaseViewController : UIViewController

//界面宽
@property int viewWidth;
//界面高
@property int viewHeight;

/*!出栈*/
- (void)popToTabBarViewController;

/*!无动画出栈*/
- (void)popToTabBarViewControllerNoAnimation;

@end
