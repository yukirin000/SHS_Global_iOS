//
//  RecordCell.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

/**
 *  记录cell
 */
@interface RecordCell : UITableViewCell

- (void)setWithModel:(OrderModel *)model;

@end
