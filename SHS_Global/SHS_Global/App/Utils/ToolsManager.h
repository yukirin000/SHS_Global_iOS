//
//  ToolsManager.h
//  UBaby_iOS
//
//  Created by bhczmacmini on 14-10-20.
//  Copyright (c) 2014年 bhczmacmini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworkReachabilityManager.h>
/*!
    @brief 工具类
 */
@interface ToolsManager : NSObject

/*! 工具类单例*/
+ (instancetype)sharedManager;

//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//车牌号
+ (BOOL) validatePlateNumber:(NSString *)number;
//字母或者数字
+ (BOOL) validateAlpha:(NSString *)name;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber;
//姓名
+ (BOOL) validateName:(NSString *)name;
//网站
+ (BOOL) validateWEB:(NSString *)content;

/**
 *  设置行间距
 *
 *  @param string      内容
 *  @param lineSpacing 间距
 *
 *  @return 
 */
+ (NSMutableAttributedString *)stringTransformToAttributedString:(NSString *)string withLineSpacing:(CGFloat)lineSpacing;

/*!
 @method
 @brief 获取大小
 @param content 内容
 @param fontSize 字体大小
 @param frame 内容限制
 */
+ (CGSize)getSizeWithContent:(NSString *)content andFontSize:(CGFloat)fontSize andFrame:(CGRect)frame;

/*!
 获取当前网络状态
 */
+ (BOOL)isNet;

/**!
 * 计算指定时间与当前的时间差
 *
 * @param compareDateStr  某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *)compareCurrentTime:(NSString *)compareDateStr;

/**!
 * 计算指定时间与当前的时间差
 * @param str   某一指定时间
 * @return 多少秒
 */
+ (int)compareTimeDistance:(NSString*)str;

/**!
 * 获取时间间隔后的日期
 * @param dateString  日期字符串
 * @return 日期
 */
+ (NSString *)timeInterval:(NSString *)time withSecond:(NSTimeInterval)interval;

/**!
 * 字符串转日期
 * @param dateString  日期字符串
 * @return 日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

/**
 * 日期转字符串
 * @param dateString  日期
 * @return 日期
 */
+ (NSString *)StringFromDate:(NSDate *)date;

/**!
 * 日期转字符串
 * @param date        日期
 * @param formatter   格式
 * @return 日期
 */
+ (NSString *)StringFromDate:(NSDate *)date andFormatter:(NSString *)formatter;

/**!
 * 字符串转日期
 * @param dateString  日期字符串
 * @param formatter   格式
 * @return 日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString andFormatter:(NSString *)formatter;

/*!
 获取通用用户名 ps:IM 推送使用
 */
+ (NSString *)getCommonTargetId;


@end
