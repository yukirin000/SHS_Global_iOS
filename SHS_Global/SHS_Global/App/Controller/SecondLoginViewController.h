//
//  SecondLoginViewController.h
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/19.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"
/**
 *  密码填写页面
 */
@interface SecondLoginViewController : NavBaseViewController<UITextFieldDelegate>

//用户名
@property (nonatomic, copy) NSString * username;

@end
