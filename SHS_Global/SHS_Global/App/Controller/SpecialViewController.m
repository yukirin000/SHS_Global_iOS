//
//  ViewController1.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "SpecialViewController.h"
#import "ShopListViewController.h"
#import "TempServerViewController.h"

@interface SpecialViewController ()

//背景
@property (nonatomic, strong) UIScrollView * backScroll;

@end

@implementation SpecialViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout

- (void)initWidget{

    self.backScroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.backScroll];
    
    [self configUI];
}

- (void)configUI{

    //这里苹果有一个奇怪的检测 我不得不这么做 没找到关闭的地方。
    self.navBar.hidden = YES;
    NavBar * nb        = [[NavBar alloc] init];
    nb.backgroundColor = [UIColor clearColor];
    nb.frame           = self.navBar.frame;
    nb.titleLabel.text = self.navBar.titleLabel.text;
    [self.view addSubview:nb];
    
    self.backScroll.frame                        = CGRectMake(0, 0, self.viewWidth, self.viewHeight-kTabBarHeight);
    self.backScroll.showsVerticalScrollIndicator = NO;
    self.backScroll.contentSize                  = CGSizeMake(0, 610);

    UIImageView * backImage                      = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 265)];
    backImage.image                              = [UIImage imageNamed:@"home_bg"];
    backImage.contentMode                        = UIViewContentModeScaleAspectFill;
    backImage.layer.masksToBounds                = YES;
    [self.backScroll addSubview:backImage];
    //按钮
    [self factoryBtnWithRect:CGRectMake(0, backImage.bottom, self.viewWidth/2, 153) title:GlobalString(@"SpecialWash") image:@"home_btn_cosmetology" SEL:@selector(shopListPress:)];
    [self factoryBtnWithRect:CGRectMake(self.viewWidth/2, backImage.bottom, self.viewWidth/2, 153) title:GlobalString(@"SpecialRepair") image:@"home_btn_service" SEL:@selector(temp2Press:)];
    [self factoryBtnWithRect:CGRectMake(0, backImage.bottom+153, self.viewWidth/2, 153) title:GlobalString(@"SpecialConsult") image:@"home_btn_inquiry" SEL:@selector(temp1Press:)];
    [self factoryBtnWithRect:CGRectMake(self.viewWidth/2, backImage.bottom+153, self.viewWidth/2, 153) title:GlobalString(@"SpecialOnline") image:@"home_btn_consult" SEL:@selector(temp1Press:)];
    //线
    UIView * horzontalView        = [[UIView alloc] initWithFrame:CGRectMake(0, 418, self.viewWidth, 1)];
    horzontalView.backgroundColor = [UIColor colorWithHexString:ColorLineGray];

    UIView * verticalView         = [[UIView alloc] initWithFrame:CGRectMake(self.viewWidth/2, 265, 1, 306)];
    verticalView.backgroundColor  = [UIColor colorWithHexString:ColorLineGray];
    [self.backScroll addSubview:verticalView];
    [self.backScroll addSubview:horzontalView];
    
}

#pragma mark- method response
- (void)temp1Press:(id)sender
{
    TempServerViewController * tsvc = [[TempServerViewController alloc] init];
    tsvc.type                       = 1;
    [self pushVC:tsvc];
}

- (void)temp2Press:(id)sender
{
    TempServerViewController * tsvc = [[TempServerViewController alloc] init];
    tsvc.type                       = 2;
    [self pushVC:tsvc];
}

- (void)shopListPress:(id)sender
{
    ShopListViewController * svc = [[ShopListViewController alloc] init];
    [self pushVC:svc];
}

#pragma mark- private method
- (void)factoryBtnWithRect:(CGRect)frame title:(NSString *)title image:(NSString *)image SEL:(SEL)selecotr {
    
    CustomButton * backBtn      = [[CustomButton alloc] initWithFrame:frame];
    backBtn.backgroundColor     = [UIColor colorWithHexString:ColorWhite];
    CustomImageView * imageView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.frame             = CGRectMake((frame.size.width-70)/2, 35, 70, 70);
    CustomLabel * titleLabel    = [[CustomLabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+14, frame.size.width, 13)];
    titleLabel.text             = title;
    titleLabel.font             = [UIFont systemFontOfSize:13];
    titleLabel.textColor        = [UIColor colorWithHexString:ColorTabNormal];
    titleLabel.textAlignment    = NSTextAlignmentCenter;

    [backBtn addSubview:imageView];
    [backBtn addSubview:titleLabel];
    [self.backScroll addSubview:backBtn];
    
    [backBtn addTarget:self action:selecotr forControlEvents:UIControlEventTouchUpInside];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
