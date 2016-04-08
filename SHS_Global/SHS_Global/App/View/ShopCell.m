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
    
    UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(15, 109, [DeviceManager getDeviceWidth]-15, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
    [self.contentView addSubview:lineView];
    
    [self configUI];
}

- (void)configUI
{
    self.coverImageView.frame               = CGRectMake(15, 15, 100, 80);
    self.coverImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.coverImageView.layer.cornerRadius  = 1;
    self.coverImageView.layer.masksToBounds = YES;

    self.nameLabel.frame                = CGRectMake(self.coverImageView.right+10, self.coverImageView.y+18, [DeviceManager getDeviceWidth]-self.coverImageView.right-20, 15);
    self.nameLabel.font                 = [UIFont systemFontOfSize:FontListName];
    self.nameLabel.numberOfLines        = 1;

    CustomImageView * addressImageView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"address"]];
    addressImageView.frame             = CGRectMake(self.coverImageView.right+10, self.nameLabel.bottom+15, 12, 14);
    [self.contentView addSubview:addressImageView];
    
    self.addressLabel.frame             = CGRectMake(addressImageView.right+5, addressImageView.y, [DeviceManager getDeviceWidth]-addressImageView.right-95, 12);
    self.addressLabel.lineBreakMode     = NSLineBreakByTruncatingTail;
    self.addressLabel.font              = [UIFont systemFontOfSize:FontListContent];
    self.addressLabel.textColor         = [UIColor colorWithHexString:ColorContent];

    self.distanceLabel.frame            = CGRectMake([DeviceManager getDeviceWidth]-70, self.addressLabel.y, 55, 12);
    self.distanceLabel.font             = [UIFont systemFontOfSize:FontListContent];
    self.distanceLabel.textColor        = [UIColor colorWithHexString:ColorContent];
    
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
