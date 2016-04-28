//
//  ViewController2.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordServerViewController.h"

@interface RecordViewController ()

@property (nonatomic, strong) UIScrollView * scrollView;
//服务中按钮
@property (nonatomic, strong) CustomButton * servingBtn;
//已经服务按钮
@property (nonatomic, strong) CustomButton * servedBtn;
//服务完
@property (nonatomic, strong) RecordServerViewController * servedVC;
//服务中
@property (nonatomic, strong) RecordServerViewController * servingVC;

@end

@implementation RecordViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- layout

- (void)initWidget {

    //已服务
    self.servedVC            = [[RecordServerViewController alloc] init];
    self.servedVC.isServing  = NO;
    //服务中
    self.servingVC            = [[RecordServerViewController alloc] init];
    self.servingVC.isServing  = YES;

    self.scrollView          = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    
    [self addChildViewController:self.servingVC];
    [self addChildViewController:self.servedVC];
    
    [self.scrollView addSubview:self.servingVC.view];
    [self.scrollView addSubview:self.servedVC.view];
    [self.view addSubview:self.scrollView];
    
    [self configUI];
}

- (void)configUI {
    
    self.scrollView.frame                          = CGRectMake(0, kNavBarAndStatusHeight+45, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-kTabBarHeight-30);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize                    = CGSizeMake(self.viewWidth*2, self.scrollView.height);
    self.scrollView.pagingEnabled                  = YES;

    self.servingVC.view.frame = CGRectMake(0, 0, self.viewWidth, self.scrollView.height);
    self.servedVC.view.frame  = CGRectMake(self.viewWidth, 0, self.viewWidth, self.scrollView.height);
    
    self.servingBtn           = [self tabBtnWithFrame:CGRectMake(15, kNavBarAndStatusHeight+10, self.viewWidth/2-15, 35) andTitle:GlobalString(@"OrderHasPay") andTag:1];
    
    self.servedBtn            = [self tabBtnWithFrame:CGRectMake(self.viewWidth/2, kNavBarAndStatusHeight+10, self.viewWidth/2-15, 35) andTitle:GlobalString(@"OrderHasUse") andTag:2];
    
    UIBezierPath *maskPath     = [UIBezierPath bezierPathWithRoundedRect:self.servingBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer    = [[CAShapeLayer alloc] init];
    maskLayer.frame            = self.servingBtn.bounds;
    maskLayer.path             = maskPath.CGPath;
    maskLayer.masksToBounds    = 5;
    self.servingBtn.layer.mask = maskLayer;
    
    UIBezierPath *maskPath2   = [UIBezierPath bezierPathWithRoundedRect:self.servedBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer2  = [[CAShapeLayer alloc] init];
    maskLayer2.frame          = self.servedBtn.bounds;
    maskLayer2.path           = maskPath2.CGPath;
    self.servedBtn.layer.mask = maskLayer2;
    
    [self serveSet:YES];
}

#pragma mark- method response
- (void)changeTab:(CustomButton *)sender {
    
    if (sender.tag == 1) {
        [self serveSet:YES];
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.viewWidth, 1) animated:YES];
    }else{
        [self serveSet:NO];
        [self.scrollView scrollRectToVisible:CGRectMake(self.viewWidth, 0, self.viewWidth, 1) animated:YES];
    }
}

#pragma mark- Delegate & Datasource
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.viewWidth) {
        [self serveSet:NO];
    }else if(scrollView.contentOffset.x <= 0){
        [self serveSet:YES];
    }
}

#pragma mark- private method
- (CustomButton *)tabBtnWithFrame:(CGRect)frame andTitle:(NSString *)title andTag:(NSInteger)tag {
    
    CustomButton * btn = [[CustomButton alloc] initWithFrame:frame];
    [btn setTag:tag];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"3A3A3A"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font   = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:btn];
    
    return btn;
}

- (void)serveSet:(BOOL)isServing {
    
    if (isServing) {
        [self.servingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.servedBtn setTitleColor:[UIColor colorWithHexString:@"3A3A3A"] forState:UIControlStateNormal];
        
        [self.servingBtn setBackgroundColor:[UIColor colorWithHexString:@"3A3A3A"]];
        [self.servedBtn setBackgroundColor:[UIColor whiteColor]];
    }else{
        [self.servedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.servingBtn setTitleColor:[UIColor colorWithHexString:@"3A3A3A"] forState:UIControlStateNormal];
        [self.servingBtn setBackgroundColor:[UIColor whiteColor]];
        [self.servedBtn setBackgroundColor:[UIColor colorWithHexString:@"3A3A3A"]];
    }
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
