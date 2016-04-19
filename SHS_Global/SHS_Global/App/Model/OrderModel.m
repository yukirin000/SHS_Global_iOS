//
//  OrderModel.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (void)setModelWithDic:(NSDictionary *)orderDic
{
    self.oid          = [orderDic[@"id"] integerValue];
    self.shop_name    = orderDic[@"shop_name"];
    self.shop_image   = orderDic[@"shop_image_thumb"];
    self.shop_phone   = orderDic[@"shop_phone"];
    self.goods_name   = orderDic[@"goods_name"];
    self.car_type     = orderDic[@"car_type"];
    self.total_fee    = orderDic[@"total_fee"];
    self.out_trade_no = orderDic[@"out_trade_no"];
    self.pay_date     = orderDic[@"pay_date"];
    self.use_date     = orderDic[@"use_date"];
}

@end
