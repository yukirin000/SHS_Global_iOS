//
//  NotifyCell.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NotifyCell.h"

@interface NotifyCell()

//标题
@property (nonatomic, strong) CustomLabel * titleLabel;
//消息
@property (nonatomic, strong) CustomLabel * messageLabel;
//未读标识
@property (nonatomic, strong) UIView * unreadView;

@end

@implementation NotifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initWidget];
    }
    
    return self;
}

- (void)initWidget
{
    self.titleLabel   = [[CustomLabel alloc] init];
    self.messageLabel = [[CustomLabel alloc] init];
    self.unreadView   = [[UIView alloc] init];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.unreadView];
    
    [self configUI];
}

- (void)configUI
{
    
    self.titleLabel.frame   = CGRectMake(10, 0, 150, 60);
    self.messageLabel.frame = CGRectMake([DeviceManager getDeviceWidth]-150, 0, 120, 60);
    self.unreadView.frame   = CGRectMake([DeviceManager getDeviceWidth]-30, 23, 4, 4);
    
    self.messageLabel.textAlignment = NSTextAlignmentRight;
    self.messageLabel.font          = [UIFont systemFontOfSize:14];
    self.messageLabel.textColor     = [UIColor colorWithHexString:ColorContent];
    self.unreadView.backgroundColor = [UIColor redColor];
    
    
    self.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)setWithModel:(NotifyModel *)model
{
    self.titleLabel.text   = model.title;
    self.messageLabel.text = model.message;
    if (model.isUnread == YES) {
        self.unreadView.hidden = NO;
    }else{
        self.unreadView.hidden = YES;
    }
}

@end
