//
//  OrderModel.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>

//订单模型
@interface OrderModel : NSObject

//订单id
@property (nonatomic, assign) NSInteger oid;
//商家名字
@property (nonatomic, copy  ) NSString  * shop_name;
//商家图片
@property (nonatomic, copy  ) NSString  * shop_image;
//商家电话
@property (nonatomic, copy  ) NSString  * shop_phone;
//商品名字
@property (nonatomic, copy  ) NSString  * goods_name;
//服务车辆
@property (nonatomic, copy  ) NSString  * car_type;
//原价
@property (nonatomic, copy  ) NSString  * original_price;
//总价
@property (nonatomic, copy  ) NSString  * total_fee;
//订单号
@property (nonatomic, copy  ) NSString  * out_trade_no;
//支付时间
@property (nonatomic, copy  ) NSString  * pay_date;
//使用时间
@property (nonatomic, copy  ) NSString  * use_date;


@end
