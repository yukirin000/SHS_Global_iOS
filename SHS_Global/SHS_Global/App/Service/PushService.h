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

+ (NSArray *)getNotifyList;

+ (BOOL)saveNotifyList:(NSArray *)list;

@end
