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
    
    for (int i=0; i<self.dataSource.count; i++) {
        [self generateCommonListWithTop:kNavBarAndStatusHeight+20+i*25 andContent:self.dataSource[i]];
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
