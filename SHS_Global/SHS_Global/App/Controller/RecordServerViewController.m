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
    
    [self initWidget];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];    
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
    
    self.refreshTableView.frame = CGRectMake(0, 0, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-kTabBarHeight-30);
    self.navBar.hidden          = YES;
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
    
    NSString * url = API_AlreadyServiceList;
    if (self.isServing) {
        url = API_ServiceList;
    }
    url = [NSString stringWithFormat:@"%@?user_id=%ld&page=%d", url, [UserService getUserID],self.currentPage];
    debugLog(@"%@", url);

    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
        int status = [responseData[HttpStatus] intValue];
        if (status == HttpStatusCodeSuccess) {
            //下拉刷新清空数组
            if (self.currentPage == 1) {
                [self.dataSource removeAllObjects];
            }
            self.isLastPage = [responseData[HttpResult][@"is_last"] boolValue];
            
            NSArray * list  = responseData[HttpResult][HttpList];
            //数据处理
            for (NSDictionary * orderDic in list) {
                OrderModel * model      = [[OrderModel alloc] init];
                [model setModelWithDic:orderDic];
                [self.dataSource addObject:model];
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
- (void)initData
{

}

@end
