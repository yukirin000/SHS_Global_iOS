//
//  RegisterViewController.h
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/19.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"

/**
 *  注册新用户或者找回密码页面
 */
@interface RegisterViewController : NavBaseViewController<UITextFieldDelegate>

//如果是从找回密码进来的
@property (nonatomic, assign) BOOL isFindPwd;

@property (nonatomic, copy) NSString * phoneNumber;

@end
