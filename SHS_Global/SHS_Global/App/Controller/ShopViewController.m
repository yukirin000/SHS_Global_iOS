//
//  ShopViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopModel.h"
#import "GoodsModel.h"
#import "LoginViewController.h"
#import "ChoiceCarsViewController.h"

@interface ShopViewController ()

//商店模型
@property (nonatomic, strong) ShopModel       * shopModel;
//商品模型
@property (nonatomic, strong) GoodsModel      * goodsModel;
//背景滚动视图
@property (nonatomic, strong) UIScrollView    * backScrollView;
//背景图
@property (nonatomic, strong) CustomImageView * backImageView;
//名字
@property (nonatomic, strong) CustomLabel     * shopNameLabel;
//距离
@property (nonatomic, strong) CustomLabel     * distanceLabel;
//位置
@property (nonatomic, strong) CustomLabel     * addressLabel;
//公司电话
@property (nonatomic, strong) CustomLabel     * shopPhoneLabel;
//原价
@property (nonatomic, strong) CustomLabel     * originPriceLabel;
//会员价
@property (nonatomic, strong) CustomLabel     * vipPriceLabel;

@end

@implementation ShopViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initWidget];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout

- (void)initWidget {
    
    self.backScrollView                              = [[UIScrollView alloc] init];
    self.backScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.backScrollView];
    
    self.backImageView    = [[CustomImageView alloc] init];
    self.shopNameLabel    = [[CustomLabel alloc] init];
    self.distanceLabel    = [[CustomLabel alloc] init];
    self.addressLabel     = [[CustomLabel alloc] init];
    self.shopPhoneLabel   = [[CustomLabel alloc] init];
    self.originPriceLabel = [[CustomLabel alloc] init];
    self.vipPriceLabel    = [[CustomLabel alloc] init];
    
    [self.backScrollView addSubview:self.backImageView];
    [self.backImageView addSubview:self.shopNameLabel];
    [self.backImageView addSubview:self.distanceLabel];
    [self.backScrollView addSubview:self.addressLabel];
    [self.backScrollView addSubview:self.shopPhoneLabel];
    [self.backScrollView addSubview:self.originPriceLabel];
    [self.backScrollView addSubview:self.vipPriceLabel];
}

- (void)configUI {
    
    [self setNavBarTitle:GlobalString(@"ShopTitle")];
    
    //设置内容
    self.shopNameLabel.text    = self.shopModel.shop_name;
    self.addressLabel.text     = self.shopModel.address;
    self.shopPhoneLabel.text   = self.shopModel.shop_phone;
    self.originPriceLabel.text = self.goodsModel.original_price;
    self.vipPriceLabel.text    = self.goodsModel.discount_price;
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.shopModel.shop_image]];
    
    
    //地理位置存在
    if ([[LocationService sharedInstance] existLocation:CGPointMake(self.shopModel.longitude.floatValue, self.shopModel.latitude.floatValue)]) {
        self.distanceLabel.text = [[LocationService sharedInstance] getDistanceWith:CGPointMake(self.shopModel.longitude.floatValue, self.shopModel.latitude.floatValue)];
    }
    
    //背景滚动视图
    self.backScrollView.frame              = CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight);
    self.backScrollView.backgroundColor    = [UIColor colorWithHexString:ColorBackGray];
    self.backScrollView.contentSize        = CGSizeMake(0, self.viewHeight-kNavBarAndStatusHeight-39);
    //背景图片
    self.backImageView.frame               = CGRectMake(0, 0, self.viewWidth, 170);
    self.backImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.backImageView.layer.masksToBounds = YES;
    //黑色条状背景
    UIView * nameBackView               = [[UIView alloc] initWithFrame:CGRectMake(0, self.backImageView.height-35, self.backImageView.width, 35)];
    nameBackView.backgroundColor        = [UIColor colorWithWhite:0.0 alpha:0.35];
    [self.backImageView addSubview:nameBackView];
    [self.backImageView sendSubviewToBack:nameBackView];
    
    //名字 距离
    self.shopNameLabel.frame            = CGRectMake(15, self.backImageView.height-35, 150, 35);
    self.shopNameLabel.textColor        = [UIColor colorWithHexString:ColorBackGray];
    self.shopNameLabel.font             = [UIFont systemFontOfSize:13];
    
    self.distanceLabel.frame            = CGRectMake(self.backImageView.width-150, self.backImageView.height-35, 135, 35);
    self.distanceLabel.textColor        = [UIColor colorWithHexString:ColorBackGray];
    self.distanceLabel.font             = [UIFont systemFontOfSize:13];
    self.distanceLabel.textAlignment    = NSTextAlignmentRight;
    
    //地址
    CustomLabel * addressTitleLabel = [[CustomLabel alloc] initWithFontSize:FontListName];
    addressTitleLabel.text          = GlobalString(@"ShopAddress");
    addressTitleLabel.frame         = CGRectMake(15, self.backImageView.bottom+15, 80, 15);
    addressTitleLabel.textColor     = [UIColor colorWithHexString:ColorShopBlack];
    [self.backScrollView addSubview:addressTitleLabel];

    self.addressLabel.frame             = CGRectMake(addressTitleLabel.right+10, self.backImageView.bottom, self.viewWidth-addressTitleLabel.right-25, 0);
    self.addressLabel.numberOfLines     = 0;
    self.addressLabel.font              = [UIFont systemFontOfSize:FontListName];
    self.addressLabel.textColor         = [UIColor colorWithHexString:ColorShopGray];
    [self.addressLabel sizeToFit];
    if (self.addressLabel.height < 50) {
        self.addressLabel.height = 50;
    }
    UIView * addressLine                = [[UIView alloc] initWithFrame:CGRectMake(15, self.addressLabel.bottom, self.viewWidth-15, 1)];
    addressLine.backgroundColor         = [UIColor colorWithHexString:ColorLineGray];
    [self.backScrollView addSubview:addressLine];

    //电话
    CustomLabel * phoneTitleLabel = [[CustomLabel alloc] initWithFontSize:FontListName];
    phoneTitleLabel.text          = GlobalString(@"ShopPhone");
    phoneTitleLabel.frame         = CGRectMake(15, addressLine.bottom, 80, 50);
    phoneTitleLabel.textColor     = [UIColor colorWithHexString:ColorShopBlack];
    [self.backScrollView addSubview:phoneTitleLabel];
    
    self.shopPhoneLabel.frame           = CGRectMake(self.addressLabel.x, addressLine.bottom, self.viewWidth-phoneTitleLabel.right-25, 50);
    self.shopPhoneLabel.font            = [UIFont systemFontOfSize:FontListName];
    self.shopPhoneLabel.textColor       = [UIColor colorWithHexString:ColorShopGray];
    self.shopPhoneLabel.textAlignment   = NSTextAlignmentRight;
    UIView * shopLine                   = [[UIView alloc] initWithFrame:CGRectMake(15, self.shopPhoneLabel.bottom, self.viewWidth-15, 1)];
    shopLine.backgroundColor            = [UIColor colorWithHexString:ColorLineGray];
    [self.backScrollView addSubview:shopLine];
    
    //服务项目
    CustomLabel * serverTitleLabel = [[CustomLabel alloc] initWithFontSize:FontListName];
    serverTitleLabel.text          = GlobalString(@"ShopServer");
    serverTitleLabel.frame         = CGRectMake(15, shopLine.bottom, 80, 50);
    serverTitleLabel.textColor     = [UIColor colorWithHexString:ColorShopBlack];
    [self.backScrollView addSubview:serverTitleLabel];
    
    CustomLabel * washTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(self.addressLabel.x, shopLine.bottom, self.viewWidth-phoneTitleLabel.right-25, 50)];
    washTitle.font          = [UIFont systemFontOfSize:FontListName];
    washTitle.textColor     = [UIColor colorWithHexString:ColorShopGray];
    washTitle.textAlignment = NSTextAlignmentRight;
    washTitle.text          = @"精洗";
    [self.backScrollView addSubview:washTitle];

    UIView * washLine        = [[UIView alloc] initWithFrame:CGRectMake(15, serverTitleLabel.bottom, self.viewWidth-15, 1)];
    washLine.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
    [self.backScrollView addSubview:washLine];
    
    //呼叫管家
    CustomLabel * originTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(serverTitleLabel.x, washLine.bottom, 50, 50)];
    originTitle.font          = [UIFont systemFontOfSize:FontListName];
    originTitle.textColor     = [UIColor colorWithHexString:ColorShopBlack];
    originTitle.text          = @"原价：";
    [self.backScrollView addSubview:originTitle];
    
    CustomLabel * userTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-120, washLine.bottom, 60, 50)];
    userTitle.font          = [UIFont systemFontOfSize:FontListName];
    userTitle.textColor     = [UIColor colorWithHexString:ColorShopBlack];
    userTitle.text          = @"会员价：";
    [self.backScrollView addSubview:userTitle];
    
    //价格位置
    self.originPriceLabel.frame     = CGRectMake(originTitle.right, originTitle.y, 65, 50);
    self.originPriceLabel.textColor = originTitle.textColor;
    self.originPriceLabel.font      = originTitle.font;
    self.vipPriceLabel.frame        = CGRectMake(userTitle.right, userTitle.y, 65, 50);
    self.vipPriceLabel.textColor    = [UIColor redColor];
    self.vipPriceLabel.font         = originTitle.font;
    
    UIView * backGrayView        = [[UIView alloc] initWithFrame:CGRectMake(0, self.backImageView.bottom, self.viewWidth, userTitle.bottom-self.backImageView.bottom)];
    backGrayView.backgroundColor = [UIColor colorWithHexString:ColorWhite];
    [self.backScrollView addSubview:backGrayView];
    [self.backScrollView sendSubviewToBack:backGrayView];
    
    CustomButton * bottomBtn      = [[CustomButton alloc] initWithFrame:CGRectMake(kCenterOriginX(220), userTitle.bottom+50, 220, 45)];
    bottomBtn.backgroundColor     = [UIColor colorWithHexString:ColorWhite];
    bottomBtn.layer.cornerRadius  = 22.5;
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.borderWidth   = 1;
    bottomBtn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    bottomBtn.titleLabel.font     = [UIFont systemFontOfSize:14];
    [bottomBtn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"购买" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.backScrollView addSubview:bottomBtn];
    
    if (self.backScrollView.height > bottomBtn.bottom) {
        self.backScrollView.contentSize = CGSizeMake(0, self.backScrollView.height+1);
    }else{
        self.backScrollView.contentSize = CGSizeMake(0, bottomBtn.bottom);
    }

}

#pragma mark- method resopnse
- (void)bottomPress:(id)sender
{
    //新用户提示注册
    if ([UserService sharedService].user.user_id < 1) {
        
        [YSAlertView showAlertWithTitle:StringCommonPrompt message:@"您还不是用户，请先成为用户" completionBlock:^(NSUInteger buttonIndex, YSAlertView *alertView) {
            if (buttonIndex == 1) {
                LoginViewController * lvc    = [[LoginViewController alloc] init];
                lvc.hideNavbar               = YES;
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lvc];
                [self presentViewController:nav animated:YES completion:^{
                }];
            }
        } cancelButtonTitle:@"先看看" otherButtonTitles:@"成为用户", nil];
        return;
    }else{
        ChoiceCarsViewController * ccvc = [[ChoiceCarsViewController alloc] init];
        ccvc.shop_id                    = self.shopId;
        ccvc.goods_id                   = self.goodsModel.gid;
        [self pushVC:ccvc];
    }
}


#pragma mark- Delegate & Datasource

#pragma mark- private method
- (void)initData {
    
    NSString * url = [NSString stringWithFormat:@"%@?shop_id=%ld", API_GetShopDetail, self.shopId];
    debugLog(@"%@", url);
    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == 1) {
            
            NSDictionary * shopDic = responseData[HttpResult][@"shop"];
            self.shopModel = [[ShopModel alloc] init];
            [self.shopModel setModelWithDic:shopDic];
            
            NSDictionary * goodsDic = responseData[HttpResult][@"good"];
            if (goodsDic) {
                self.goodsModel = [[GoodsModel alloc] init];
                [self.goodsModel setModelWithDic:goodsDic];
            }
            
            [self configUI];
        }else{
            [self showFail:StringCommonDownloadDataFail];
        }
        
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];

}


@end
