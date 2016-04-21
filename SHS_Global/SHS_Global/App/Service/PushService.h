//
//  PushService.h
//  JLXCSNS_iOS
//
//  Created by 李晓航 on 15/5/26.
//  Copyright (c) 2015年 JLXC. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! 推送服务类*/
@interface PushService : NSObject

+(PushService *) sharedInstance;

//获取全部通知
+ (NSArray *)getNotifyList;

//存储通知
+ (BOOL)saveNotifyList:(NSArray *)list;

//获取是否存在未读消息
+ (BOOL)hasUnread;

@end
