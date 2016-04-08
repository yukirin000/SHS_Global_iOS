//
//  ViewController2.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:ColorBackGray];

    CustomLabel * titleLabel  = [[CustomLabel alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight+50, self.viewWidth, 30)];
    titleLabel.font           = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment  = NSTextAlignmentCenter;
    titleLabel.textColor      = [UIColor colorWithHexString:@"646464"];
    titleLabel.text           = @"app正在开发";
    [self.view addSubview:titleLabel];

    CustomLabel * descLabel             = [[CustomLabel alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight+100, self.viewWidth, 30)];
    descLabel.font                      = [UIFont systemFontOfSize:13];
    descLabel.textAlignment             = NSTextAlignmentCenter;
    NSMutableAttributedString * content = [[NSMutableAttributedString alloc] initWithString:@"关注“品位环球”公众号更多高端服务敬请享受"];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(3, 4)];
    descLabel.attributedText            = content;
    descLabel.textColor                 = [UIColor colorWithHexString:@"646464"];
    [self.view addSubview:descLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
