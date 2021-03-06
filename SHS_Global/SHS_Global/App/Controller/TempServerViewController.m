//
//  TempServerViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "TempServerViewController.h"

@interface TempServerViewController ()

@property (nonatomic, strong) NSArray     * dataSource;

@end

@implementation TempServerViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout

- (void)initWidget{
    
}


- (void)configUI{
    
    if (self.type == 3) {
        self.view.backgroundColor = [UIColor whiteColor];
        CustomLabel * tmpLabel = [[CustomLabel alloc] initWithFontSize:14];
        tmpLabel.textColor     = [UIColor colorWithHexString:@"272636"];
        tmpLabel.frame         = CGRectMake(kCenterOriginX((self.viewWidth-40)), kNavBarAndStatusHeight+30, self.viewWidth-40, 0);
        tmpLabel.text          = @"1、豪车管家24小时电话问诊及资讯，专业的豪车管家将为您提供一切关于您爱车的最佳解决方案。\n\n2、会员卡价格享受爱车精洗项目，无需再办理门店会员卡。此礼遇适用于全平台联盟商家。\n\n3、豪车维修与保养将由专业的豪车管家为您一站式打理，轻松，高效的完成每一个环节。\n\n4、“品味•环球”作为第三方服务平台将为本平台所有联盟商家的服务及产品做质量担保，杜绝任何虚假，伪劣产品，为会员权益提供双重保证。";
        tmpLabel.numberOfLines = 0;
        [tmpLabel sizeToFit];
        [self.view addSubview:tmpLabel];
        
        [self setNavBarTitle:@"礼遇"];
    }else{
        if (self.type == 1) {
            
            CustomLabel * tmpLabel = [[CustomLabel alloc] initWithFontSize:14];
            tmpLabel.frame         = CGRectMake(0, kNavBarAndStatusHeight+150, self.viewWidth, 30);
            tmpLabel.text          = @"更多详情请咨询豪车管家";
            tmpLabel.textAlignment = NSTextAlignmentCenter;
            tmpLabel.textColor     = [UIColor colorWithHexString:@"272636"];
            [self.view addSubview:tmpLabel];
            
        }else if (self.type == 2){
            self.view.backgroundColor = [UIColor whiteColor];
            CustomLabel * tmpLabel    = [[CustomLabel alloc] initWithFontSize:14];
            tmpLabel.frame            = CGRectMake(kCenterOriginX((self.viewWidth-40)), kNavBarAndStatusHeight+30, self.viewWidth-40, 0);
            tmpLabel.text          = @"会员可以在线免费咨询，随时随地咨询您的爱车在使用过程中所碰到的任何问题，我们将由专家团队为您耐心解答，时时刻刻站在您的角度，并为您提出合理的建议，让您省时、省钱、更省心！";
            tmpLabel.numberOfLines = 0;
            tmpLabel.textColor     = [UIColor colorWithHexString:@"272636"];            
            [tmpLabel sizeToFit];
            [self.view addSubview:tmpLabel];
            
        }
        
        CustomButton * bottomBtn      = [[CustomButton alloc] initWithFrame:CGRectMake(kCenterOriginX(220), kNavBarAndStatusHeight+260, 220, 45)];
        bottomBtn.backgroundColor     = [UIColor colorWithHexString:ColorWhite];
        bottomBtn.layer.cornerRadius  = 22.5;
        bottomBtn.layer.masksToBounds = YES;
        bottomBtn.layer.borderWidth   = 1;
        bottomBtn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
        bottomBtn.titleEdgeInsets     = UIEdgeInsetsMake(0, 20, 0, 0);
        bottomBtn.titleLabel.font     = [UIFont systemFontOfSize:14];
        [bottomBtn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
        [bottomBtn setTitle:GlobalString(@"GlobalCallBulter") forState:UIControlStateNormal];
        [bottomBtn setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(bottomPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bottomBtn];
        
        [self setNavBarTitle:@"服务"];
    }
    
}

#pragma mark- method response


#pragma mark- private method
- (void)initData{
    self.dataSource = @[@"精洗车辆",@"内饰清洁",@"漆面抛光、打蜡",@"漆面镀膜、镀晶",@"汽车隔热膜",@"改色贴膜",@"汽车表面透明膜"];
}

- (CGFloat)generateCommonListWithTop:(CGFloat)top andContent:(NSString *)content
{
    CustomImageView * descImageView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"list"]];
    descImageView.frame             = CGRectMake(15, top, 8, 8);
    [self.view addSubview:descImageView];
    
    CustomLabel * descLabel1 = [[CustomLabel alloc] initWithFrame:CGRectMake(descImageView.right+10, descImageView.y-3, self.viewWidth-48, 0)];
    descLabel1.numberOfLines = 0;
    descLabel1.font          = [UIFont systemFontOfSize:14];
    descLabel1.text          = content;
    [self.view addSubview:descLabel1];
    [descLabel1 sizeToFit];
    
    return descLabel1.bottom;
}

#pragma mark- method resopnse
- (void)bottomPress:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008693911"]];
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
