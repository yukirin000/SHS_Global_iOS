//
//  CreateOrderViewController.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"
#import "OrderModel.h"

//创建订单页面
@interface CreateOrderViewController : NavBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger  shop_id;

@property (nonatomic, assign) NSInteger  goods_id;

@property (nonatomic, assign) NSInteger  carID;

@property (nonatomic, strong) OrderModel * orderModel;

@end
