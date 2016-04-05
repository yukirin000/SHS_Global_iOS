//
//  NavBaseViewController.h
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/19.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "BaseViewController.h"
#import "NavBar.h"

//二级父类 有导航
@interface NavBaseViewController : BaseViewController

/*!导航栏*/
@property (nonatomic, strong) NavBar * navBar;
/*!是否隐藏左边按钮*/
@property (nonatomic, assign) BOOL hideLeftBtn;
/*!是否隐藏navBar*/
@property (nonatomic, assign) BOOL hideNavbar;
/**
 *  返回的标题
 */
@property (nonatomic, copy) NSString * returnTitle;

/*!设置NavBarTitle*/
- (void)setNavBarTitle:(NSString *)title;

/*!入栈*/
- (void)pushVC:(UIViewController *)vc;


@end
