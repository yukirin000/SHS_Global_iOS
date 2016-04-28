//
//  MainViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "TabBarBtn.h"

/**
 *  TabEnum
 */
typedef NS_ENUM(NSInteger, Tab){
    /**
     *  特权
     */
    TabSpecial = 0,
    /**
     *  记录
     */
    TabRecord  = 1,
    /**
     *  会员
     */
    TabUser    = 2,
    /**
     *  管家
     */
    TabBulter  = 3
};

@interface MainViewController ()

@end

@implementation MainViewController
{
    //背景View
    UIImageView * _backView;
    //控制器数组
    NSMutableArray * _vcArr;
    //标题数组
    NSMutableArray * _titleArr;
    //按钮数组
    NSMutableArray * _btnArr;
    //选中图片数组
    NSMutableArray * _selectedArr;
    //普通图片数组
    NSMutableArray * _normaleArr;
    //宽度
    CGFloat space;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.barStyle = UIBarStyleBlack;
    
    self.delegate                    = self;
    _backView                        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [DeviceManager getDeviceWidth], kTabBarHeight)];
    //    _backView.image                  = [UIImage imageNamed:@"tabbar"];
    _backView.backgroundColor        = [UIColor colorWithHexString:ColorTab];
    _backView.userInteractionEnabled = YES;
    [self.tabBar addSubview:_backView];
    UIView * topLineView             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DeviceManager getDeviceWidth], 0.5)];
    topLineView.backgroundColor      = [UIColor colorWithHexString:@"AAAAAA"];
    [_backView addSubview:topLineView];
    
    [self createVC];

    [self registerNotification];
    
    [self badgeNotify:nil];
    //激活定位
    [LocationService sharedInstance];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
}

- (void)setUnread
{
    [self badgeNotify:nil];
}

//通知刷新徽标
- (void)badgeNotify:(NSNotification *)notify
{
    
    //清空徽标
    for (TabBarBtn * barBtn in _btnArr) {
        [barBtn refreshBadgeWith:0];
    }
    
//    //徽标 最多显示99
//    //未读推送
//    NSInteger newsUnreadCount = [NewsPushModel findUnreadCount].count;
//    //聊天未读
//    NSInteger total = newsUnreadCount;
//    if (total > 99) {
//        total = 99;
//    }
//    TabBarBtn * newsBtn = _btnArr[TabNews];
//    [newsBtn refreshBadgeWith:total];
//    
//    //MSG部分
//    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
//    NSInteger unreadCount = 0;
//    for (EMConversation *conversation in conversations) {
//        unreadCount += conversation.unreadMessagesCount;
//    }
//    TabBarBtn * chatBtn = _btnArr[TabMessage];
//    [chatBtn refreshBadgeWith:unreadCount];
//    
//    //Con部分
//    NSInteger newUnreadCount = [[InvitationManager sharedInstance] getUnread];
//    TabBarBtn * conBtn       = _btnArr[TabContact];
//    [conBtn refreshBadgeWith:newUnreadCount];
//    [_contactsVC reloadApplyView];
    
    //外界Badge 设置为IM的UnreadCount
    //    UIApplication *application = [UIApplication sharedApplication];
    //    [application setApplicationIconBadgeNumber:unreadCount];
}


/*!
 @brief 自定义切换tab
 @param index为要切换的tab
 */
- (void)customSelectedIndex:(NSInteger)index
{
    if (index == TabUser || index == TabRecord) {
        //新用户提示注册
        if ([UserService sharedService].user.user_id < 1) {
            [YSAlertView showAlertWithTitle:StringCommonPrompt message:GlobalString(@"LoginNoUser") completionBlock:^(NSUInteger buttonIndex, YSAlertView *alertView) {
                if (buttonIndex == 1) {
                    LoginViewController * lvc    = [[LoginViewController alloc] init];
                    lvc.hideNavbar               = YES;
                    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lvc];
                    [self presentViewController:nav animated:YES completion:^{
                    }];
                }
            } cancelButtonTitle:GlobalString(@"LoginNoUserNo") otherButtonTitles:GlobalString(@"LoginNoUserYes"), nil];
            return;
        }
    }
    
    [self selectTab:index];
}

- (void)selectTab:(NSInteger)index
{
    self.selectedIndex = index;
    for (UIButton * item in _backView.subviews) {
        if ([item isKindOfClass:[UIButton class]]) {
            item.selected = NO;
        }
    }
    
    TabBarBtn * tbb      = _btnArr[index];
    tbb.selected         = YES;
}

- (void)createVC
{
    NSString * fileName = @"Global";
    NSString * path     = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray * arr       = [NSArray arrayWithContentsOfFile:path];
    _vcArr              = [[NSMutableArray alloc] init];
    _titleArr           = [[NSMutableArray alloc] init];
    _btnArr             = [[NSMutableArray alloc] init];
    _selectedArr        = [[NSMutableArray alloc] init];
    _normaleArr         = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in arr) {
        Class class = NSClassFromString([dic objectForKey:@"controller"]);
        NavBaseViewController * bVC = [[[class class] alloc] init];
        bVC.hideLeftBtn          = YES;
        NSString * title         = GlobalString([dic objectForKey:@"title"]);
        [bVC setNavBarTitle:title];
        [_titleArr addObject:title];
        [_vcArr addObject:bVC];
        [_normaleArr addObject:dic[@"normalPic"]];
        [_selectedArr addObject:dic[@"selectedPic"]];
    }
    
    NSInteger count = _vcArr.count;
    space           = [DeviceManager getDeviceWidth]/count;
    
    for (int i=0; i<count; i++) {
        TabBarBtn * item = [[TabBarBtn alloc] initWithFrame:CGRectMake(space*i, 0, space, kTabBarHeight)];
        item.titeLabel.text = _titleArr[i];
        [_btnArr addObject:item];
        [item setImage:[UIImage imageNamed:_normaleArr[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:_selectedArr[i]] forState:UIControlStateSelected];
        [item setImageEdgeInsets:UIEdgeInsetsMake(8, 0, 23, 0)];
        if (i == 0) {
            item.selected        = YES;
        }
        [_backView addSubview:item];
    }
    
    self.viewControllers = _vcArr;
    
}


#pragma mark- tabBar点击代理
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    NSInteger index      = [tabBarController.viewControllers indexOfObject:viewController];
//    
//    for (UIButton * item in _backView.subviews) {
//        if ([item isKindOfClass:[UIButton class]]) {
//            item.selected = NO;
//        }
//    }
//
//    TabBarBtn * btn      = _btnArr[index];
//    btn.selected         = YES;
//    
//}

#pragma mark- tabBar点击代理
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    [self customSelectedIndex:index];
    
    return NO;
}

#pragma mark - 注册通知
//注册通知
- (void)registerNotification
{
    //支付成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:NotifyPaySuccess object:nil];
    //通知增加一个徽标
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeNotify:) name:NOTIFY_TAB_BADGE object:nil];
}

#pragma mark- method response
- (void)paySuccess:(id)sender
{
    [self selectTab:TabRecord];
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
