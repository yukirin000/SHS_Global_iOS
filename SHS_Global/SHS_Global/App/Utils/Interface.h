//
//  Interface.h
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/22.
//  Copyright © 2016年 SHS. All rights reserved.
//

#ifndef Interface_h
#define Interface_h

//120.25.213.171 114.215.95.23 www.pinweihuanqiu.com
//root
#define kRootAddr @"http://www.pinweihuanqiu.com/BusinessServer/"
//home
#define kHomeAddr @"http://www.pinweihuanqiu.com/BusinessServer/index.php/Home/MobileApi"

#define kUserProtocolPath @"http://www.pinweihuanqiu.com/globalLicense.html"

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
//更新爱车
#define API_UpdateCar [kHomeAddr stringByAppendingString:@"/updateCar"]
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
//服务中订单列表
#define API_ServiceList [kHomeAddr stringByAppendingString:@"/serviceList"]
//已服务订单列表
#define API_AlreadyServiceList [kHomeAddr stringByAppendingString:@"/alreadyServiceList"]
//订单服务详情
#define API_ServiceDetails [kHomeAddr stringByAppendingString:@"/serviceDetails"]
//创建订单
#define API_CreateOrder [kHomeAddr stringByAppendingString:@"/createOrder"]


#endif /* Interface_h */
