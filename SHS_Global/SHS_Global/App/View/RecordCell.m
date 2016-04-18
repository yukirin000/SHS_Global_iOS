//
//  RecordCell.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RecordCell.h"

@interface RecordCell()

//白色背景
@property (nonatomic, strong) UIView          * backView;
//商店图片
@property (nonatomic, strong) CustomImageView * shopImageView;
//商店名
@property (nonatomic, strong) CustomLabel     * shopNameLabel;
//价格
@property (nonatomic, strong) CustomLabel     * priceLabel;
//日期
@property (nonatomic, strong) CustomLabel     * dateLabel;

@end

@implementation RecordCell

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
    self.backView      = [[UIView alloc] init];
    self.shopImageView = [[CustomImageView alloc] init];
    self.shopNameLabel = [[CustomLabel alloc] init];
    self.priceLabel    = [[CustomLabel alloc] init];
    self.dateLabel     = [[CustomLabel alloc] init];

    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.shopImageView];
    [self.backView addSubview:self.shopNameLabel];
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.dateLabel];
    
    [self configUI];
}

- (void)configUI
{
    self.selectionStyle                = UITableViewCellSelectionStyleNone;
    self.backgroundColor               = [UIColor clearColor];
    self.backView.frame                = CGRectMake(5, 5, [DeviceManager getDeviceWidth]-10, 90);
    self.backView.backgroundColor      = [UIColor whiteColor];

    self.shopImageView.frame           = CGRectMake(10, 20, 50, 50);
    self.shopImageView.backgroundColor = [UIColor grayColor];

    self.shopNameLabel.frame           = CGRectMake(self.shopImageView.right+5, 30, 150, 30);

    self.priceLabel.frame              = CGRectMake(self.backView.width-100, 30, 90, 30);
    self.priceLabel.textColor          = [UIColor redColor];

    self.dateLabel.frame               = CGRectMake(self.backView.width-100, self.priceLabel.bottom, 90, 15);
    self.dateLabel.font                = [UIFont systemFontOfSize:FontListTime];
    self.dateLabel.textColor           = [UIColor colorWithHexString:ColorDate];
}

- (void)setWithModel:(OrderModel *)model
{
//    self.shopImageView sd_setImageWithURL:<#(NSURL *)#>
    self.shopNameLabel.text = model.shop_name;
    self.priceLabel.text    = [NSString stringWithFormat:@"%@元", model.total_fee];
    self.dateLabel.text     = model.pay_date;
}

@end
