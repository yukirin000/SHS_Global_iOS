//
//  CarDetailViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "CarDetailViewController.h"
#import "ApplyCarViewController.h"
#import "CarModel.h"

@interface CarDetailViewController ()

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) CarModel * carModel;

@property (nonatomic, strong) NSArray * titleArr;

@end

@implementation CarDetailViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initWidget];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout

- (void)initWidget {
    
    [self configUI];
}

- (void)initTable
{
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight) style:UITableViewStylePlain];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces                      = NO;
    [self.view addSubview:self.tableView];
}

- (void)configUI {
    [self setNavBarTitle:@"我的爱车"];
}

#pragma mark- method response

- (void)resubmit {
    
    ApplyCarViewController * acvc = [[ApplyCarViewController alloc] init];
    acvc.carModel                 = self.carModel;
    [self pushVC:acvc];
}

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (!cell) {
        cell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.titleArr[indexPath.row];

        if (indexPath.row < 4) {
            CustomLabel * label = [[CustomLabel alloc] init];
            label.frame         = CGRectMake(self.viewWidth-200, 0, 170, 60);
            label.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:label];
            switch (indexPath.row) {
                case 0:
                    label.text = self.carModel.name;
                    break;
                case 1:
                    label.text = self.carModel.mobile;
                    break;
                case 2:
                    label.text = self.carModel.plate_number;
                    break;
                case 3:
                    label.text = self.carModel.car_type;
                    break;
                default:
                    break;
            }
            
        }else{
            CustomImageView * imageView   = [[CustomImageView alloc] initWithFrame:CGRectMake(self.viewWidth-80, 5, 50, 50)];
            imageView.contentMode         = UIViewContentModeScaleAspectFill;
            imageView.layer.masksToBounds = YES;
            [cell.contentView addSubview:imageView];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.carModel.driving_license_url]];
        }
        UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(0, 59, self.viewWidth, 1)];
        lineView.backgroundColor = [ UIColor colorWithHexString:ColorLineGray];
        [cell.contentView addSubview:lineView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.carModel.state != CarStateSuccess) {
        return 150;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.carModel.state == CarStateSuccess) {
        return nil;
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 50)];
    CustomLabel * label = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 20, self.viewWidth, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = [UIColor redColor];
    [view addSubview:label];
    
    if (self.carModel.state == CarStateFail) {
        //btn样式处理
        CustomButton * btn      = [[CustomButton alloc] init];
        btn.frame               = CGRectMake(kCenterOriginX((self.viewWidth-30)), 80, (self.viewWidth-30), 45);
        btn.layer.cornerRadius  = 5;
        btn.layer.borderWidth   = 1;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
        btn.fontSize            = FontLoginButton;
        [btn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:ColorLoginBtnGray] forState:UIControlStateHighlighted];
        [btn setTitle:@"重新提交" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(resubmit) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        label.text = @"审核失败";
    }else {
        label.text = @"正在审核";
    }
    
    return view;
}

#pragma mark- private method
- (void)initData {
    
    self.titleArr = @[@"姓名",@"电话",@"车牌",@"车型",@"行驶证"];
    
    NSString * url = [API_CarInfo stringByAppendingFormat:@"?car_id=%ld", self.carID];
    [HttpService getWithUrlString:url andCompletion:^(id responseData) {

        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == HttpStatusCodeSuccess) {
            
            self.carModel = [[CarModel alloc] init];
            [self.carModel setModelWithDic:responseData[HttpResult]];
            [self initTable];
            
        }else{
            [self showHint:responseData[HttpMessage]];
        }
        
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];
    
}

@end
