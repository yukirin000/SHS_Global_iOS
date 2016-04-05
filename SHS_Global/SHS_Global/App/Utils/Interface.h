//
//  Interface.h
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/22.
//  Copyright © 2016年 SHS. All rights reserved.
//

#ifndef Interface_h
#define Interface_h

//192.168.1.108 120.25.213.171 114.215.95.23 127.0.0.1 www.pinweihuanqiu.com
//root
#define kRootAddr @"http://192.168.0.104/BusinessServer/"
//home
#define kHomeAddr @"http://192.168.0.104/BusinessServer/index.php/Home/MobileApi"

#define kUserProtocolPath @"http://www.pinweihuanqiu.com/license.html"

//是否有该用户
#define API_IsUser [kHomeAddr stringByAppendingString:@"/isUser"]

//注册
#define API_RegisterUser [kHomeAddr stringByAppendingString:@"/registerUser"]

//注册用获取验证码
#define API_RegisterSms [kHomeAddr stringByAppendingString:@"/registerSms"]

//找回密码
#define API_FindPwdUser [kHomeAddr stringByAppendingString:@"/findPwdUser"]

//找回密码用获取验证码
#define API_FindPwdSms [kHomeAddr stringByAppendingString:@"/findPwdSms"]

//登录
#define API_LoginUser [kHomeAddr stringByAppendingString:@"/loginUser"]

//商店
#define API_GetShopList [kHomeAddr stringByAppendingString:@"/getShopList"]

//商店详情
#define API_GetShopDetail [kHomeAddr stringByAppendingString:@"/getShopDetail"]


#endif /* Interface_h */
