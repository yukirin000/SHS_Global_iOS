//
//  MyCarsCell.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/14.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

/**
 *  我的爱车列表
 */
@interface MyCarsCell : UITableViewCell

- (void)setWithModel:(CarModel *)model;

@end
