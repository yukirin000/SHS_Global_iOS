//
//  MyCarsViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "MyCarsViewController.h"
#import "ApplyCarViewController.h"
#import "CarDetailViewController.h"
#import "MyCarsCell.h"

@interface MyCarsViewController ()

//“暂无爱车” Label
@property (nonatomic, strong) CustomLabel * emptyLabel;

@end

@implementation MyCarsViewController

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
    
    __weak typeof(self) sself = self;
    [self.navBar setRightBtnWithContent:nil andBlock:^{
        ApplyCarViewController * acvc = [[ApplyCarViewController alloc] init];
        [sself pushVC:acvc];
    }];
    [self.navBar setRightImage:[UIImage imageNamed:@"nav_add"]];
    [self.navBar setNavTitle:GlobalString(@"MyCarsTitle")];
    
    self.refreshTableView.notLoading    = @"";
    self.refreshTableView.bottomLoading = @"";
    
    self.emptyLabel.frame         = CGRectMake(0, 150, self.viewWidth, 30);
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyLabel.text          = GlobalString(@"MyCarsNoCar");
    self.emptyLabel.hidden        = YES;
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CarDetailViewController * cdvc = [[CarDetailViewController alloc] init];
    CarModel * car                 = self.dataSource[indexPath.row];
    cdvc.carID                     = car.cid;
    [self pushVC:cdvc];
}

#pragma override
- (void)loadAndhandleData
{
    //不能加载更多
    self.isLastPage = YES;
    
    NSString * url = [NSString stringWithFormat:@"%@?user_id=%ld", API_MyCars, [UserService sharedService].user.user_id];
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
            }else{
                self.emptyLabel.hidden = NO;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
