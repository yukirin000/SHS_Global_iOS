//
//  GoodsModel.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (void)setModelWithDic:(NSDictionary *)shopDic
{
    self.gid            = [shopDic[@"id"] integerValue];
    self.goods_name     = shopDic[@"goods_name"];
    self.original_price = shopDic[@"original_price"];
    self.discount_price = shopDic[@"discount_price"];
}

@end
