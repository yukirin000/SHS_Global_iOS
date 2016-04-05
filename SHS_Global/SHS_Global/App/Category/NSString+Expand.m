//
//  NSString+Expand.m
//  JLXCSNS_iOS
//
//  Created by 李晓航 on 15/5/22.
//  Copyright (c) 2015年 JLXC. All rights reserved.
//

#import "NSString+Expand.h"

@implementation NSString (Expand)

- (NSString *)trim
{
    NSCharacterSet * CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" "];
    
    return [self stringByTrimmingCharactersInSet:CharacterSet];
}

@end
