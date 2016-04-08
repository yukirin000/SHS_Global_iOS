//
//  ShopsViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopViewController.h"
#import "LocationService.h"
#import "ShopCell.h"

@interface ShopListViewController ()

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self configUI];
    
    [LocationService sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout
- (void)configUI
{
    [self setNavBarTitle:GlobalString(@"ShopListTitle")];
}

#pragma mark- UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellid      = @"shopList";
    ShopCell * cell = [self.refreshTableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell setWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopViewController * shopVC = [[ShopViewController alloc] init];
    ShopModel * shop            = self.dataSource[indexPath.row];
    shopVC.shopId               = shop.sid;
    [self pushVC:shopVC];
}

#pragma override
- (void)loadAndhandleData
{
    NSString * url = [NSString stringWithFormat:@"%@?page=%d", API_GetShopList, self.currentPage];
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
            for (NSDictionary * shopDic in list) {
                ShopModel * model      = [[ShopModel alloc] init];
                [model setModelWithDic:shopDic];
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

    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        //下拉刷新清空数组
//        if (self.currentPage == 1) {
//            [self.dataSource removeAllObjects];
//        }
//        for (int i=0; i<6; i++) {
//            
//            ShopModel * shop = [[ShopModel alloc] init];
//            shop.shop_name   = [NSString stringWithFormat:@"%d", i];
//            shop.address     = @"哈哈哈哈哈啊";
//            [self.dataSource addObject:shop];
//        }
//        
//        if (self.currentPage == 3) {
//            self.isLastPage = YES;
//        }
//        [self reloadTable];
//    });
    
    
    
//    加载失败调用
//    self.isReloading = NO;
//    [self.refreshTableView refreshFinish];
    
}

#pragma mark- private method
- (void)initData
{
    [self refreshData];
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
