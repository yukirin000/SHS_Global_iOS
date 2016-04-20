//
//  PushService.m
//  JLXCSNS_iOS
//
//  Created by 李晓航 on 15/5/26.
//  Copyright (c) 2015年 JLXC. All rights reserved.
//

#import "PushService.h"
#import "JPUSHService.h"

@implementation PushService

static PushService * _shareInstance = nil;

+(PushService *) sharedInstance
{
    if(!_shareInstance) {
        _shareInstance = [[PushService alloc] init];
    }
    
    return _shareInstance;
}

-(id)init
{
    self = [super init];
    if (self) {

        [self registerNotify];
        

        
    }
    return self;
}

#pragma mark- 通知部分
- (void)registerNotify
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
}

- (void)dealloc {
    [self unObserveAllNotifications];
}

- (void)unObserveAllNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
}


- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");

}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {

    NSLog(@"已登录");
    if ([JPUSHService registrationID]) {
        debugLog(@"get RegistrationID %@", [JPUSHService registrationID]);
        
        if ([UserService getUserID] > 0){
            [JPUSHService setTags:nil
                            alias:[ToolsManager getCommonTargetId]
                 callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                           target:self];
        }
    }
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \n %@ \nalias: %@\n", iResCode, tags, alias];

    NSLog(@"TagsAlias回调:%@", callbackString);
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *currentContent = [NSString
                                stringWithFormat:
                                @"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
                                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                               dateStyle:NSDateFormatterNoStyle
                                                               timeStyle:NSDateFormatterMediumStyle],
                                title, content, [self logDic:extra]];
    debugLog(@"%@", currentContent);
    
    NSMutableArray * arr        = [NSMutableArray arrayWithArray:[PushService getNotifyList]];
    NSDictionary * dic          = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary * muDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [muDic[@"content"] setObject:@"0" forKey:@"isRead"];
    [arr addObject:muDic];
    [PushService saveNotifyList:arr];
}

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)serviceError:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    debugLog(@"%@", error);
}

+ (NSArray *)getNotifyList
{
    NSString * loc = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"notify.plist"];
    NSArray * arr  = [NSArray arrayWithContentsOfFile:loc];
    if (arr == nil) {
        arr = @[];
    }
    return arr;
}

+ (BOOL)saveNotifyList:(NSArray *)list
{
    NSString * loc = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"notify.plist"];
    return [list writeToFile:loc atomically:YES];
}

@end
