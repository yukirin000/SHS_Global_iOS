//
//  ApplyCarViewController.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/13.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NavBaseViewController.h"
#import "CarModel.h"

//申请爱车
@interface ApplyCarViewController : NavBaseViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//重新提交
@property (nonatomic, strong) CarModel * carModel;

@end
