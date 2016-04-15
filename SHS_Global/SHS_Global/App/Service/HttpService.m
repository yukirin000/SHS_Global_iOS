//
//  HttpService.m
//  JLXCSNS_iOS
//
//  Created by 李晓航 on 15/5/9.
//  Copyright (c) 2015年 JLXC. All rights reserved.
//

#import "HttpService.h"
@implementation HttpService
{
    AFHTTPSessionManager * _manager;
}

static HttpService * instance;

+ (instancetype)manager {
    
    if (!instance) {
        instance = [[HttpService alloc] init];
    }
    return instance;
}

+ (void)getWithUrlString:(NSString *)urlStr andCompletion:(SuccessBlock)success andFail:(FailBlock)fail
{
    AFHTTPSessionManager * manager = [[HttpService manager] createAFEntity];
    
    if ([UserService sharedService].user.user_id > 0 && [UserService sharedService].user.login_token.length > 5) {
        //token传输
        if ([urlStr rangeOfString:@"?"].location == NSNotFound) {
            urlStr = [urlStr stringByAppendingFormat:@"?login_token=%@&login_user=%ld", [UserService sharedService].user.login_token, [UserService sharedService].user.user_id];            
        }else{
            urlStr = [urlStr stringByAppendingFormat:@"&login_token=%@&login_user=%ld", [UserService sharedService].user.login_token, [UserService sharedService].user.user_id];
        }
    }
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            @try {
                success(responseObject);
            }
            @catch (NSException *exception) {
                fail(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
    
}

+ (void)postWithUrlString:(NSString *)urlStr params:(NSDictionary *)params andCompletion:(SuccessBlock)success andFail:(FailBlock)fail
{
    AFHTTPSessionManager * manager = [[HttpService manager] createAFEntity];
    NSMutableDictionary * finalDic = [NSMutableDictionary dictionaryWithDictionary:params];
    if ([UserService sharedService].user.user_id > 0 && [UserService sharedService].user.login_token.length > 5) {
        [finalDic setObject:[UserService sharedService].user.login_token forKey:@"login_token"];
        [finalDic setObject:[NSString stringWithFormat:@"%ld", [UserService sharedService].user.user_id] forKey:@"login_user"];
    }
    
    [manager POST:urlStr parameters:finalDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            @try {
                success(responseObject);
            }
            @catch (NSException *exception) {
                fail(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(nil);
    }];

}

+ (void)postFileWithUrlString:(NSString *)urlStr params:(NSDictionary *)params files:(NSArray *)files andCompletion:(SuccessBlock)success andFail:(FailBlock)fail
{
    AFHTTPSessionManager * manager = [[HttpService manager] createAFEntity];
    NSMutableDictionary * finalDic          = [NSMutableDictionary dictionaryWithDictionary:params];
    if ([UserService sharedService].user.user_id > 0 && [UserService sharedService].user.login_token.length > 5) {
        //token
        [finalDic setObject:[UserService sharedService].user.login_token forKey:@"login_token"];
        [finalDic setObject:[NSString stringWithFormat:@"%ld", [UserService sharedService].user.user_id] forKey:@"login_user"];
    }
    
    [manager POST:urlStr parameters:finalDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (files != nil && files.count >0) {
            for (NSDictionary * file in files) {
                [formData appendPartWithFileData:file[FileDataKey] name:file[FileNameKey] fileName:file[FileNameKey] mimeType:@""];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            @try {
                success(responseObject);
            }
            @catch (NSException *exception) {
                fail(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(nil);
    }];

}

//创建AF实体
- (AFHTTPSessionManager *)createAFEntity
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }

    _manager.requestSerializer.timeoutInterval         = 30.0f;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    return _manager;
}

@end
