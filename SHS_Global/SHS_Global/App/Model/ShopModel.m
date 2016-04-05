//
//  ShopModel.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

- (void)setModelWithDic:(NSDictionary *)shopDic
{
    self.sid              = [shopDic[@"id"] integerValue];
    self.shop_name        = shopDic[@"shop_name"];
    self.address          = shopDic[@"address"];
    self.shop_image_thumb = shopDic[@"shop_image_thumb"];
    self.shop_image       = shopDic[@"shop_image"];
    self.shop_phone       = shopDic[@"shop_phone"];
    self.longitude        = shopDic[@"longitude"];
    self.latitude         = shopDic[@"latitude"];
}

@end
