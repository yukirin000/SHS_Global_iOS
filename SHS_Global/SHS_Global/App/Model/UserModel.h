//
//  UserModel.h
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/22.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户模型
 */
@interface UserModel : NSObject

/*! 用户id*/
@property (nonatomic, assign) NSInteger user_id;

/*! 用户名*/
@property (nonatomic, copy  ) NSString  * username;

/*! 密码*/
@property (nonatomic, copy  ) NSString  * password;

/*! 电话号*/
@property (nonatomic, copy  ) NSString  * mobile;

/*! 登录token*/
@property (nonatomic, copy  ) NSString  * login_token;

/*! 融云im_token*/
@property (nonatomic, copy  ) NSString  * im_token;

/*! ios设备token*/
@property (nonatomic, copy  ) NSString  * iosdevice_token;

- (void)setModelWithDic:(NSDictionary *)dic;

@end
