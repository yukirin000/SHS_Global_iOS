//
//  YSAlertView.h
//  AlertView
//
//  Created by EaseMob on 15/4/1.
//  Copyright (c) 2015年 YSSSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSAlertView : UIAlertView

/**
 *  弹出提示框
 *
 *  @param title             <#title description#>
 *  @param message           <#message description#>
 *  @param block             <#block description#>
 *  @param cancelButtonTitle <#cancelButtonTitle description#>
 *  @param otherButtonTitles <#otherButtonTitles description#>
 *
 *  @return <#return value description#>
 */
+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               completionBlock:(void (^)(NSUInteger buttonIndex, YSAlertView *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ...;


+ (id)initWithTitle:(NSString *)title
            message:(NSString *)message
    completionBlock:(void (^)(NSUInteger buttonIndex, YSAlertView *alertView))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
