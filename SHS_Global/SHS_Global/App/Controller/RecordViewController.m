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
    self.servedVC.hideNavbar = YES;
    self.servedVC.isServing  = NO;
    //服务中
    self.servingVC            = [[RecordServerViewController alloc] init];
    self.servingVC.hideNavbar = YES;
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
    
    self.scrollView.frame                          = CGRectMake(0, kNavBarAndStatusHeight+30, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-kTabBarHeight-30);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize                    = CGSizeMake(self.viewWidth*2, self.scrollView.height);
    self.scrollView.pagingEnabled                  = YES;

    self.servingVC.view.frame = CGRectMake(0, 0, self.viewWidth, self.scrollView.height);
    self.servedVC.view.frame  = CGRectMake(self.viewWidth, 0, self.viewWidth, self.scrollView.height);
    
    self.servingBtn           = [self tabBtnWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth/2, 30) andTitle:@"服务中" andTag:1];
    self.servedBtn            = [self tabBtnWithFrame:CGRectMake(self.viewWidth/2, kNavBarAndStatusHeight, self.viewWidth/2, 30) andTitle:@"已服务" andTag:2];
    
    self.servingBtn.selected  = YES;
}

#pragma mark- method response
- (void)changeTab:(CustomButton *)sender {
    
    if (sender.tag == 1) {
        self.servingBtn.selected = YES;
        self.servedBtn.selected  = NO;
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.viewWidth, 1) animated:YES];
    }else{
        self.servingBtn.selected = NO;
        self.servedBtn.selected  = YES;
        [self.scrollView scrollRectToVisible:CGRectMake(self.viewWidth, 0, self.viewWidth, 1) animated:YES];
    }
}

#pragma mark- Delegate & Datasource
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.viewWidth) {
        self.servingBtn.selected = NO;
        self.servedBtn.selected  = YES;
    }else if(scrollView.contentOffset.x <= 0){
        self.servingBtn.selected = YES;
        self.servedBtn.selected  = NO;
    }
}

#pragma mark- private method
- (CustomButton *)tabBtnWithFrame:(CGRect)frame andTitle:(NSString *)title andTag:(NSInteger)tag {
    
    CustomButton * btn = [[CustomButton alloc] initWithFrame:frame];
    [btn setTag:tag];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    return btn;
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
