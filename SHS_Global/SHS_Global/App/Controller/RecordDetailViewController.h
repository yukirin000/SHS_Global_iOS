//
//  RecordDetailViewController.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"

//记录详情
@interface RecordDetailViewController : NavBaseViewController<UITableViewDataSource, UITableViewDelegate>

//记录Id
@property (nonatomic, assign) NSInteger rid;

@end
