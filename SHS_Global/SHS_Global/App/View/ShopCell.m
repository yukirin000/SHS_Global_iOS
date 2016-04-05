//
//  ShopCell.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ShopCell.h"

@interface ShopCell()

@property (nonatomic, strong) CustomImageView * coverImageView;

@property (nonatomic, strong) CustomLabel     * nameLabel;

@property (nonatomic, strong) CustomLabel     * addressLabel;

@property (nonatomic, strong) CustomLabel     * distanceLabel;

@end

@implementation ShopCell

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
    self.coverImageView = [[CustomImageView alloc] init];
    self.nameLabel      = [[CustomLabel alloc] init];
    self.addressLabel   = [[CustomLabel alloc] init];
    self.distanceLabel  = [[CustomLabel alloc] init];
    
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.distanceLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119, [DeviceManager getDeviceWidth], 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];
    
    [self configUI];
}

- (void)configUI
{
    self.coverImageView.frame               = CGRectMake(5, 5, 100, 100);
    self.coverImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.coverImageView.backgroundColor     = [UIColor grayColor];
    self.coverImageView.layer.masksToBounds = YES;

    self.nameLabel.frame                = CGRectMake(self.coverImageView.right+5, self.coverImageView.y+5, [DeviceManager getDeviceWidth]-self.coverImageView.right-10, 30);
    self.nameLabel.numberOfLines        = 2;

    self.addressLabel.frame             = CGRectMake(self.coverImageView.right+5, self.nameLabel.bottom+5, [DeviceManager getDeviceWidth]-self.coverImageView.right-10, 30);
    self.addressLabel.font              = [UIFont systemFontOfSize:12];
    self.addressLabel.textColor         = [UIColor lightGrayColor];
    self.addressLabel.numberOfLines     = 2;

    self.distanceLabel.frame            = CGRectMake(self.coverImageView.right+5, self.addressLabel.bottom+5, 200, 20);
    
}

- (void)setWithModel:(ShopModel *)model
{
    self.nameLabel.text     = model.shop_name;
    self.addressLabel.text  = model.address;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.shop_image_thumb]];
    //地理位置存在
    if ([[LocationService sharedInstance] existLocation:CGPointMake(model.longitude.floatValue, model.latitude.floatValue)]) {
        self.distanceLabel.text = [NSString stringWithFormat:@"%@km", [[LocationService sharedInstance] getDistanceWith:CGPointMake(model.longitude.floatValue, model.latitude.floatValue)]];
    }

}

@end
