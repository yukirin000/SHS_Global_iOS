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

//“暂无爱车” Label
@property (nonatomic, strong) CustomLabel * emptyLabel;

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
    
    self.emptyLabel = [[CustomLabel alloc] init];
    
    [self.refreshTableView addSubview:self.emptyLabel];
    
    [self configUI];
}


- (void)configUI {
    
    self.refreshTableView.notLoading    = @"";
    self.refreshTableView.bottomLoading = @"";
    
    self.emptyLabel.frame         = CGRectMake(0, 150, self.viewWidth, 30);
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyLabel.text          = @"暂无爱车";
    self.emptyLabel.hidden        = YES;
    
}

#pragma mark- method response

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
                self.emptyLabel.hidden = YES;
                [self setNavBarTitle:@"选择爱车"];
            }else{
                self.emptyLabel.hidden = NO;
                //右上角添加爱车
                __weak typeof(self) sself = self;
                [self.navBar setRightBtnWithContent:nil andBlock:^{
                    ApplyCarViewController * acvc = [[ApplyCarViewController alloc] init];
                    [sself pushVC:acvc];
                }];
                [self.navBar setRightImage:[UIImage imageNamed:@"bell"]];
                [self setNavBarTitle:@"我的爱车"];
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
