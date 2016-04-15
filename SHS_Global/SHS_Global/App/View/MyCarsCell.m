//
//  MyCarsCell.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/14.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "MyCarsCell.h"

@interface MyCarsCell()

//车类型
@property (nonatomic, strong) CustomLabel * carTypeLabel;
//车牌号
@property (nonatomic, strong) CustomLabel * plateLabel;
//正在审核提示
@property (nonatomic, strong) CustomLabel * checkLabel;

@end

@implementation MyCarsCell

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
    self.carTypeLabel = [[CustomLabel alloc] init];
    self.plateLabel   = [[CustomLabel alloc] init];
    self.checkLabel   = [[CustomLabel alloc] init];
    
    [self.contentView addSubview:self.carTypeLabel];
    [self.contentView addSubview:self.plateLabel];
    [self.contentView addSubview:self.checkLabel];
 
    [self configUI];
}

- (void)configUI
{
    self.carTypeLabel.frame       = CGRectMake(5, 0, 170, 60);

    self.plateLabel.frame         = CGRectMake([DeviceManager getDeviceWidth]-140, 0, 135, 60);
    self.plateLabel.textAlignment = NSTextAlignmentRight;

    self.checkLabel.frame         = CGRectMake([DeviceManager getDeviceWidth]-140, 0, 135, 60);
    self.checkLabel.text          = @"正在审核";
//    UIImageView * arrow = [[UIImageView alloc] initWithFrame:CGRectMake(120, 0, 0, 0)];
//    [self.checkLabel addSubview:arrow];
    UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(0, 59, [DeviceManager getDeviceWidth], 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
    [self.contentView addSubview:lineView];
}

- (void)setWithModel:(CarModel *)model
{
    self.carTypeLabel.text = model.car_type;
    
    if (model.state == CarStateChecking) {
        self.checkLabel.hidden = NO;
        self.plateLabel.hidden = YES;
    }else{
        self.checkLabel.hidden = YES;
        self.plateLabel.hidden = NO;
        self.plateLabel.text   = model.plate_number;
    }
}

@end
