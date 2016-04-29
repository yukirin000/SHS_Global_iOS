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

@property (nonatomic, strong) UIView * emptyView;

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
}

#pragma mark- layout

- (void)initWidget {
    
    self.emptyView = [[UIView alloc] init];
    
    [self.refreshTableView addSubview:self.emptyView];
    
    [self configUI];
}

- (void)configUI {
    
    self.refreshTableView.frame = CGRectMake(0, 0, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-kTabBarHeight-45);
    self.navBar.hidden          = YES;
    
    self.emptyView.frame       = CGRectMake(kCenterOriginX(80), (self.refreshTableView.height-130)/2, 80, 130);
    CustomImageView * noneView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"no_order"]];
    noneView.frame             = CGRectMake(1, 1, 77, 77);

    CustomLabel * noneLabel    = [[CustomLabel alloc] initWithFrame:CGRectMake(0, noneView.bottom+30, 80, 15)];
    noneLabel.textAlignment    = NSTextAlignmentCenter;
    noneLabel.textColor        = [UIColor colorWithHexString:@"646464"];
    noneLabel.font             = [UIFont systemFontOfSize:15];
    noneLabel.text             = GlobalString(@"RecordNoOrder");
    [self.emptyView addSubview:noneLabel];
    [self.emptyView addSubview:noneView];
    self.emptyView.hidden      = YES;
    
    self.refreshTableView.notLoading    = @"";
    self.refreshTableView.bottomLoading = @"";
}

#pragma mark- method response

#pragma mark- Delegate & Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
                if (self.isServing) {
                    model.state = OrderHasPay;
                }else{
                    model.state = OrderHasUse;
                }
                [self.dataSource addObject:model];
            }
            
            if (list.count > 0) {
                self.emptyView.hidden = YES;
            }else {
                self.emptyView.hidden = NO;
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
