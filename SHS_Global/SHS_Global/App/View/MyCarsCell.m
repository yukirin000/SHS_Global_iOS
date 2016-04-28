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
    self.contentView.backgroundColor = [UIColor colorWithHexString:ColorWhite];

    self.carTypeLabel.frame          = CGRectMake(15, 0, 170, 50);
    self.carTypeLabel.textColor      = [UIColor colorWithHexString:ColorTitle];
    self.carTypeLabel.font           = [UIFont systemFontOfSize:FontListName];

    self.plateLabel.frame         = CGRectMake([DeviceManager getDeviceWidth]-140, 0, 125, 50);
    self.plateLabel.textAlignment = NSTextAlignmentRight;
    self.plateLabel.font          = [UIFont systemFontOfSize:14];
    self.plateLabel.textColor     = [UIColor colorWithHexString:@"888888"];

    self.checkLabel.frame         = CGRectMake([DeviceManager getDeviceWidth]-140, 0, 135, 50);
    self.checkLabel.text          = @"正在审核";

    UIView * lineView             = [[UIView alloc] initWithFrame:CGRectMake(15, 49, [DeviceManager getDeviceWidth]-15, 1)];
    lineView.backgroundColor      = [UIColor colorWithHexString:ColorLineGray];
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
