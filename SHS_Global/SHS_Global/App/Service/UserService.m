//
//  UserService.m
//  UBaby_iOS
//
//  Created by bhczmacmini on 14-10-27.
//  Copyright (c) 2014年 bhczmacmini. All rights reserved.
//

#import "UserService.h"
#import "DatabaseService.h"
@implementation UserService
{
    NSUserDefaults * _defaults;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.user = [[UserModel alloc] init];
        _defaults = [NSUserDefaults standardUserDefaults];
        [self find];
    }
    return self;
}

/*! 返回用户服务单例*/
+ (instancetype)sharedService
{

    static UserService * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserService alloc] init];
    });
    
    return instance;
}

//保存数据
- (void)saveAndUpdate
{
    
    [_defaults setObject:@(self.user.user_id) forKey:@"user_id"];
    [_defaults setObject:self.user.username forKey:@"username"];
    [_defaults setObject:self.user.mobile forKey:@"mobile"];
    [_defaults setObject:self.user.login_token forKey:@"login_token"];

    [_defaults synchronize];
    
    //清空
//    [self clear];
//    NSString * insertSql = [NSString stringWithFormat:@"insert into kh_user (id,username,name,kh_id,sex,phone_num,company_name,address,head_image,head_sub_image,job,birthday,e_mail,signature,qr_code,login_token,im_token,iosdevice_token,company_state,address_state,email_state,phone_state) values ('%ld', '%@', '%@', '%@', '%ld', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%ld', '%ld', '%ld', '%ld')", _user.uid, _user.username, _user.name, _user.kh_id, _user.sex,_user.phone_num, _user.company_name, _user.address ,_user.head_image, _user.head_sub_image, _user.job, _user.birthday, _user.e_mail, _user.signature, _user.qr_code, _user.login_token, _user.im_token, _user.iosdevice_token, _user.company_state, _user.address_state, _user.email_state, _user.phone_state];
//
//    //插入
//    [[DatabaseService sharedInstance] executeUpdate:insertSql];

}

//获取缓存数据
- (void)find
{
    self.user.user_id     = [[_defaults objectForKey:@"user_id"] integerValue];
    self.user.username    = [_defaults objectForKey:@"username"];
    self.user.mobile      = [_defaults objectForKey:@"mobile"];
    self.user.login_token = [_defaults objectForKey:@"login_token"];
    
    //(id,free_count,account,dr_cr,name,sex,passwd,mob_no,mailadd,medical_card,idcard_w,image,role_id,level_id)
//    NSString * selectSql = @"select * from kh_user Limit 1";
//    FMResultSet * rs = [[DatabaseService sharedInstance] executeQuery:selectSql];
//    
//    while (rs.next) {
//        _user.uid             = [[rs stringForColumn:@"id"] integerValue];
//        _user.username        = [rs stringForColumn:@"username"];
//        _user.name            = [rs stringForColumn:@"name"];
//        _user.kh_id           = [rs stringForColumn:@"kh_id"];
//        _user.sex             = [rs intForColumn:@"sex"];
//        _user.phone_num       = [rs stringForColumn:@"phone_num"];
//        _user.company_name    = [rs stringForColumn:@"company_name"];
//        _user.address         = [rs stringForColumn:@"address"];
//        _user.head_image      = [rs stringForColumn:@"head_image"];
//        _user.head_sub_image  = [rs stringForColumn:@"head_sub_image"];
//        _user.job             = [rs stringForColumn:@"job"];
//        _user.birthday        = [rs stringForColumn:@"birthday"];
//        _user.e_mail          = [rs stringForColumn:@"e_mail"];
//        _user.signature       = [rs stringForColumn:@"signature"];
//        _user.qr_code         = [rs stringForColumn:@"qr_code"];
//        _user.login_token     = [rs stringForColumn:@"login_token"];
//        _user.im_token        = [rs stringForColumn:@"im_token"];
//        _user.iosdevice_token = [rs stringForColumn:@"iosdevice_token"];
//        _user.company_state   = [rs intForColumn:@"company_state"];
//        _user.address_state   = [rs intForColumn:@"address_state"];
//        _user.email_state     = [rs intForColumn:@"email_state"];
//        _user.phone_state     = [rs intForColumn:@"phone_state"];
//        
//        break;
//    }
//    
//    [rs close];
}

- (void)clear
{
//    NSString * deleteSql = @"delete from biz_user";
//    //清空
//    [[DatabaseService sharedInstance] executeUpdate:deleteSql];
}

@end
