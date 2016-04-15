//
//  CarDetailViewController.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"

/**
 *  汽车详情
 */
@interface CarDetailViewController : NavBaseViewController<UITableViewDataSource, UITableViewDelegate>

//汽车ID
@property (nonatomic, assign) NSInteger carID;

@end
