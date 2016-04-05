//
//  ShopModel.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject

/**
 *  商店id
 */
@property (nonatomic, assign) NSInteger sid;
/**
 *  商店名
 */
@property (nonatomic, copy) NSString * shop_name;
/**
 *  商店介绍
 */
@property (nonatomic, copy) NSString * shop_intro;
/**
 *  商店电话
 */
@property (nonatomic, copy) NSString * shop_phone;
/**
 *  商店图片
 */
@property (nonatomic, copy) NSString * shop_image;
/**
 *  商店图片缩略图
 */
@property (nonatomic, copy) NSString * shop_image_thumb;
/**
 *  商店地址
 */
@property (nonatomic, copy) NSString * address;
/**
 *  经度
 */
@property (nonatomic, copy) NSString * longitude;
/**
 *  纬度
 */
@property (nonatomic, copy) NSString * latitude;


- (void)setModelWithDic:(NSDictionary *)shopDic;

@end
