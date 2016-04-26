//
//  ChoiceCarsViewController.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RefreshViewController.h"
#import "OrderModel.h"

/**
 *  选择汽车
 */
@interface ChoiceCarsViewController : RefreshViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger  shop_id;

@property (nonatomic, assign) NSInteger  goods_id;

@property (nonatomic, strong) OrderModel * order;

@end
