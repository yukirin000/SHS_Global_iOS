//
//  NotifyModel.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, NotifyType) {
    //审核成功
    NotifyCheckCarSuccess = 1,
    //审核失败
    NotifyCheckCarFail    = 2
};

@interface NotifyModel : NSObject

//id
@property (nonatomic, assign) NSInteger nid;
//targetID
@property (nonatomic, assign) NSInteger targetID;
//表情
@property (nonatomic, copy  ) NSString  * title;
//信息
@property (nonatomic, copy  ) NSString  * message;
//类型
@property (nonatomic, assign) NotifyType type;
//是否已读
@property (nonatomic, assign) BOOL      isUnread;

@end
