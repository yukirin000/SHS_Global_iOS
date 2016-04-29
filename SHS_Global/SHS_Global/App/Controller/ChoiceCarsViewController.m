//
//  ChoiceCarsViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ChoiceCarsViewController.h"
#import "ApplyCarViewController.h"
#import "MyCarsCell.h"
#import "CreateOrderViewController.h"

@interface ChoiceCarsViewController ()

//“暂无爱车”
@property (nonatomic, strong) UIView * emptyView;

@end

@implementation ChoiceCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- layout

- (void)initWidget{
    
    self.emptyView = [[UIView alloc] init];
    
    [self.refreshTableView addSubview:self.emptyView];
    
    [self configUI];
}


- (void)configUI {
    
    [self setNavBarTitle:GlobalString(@"ChoiceCarTitle")];
    self.refreshTableView.notLoading    = @"";
    self.refreshTableView.bottomLoading = @"";
    
    self.emptyView.frame       = CGRectMake(kCenterOriginX(80), (self.refreshTableView.height-130)/2, 80, 130);
    CustomImageView * noneView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"no_car"]];
    noneView.frame             = CGRectMake(1, 1, 77, 77);
    
    CustomLabel * noneLabel    = [[CustomLabel alloc] initWithFrame:CGRectMake(0, noneView.bottom+30, 80, 15)];
    noneLabel.textAlignment    = NSTextAlignmentCenter;
    noneLabel.textColor        = [UIColor colorWithHexString:@"646464"];
    noneLabel.font             = [UIFont systemFontOfSize:15];
    noneLabel.text             = GlobalString(@"MyCarsNoCar");
    [self.emptyView addSubview:noneLabel];
    [self.emptyView addSubview:noneView];
    self.emptyView.hidden      = YES;
    
}

#pragma mark- method response

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellid = @"carList";
    MyCarsCell * cell = [self.refreshTableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MyCarsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell setWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CarModel * car                   = self.dataSource[indexPath.row];
    CreateOrderViewController * covc = [[CreateOrderViewController alloc] init];
    covc.carID                       = car.cid;
    covc.shop_id                     = self.shop_id;
    covc.goods_id                    = self.goods_id;
    covc.orderModel                  = self.order;
    covc.orderModel.car_type         = car.car_type;
    [self pushVC:covc];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma override
- (void)loadAndhandleData
{
    //不能加载更多
    self.isLastPage = YES;
    
    NSString * url = [NSString stringWithFormat:@"%@?user_id=%ld", API_ChoiceMyCar, [UserService sharedService].user.user_id];
    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
        int status = [responseData[HttpStatus] intValue];
        if (status == HttpStatusCodeSuccess) {
            //下拉刷新清空数组
            if (self.currentPage == 1) {
                [self.dataSource removeAllObjects];
            }
            
            NSArray * list  = responseData[HttpResult];
            //数据处理
            for (NSDictionary * carDic in list) {
                CarModel * model = [[CarModel alloc] init];
                [model setModelWithDic:carDic];
                [self.dataSource addObject:model];
            }
            
            if (list.count > 0) {
                self.emptyView.hidden       = YES;
                self.navBar.rightBtn.hidden = YES;
            }else{
                self.emptyView.hidden       = NO;
                self.navBar.rightBtn.hidden = NO;
                //右上角添加爱车
                __weak typeof(self) sself = self;
                [self.navBar setRightBtnWithContent:nil andBlock:^{
                    ApplyCarViewController * acvc = [[ApplyCarViewController alloc] init];
                    [sself pushVC:acvc];
                }];
                [self.navBar setRightImage:[UIImage imageNamed:@"bell"]];
            }
            
            [self reloadTable];
            
        }else{
            self.isReloading = NO;
            [self.refreshTableView refreshFinish];
        }
        
    } andFail:^(NSError *error) {
        self.isReloading = NO;
        [self.refreshTableView refreshFinish];
    }];
    
}

#pragma mark- private method
- (void)initData {
    
}


@end
