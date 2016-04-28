//
//  RecordCell.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RecordCell.h"

@interface RecordCell()

//背景图片
@property (nonatomic, strong) CustomImageView * backView;
//商店图片
@property (nonatomic, strong) CustomImageView * shopImageView;
//商店名
@property (nonatomic, strong) CustomLabel     * shopNameLabel;
//价格
@property (nonatomic, strong) CustomLabel     * priceLabel;
//日期
@property (nonatomic, strong) CustomLabel     * dateLabel;
//状态
@property (nonatomic, strong) CustomLabel     * stateLabel;

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
    self.backView      = [[CustomImageView alloc] init];
    self.shopImageView = [[CustomImageView alloc] init];
    self.shopNameLabel = [[CustomLabel alloc] init];
    self.priceLabel    = [[CustomLabel alloc] init];
    self.dateLabel     = [[CustomLabel alloc] init];
    self.stateLabel    = [[CustomLabel alloc] init];

    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.shopImageView];
    [self.backView addSubview:self.shopNameLabel];
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.dateLabel];
    [self.contentView addSubview:self.stateLabel];
    
    [self configUI];
}

- (void)configUI
{
    self.selectionStyle                = UITableViewCellSelectionStyleNone;
    self.backgroundColor               = [UIColor clearColor];
    self.backView.frame                = CGRectMake(19, 20, [DeviceManager getDeviceWidth]-38, 133);
    self.backView.image                = [UIImage imageNamed:@"record_bg"];
    self.backView.contentMode          = UIViewContentModeScaleAspectFill;
    self.backView.layer.cornerRadius   = 13;
    self.backView.layer.masksToBounds  = YES;

    self.shopImageView.frame               = CGRectMake(16, 34, 65, 65);
    self.shopImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.shopImageView.layer.masksToBounds = YES;
    self.shopImageView.layer.cornerRadius  = 32.5;

    self.shopNameLabel.frame     = CGRectMake(self.shopImageView.right+11, self.shopImageView.y+15, 150, 15);
    self.shopNameLabel.font      = [UIFont systemFontOfSize:FontListName];
    self.shopNameLabel.textColor = [UIColor colorWithHexString:ColorWhite];
    
    self.dateLabel.frame     = CGRectMake(self.shopNameLabel.x, self.shopNameLabel.bottom+9, 150, 13);
    self.dateLabel.font      = [UIFont systemFontOfSize:FontListTime];
    self.dateLabel.textColor = [UIColor colorWithHexString:@"B1B1B1"];
    
    self.priceLabel.frame         = CGRectMake(self.backView.width-95, 50, 70, 33);
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.font          = [UIFont systemFontOfSize:33];
    self.priceLabel.textColor     = [UIColor colorWithHexString:ColorWhite];
    
    CustomLabel * yuanLabel = [[CustomLabel alloc] initWithFontSize:14];
    yuanLabel.frame         = CGRectMake(self.priceLabel.right, self.priceLabel.y+15, 14, 14);
    yuanLabel.text          = @"元";
    yuanLabel.textColor     = [UIColor colorWithHexString:ColorWhite];
    [self.backView addSubview:yuanLabel];
    
    self.stateLabel.frame               = CGRectMake(self.backView.right-47, 10, 50, 20);
    self.stateLabel.layer.cornerRadius  = 3;
    self.stateLabel.layer.masksToBounds = YES;
    self.stateLabel.textColor           = [UIColor colorWithHexString:ColorWhite];
    self.stateLabel.backgroundColor     = [UIColor colorWithHexString:@"E5D19D"];
    self.stateLabel.font                = [UIFont systemFontOfSize:11];
    self.stateLabel.textAlignment       = NSTextAlignmentCenter;
}

- (void)setWithModel:(OrderModel *)model
{
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.shop_image]];
    self.shopNameLabel.text = model.shop_name;
    self.priceLabel.text    = model.total_fee;
    if (model.state == OrderHasPay) {
        self.dateLabel.text  = model.pay_date;
        self.stateLabel.text = @"可使用";
    }else{
        self.dateLabel.text  = model.use_date;
        self.stateLabel.text = @"已使用";
    }
    
}

@end
