//
//  ChoiceCarTypeViewController.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/14.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"

//选择类型用block
typedef void(^CarTypeBlock) (NSString * carType, NSString * carTypeCode);

//选择汽车牌子
@interface ChoiceCarTypeViewController : NavBaseViewController<UITableViewDataSource, UITableViewDelegate>

//等级1：车品牌 等级2：品牌型号
@property (nonatomic, assign) NSInteger level;
//车品牌code
@property (nonatomic, copy) NSString * brandNum;
//车品牌名字
@property (nonatomic, copy) NSString * brandName;
//返回的VC
@property (nonatomic, strong) UIViewController * returnVC;

/**
 *  设置Block
 *
 *  @param block
 */
- (void)setBlock:(CarTypeBlock)block;

@end
