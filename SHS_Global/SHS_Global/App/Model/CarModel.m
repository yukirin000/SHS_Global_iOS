//
//  CarModel.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/14.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

- (void)setModelWithDic:(NSDictionary *)dic
{
    self.cid                 = [dic[@"id"] integerValue];
    self.user_id             = [dic[@"user_id"] integerValue];
    self.state               = [dic[@"state"] integerValue];
    self.name                = dic[@"name"];
    self.mobile              = dic[@"mobile"];
    self.plate_number        = dic[@"plate_number"];
    self.car_type            = dic[@"car_type"];
    self.car_type_code       = dic[@"car_type_code"];
    self.driving_license_url = dic[@"driving_license_url"];
}

@end
