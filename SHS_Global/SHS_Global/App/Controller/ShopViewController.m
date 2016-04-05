//
//  ShopViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopModel.h"

@interface ShopViewController ()

//商店模型
@property (nonatomic, strong) ShopModel       * shopModel;
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
    
    self.backImageView  = [[CustomImageView alloc] init];
    self.shopNameLabel  = [[CustomLabel alloc] init];
    self.distanceLabel  = [[CustomLabel alloc] init];
    self.addressLabel   = [[CustomLabel alloc] init];
    self.shopPhoneLabel = [[CustomLabel alloc] init];
    
    [self.backScrollView addSubview:self.backImageView];
    [self.backImageView addSubview:self.shopNameLabel];
    [self.backImageView addSubview:self.distanceLabel];
    [self.backScrollView addSubview:self.addressLabel];
    [self.backScrollView addSubview:self.shopPhoneLabel];
    

}

- (void)configUI {
    
    //背景滚动视图
    self.backScrollView.frame              = CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-40);
    self.backScrollView.backgroundColor    = [UIColor grayColor];
    self.backScrollView.contentSize        = CGSizeMake(0, self.viewHeight-kNavBarAndStatusHeight-39);
    //背景图片
    self.backImageView.frame               = CGRectMake(0, 0, self.viewWidth, 150);
    self.backImageView.backgroundColor     = [UIColor lightGrayColor];
    self.backImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.backImageView.layer.masksToBounds = YES;
    //黑色条状背景
    UIView * nameBackView               = [[UIView alloc] initWithFrame:CGRectMake(0, self.backImageView.height-25, self.backImageView.width, 25)];
    nameBackView.backgroundColor        = [UIColor colorWithWhite:0.8 alpha:0.9];
    [self.backImageView addSubview:nameBackView];
    [self.backImageView sendSubviewToBack:nameBackView];
    
    //名字 距离
    self.shopNameLabel.frame            = CGRectMake(10, self.backImageView.height-25, 150, 25);
    self.distanceLabel.frame            = CGRectMake(self.backImageView.width-150, self.backImageView.height-25, 140, 25);
    self.distanceLabel.textAlignment    = NSTextAlignmentRight;
    //地址 电话
    self.addressLabel.frame             = CGRectMake(10, self.backImageView.bottom, self.viewWidth-20, 29);
    self.addressLabel.font              = [UIFont systemFontOfSize:14];
    UIView * addressLine                = [[UIView alloc] initWithFrame:CGRectMake(0, self.addressLabel.bottom, self.viewWidth, 1)];
    addressLine.backgroundColor         = [UIColor whiteColor];
    [self.backScrollView addSubview:addressLine];

    self.shopPhoneLabel.frame           = CGRectMake(10, self.addressLabel.bottom+1, self.viewWidth-20, 29);
    self.shopPhoneLabel.font            = [UIFont systemFontOfSize:14];
    UIView * shopLine                   = [[UIView alloc] initWithFrame:CGRectMake(0, self.shopPhoneLabel.bottom, self.viewWidth, 1)];
    shopLine.backgroundColor            = [UIColor whiteColor];
    [self.backScrollView addSubview:shopLine];
    
    //服务项目 呼叫管家
    CustomLabel * serverTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(10, self.shopPhoneLabel.bottom+10, 100, 20)];
    serverTitle.font          = [UIFont systemFontOfSize:16];
    serverTitle.text          = @"服务项目";
    [self.backScrollView addSubview:serverTitle];
    
    CustomLabel * washTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(10, serverTitle.bottom+5, 40, 20)];
    washTitle.font          = [UIFont systemFontOfSize:14];
    washTitle.textColor     = [UIColor darkGrayColor];
    washTitle.text          = @"精洗";
    [self.backScrollView addSubview:washTitle];
    
    CustomLabel * originTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(washTitle.right+30, serverTitle.bottom+5, 80, 20)];
    originTitle.font          = [UIFont systemFontOfSize:14];
    originTitle.textColor     = [UIColor darkGrayColor];
    originTitle.text          = @"原价：***";
    [self.backScrollView addSubview:originTitle];
    
    CustomLabel * userTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(originTitle.right+10, serverTitle.bottom+5, 80, 20)];
    userTitle.font          = [UIFont systemFontOfSize:14];
    userTitle.textColor     = [UIColor darkGrayColor];
    userTitle.text          = @"会员价：***";
    [self.backScrollView addSubview:userTitle];
    
    CustomLabel * waitTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-90, serverTitle.bottom+5, 80, 20)];
    waitTitle.font          = [UIFont systemFontOfSize:16];
    waitTitle.textColor     = [UIColor cyanColor];
    waitTitle.text          = @"即将开放";
    [self.backScrollView addSubview:waitTitle];
    
    
    CustomButton * bottomBtn  = [[CustomButton alloc] initWithFrame:CGRectMake(0, self.viewHeight-40, self.viewWidth, 40)];
    bottomBtn.backgroundColor = [UIColor blackColor];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"一键呼叫管家" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    //设置内容
    self.shopNameLabel.text  = self.shopModel.shop_name;
    self.addressLabel.text   = self.shopModel.address;
    self.shopPhoneLabel.text = self.shopModel.shop_phone;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.shopModel.shop_image]];
    
    //地理位置存在
    if ([[LocationService sharedInstance] existLocation:CGPointMake(self.shopModel.longitude.floatValue, self.shopModel.latitude.floatValue)]) {
        self.distanceLabel.text = [NSString stringWithFormat:@"%@km", [[LocationService sharedInstance] getDistanceWith:CGPointMake(self.shopModel.longitude.floatValue, self.shopModel.latitude.floatValue)]];
    }
}

#pragma mark- method resopnse
- (void)bottomPress:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008693911"]];
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
            [self configUI];
        }else{
            [self showFail:@"获取失败"];
        }
        
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];

}


@end
