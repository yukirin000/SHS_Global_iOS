//
//  CarModel.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/14.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>

//0是取消审核 1是正在审核 2是通过审核 3是未通过审核
typedef NS_ENUM(NSInteger, CarState) {
    CarStateCancel   = 0,
    CarStateChecking = 1,
    CarStateSuccess  = 2,
    CarStateFail     = 3
};

/**
 *  车辆模型
 */
@interface CarModel : NSObject

//车ID
@property (nonatomic, assign) NSInteger cid;
//所属用户ID
@property (nonatomic, assign) NSInteger user_id;
//姓名
@property (nonatomic, copy  ) NSString  * name;
//电话
@property (nonatomic, copy  ) NSString  * mobile;
//车牌号
@property (nonatomic, copy  ) NSString  * plate_number;
//授权地址
@property (nonatomic, copy  ) NSString  * driving_license_url;
//车类型
@property (nonatomic, copy  ) NSString  * car_type;
//车类型代码
@property (nonatomic, copy  ) NSString  * car_type_code;
//车辆状态
@property (nonatomic, assign) CarState  state;

- (void)setModelWithDic:(NSDictionary *)dic;

@end
