//
//  LocationService.h
//  SHS_Global
//
//  Created by 李晓航 on 16/4/5.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  定位服务
 */
@interface LocationService : NSObject

+ (LocationService *) sharedInstance;

/**
 *  获取当前与某个商店的距离
 *
 *  @param end 目标商店经纬度
 *
 *  @return
 */
- (NSString *)getDistanceWith:(CGPoint)end;

/**
 *  通过经纬度计算距离
 *
 *  @param start 起始位置
 *  @param end   重点位置
 *
 *  @return
 */
- (NSString *)calculateDistanceFrom:(CGPoint)start to:(CGPoint)end;

- (BOOL)existLocation:(CGPoint)point;

@end
