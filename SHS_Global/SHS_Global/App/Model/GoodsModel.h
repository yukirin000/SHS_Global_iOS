//
//  GoodsModel.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

/**
 *  商品id
 */
@property (nonatomic, assign) NSInteger gid;
/**
 *  商店id
 */
@property (nonatomic, assign) NSInteger shop_id;
/**
 *  商品名
 */
@property (nonatomic, copy) NSString * goods_name;
/**
 *  商品介绍
 */
@property (nonatomic, copy) NSString * goods_intro;
/**
 *  商品图片
 */
@property (nonatomic, copy) NSString * goods_image;
/**
 *  商品缩略图
 */
@property (nonatomic, copy) NSString * goods_image_thumb;
/**
 *  原价
 */
@property (nonatomic, copy) NSString * original_price;
/**
 *  折扣价
 */
@property (nonatomic, copy) NSString * discount_price;

- (void)setModelWithDic:(NSDictionary *)shopDic;

@end
