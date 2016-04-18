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
#define kRootAddr @"http://114.215.95.23/BusinessServer/"
//home
#define kHomeAddr @"http://114.215.95.23/BusinessServer/index.php/Home/MobileApi"

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
//我的爱车列表
#define API_MyCars [kHomeAddr stringByAppendingString:@"/myCars"]
//申请爱车
#define API_AddCar [kHomeAddr stringByAppendingString:@"/addCar"]
//爱车详情
#define API_CarInfo [kHomeAddr stringByAppendingString:@"/carInfo"]
//汽车品牌
#define API_CarCategory [kHomeAddr stringByAppendingString:@"/carCategory"]
//具体型号
#define API_CarClassify [kHomeAddr stringByAppendingString:@"/carClassify"]
//选择我的爱车
#define API_ChoiceMyCar [kHomeAddr stringByAppendingString:@"/choiceMyCar"]
//重新提交爱车信息
#define API_UpdateCar [kHomeAddr stringByAppendingString:@"/updateCar"]


#endif /* Interface_h */
