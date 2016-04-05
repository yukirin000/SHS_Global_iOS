//
//  UserModel.m
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/22.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)setModelWithDic:(NSDictionary *)dic
{
    self.user_id     = [dic[@"user_id"] integerValue];
    self.username    = dic[@"username"];
    self.login_token = dic[@"login_token"];
}

@end
