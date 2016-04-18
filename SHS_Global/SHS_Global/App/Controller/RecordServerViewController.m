//
//  RecordServedViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RecordServerViewController.h"
#import "RecordDetailViewController.h"
#import "RecordCell.h"

@interface RecordServerViewController ()

@end

@implementation RecordServerViewController

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

- (void)configUI {
 
    if (self.isServing) {
        self.refreshTableView.backgroundColor = [UIColor blueColor];
    }else{
        self.refreshTableView.backgroundColor = [UIColor redColor];
    }
    
    self.refreshTableView.frame           = CGRectMake(0, 0, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-kTabBarHeight-30);
}

#pragma mark- method response

#pragma mark- Delegate & Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellid      = @"recordList";
    RecordCell * cell = [self.refreshTableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell setWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel * order                = self.dataSource[indexPath.row];

    RecordDetailViewController * rdvc = [[RecordDetailViewController alloc] init];
    rdvc.rid                          = order.oid;
    [self pushVC:rdvc];
}

#pragma override
- (void)loadAndhandleData
{
    
    if (self.isServing) {
        
    }
    
    self.isLastPage = YES;
    [self.dataSource removeAllObjects];
    for (int i=0; i<10; i++) {
        
        OrderModel * order = [[OrderModel alloc] init];
        order.shop_name    = @"测试商店";
        order.total_fee    = @"50";
        order.pay_date     = @"1949-10-01";
        [self.dataSource addObject:order];
        [self reloadTable];
    }
    
//    NSString * url = [NSString stringWithFormat:@"%@?page=%d", API_GetShopList, self.currentPage];
//    debugLog(@"%@", url);
//    
//    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
//        int status = [responseData[HttpStatus] intValue];
//        if (status == HttpStatusCodeSuccess) {
//            //下拉刷新清空数组
//            if (self.currentPage == 1) {
//                [self.dataSource removeAllObjects];
//            }
//            self.isLastPage = [responseData[HttpResult][@"is_last"] boolValue];
//            
//            NSArray * list  = responseData[HttpResult][HttpList];
//            
//            [self reloadTable];
//            
//        }else{
//            self.isReloading = NO;
//            [self.refreshTableView refreshFinish];
//        }
//        
//    } andFail:^(NSError *error) {
//        self.isReloading = NO;
//        [self.refreshTableView refreshFinish];
//    }];
    
}

#pragma mark- private method
- (void)initData
{
    [self refreshData];
}

@end
