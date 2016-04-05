//
//  ViewController1.m
//  SHS_Global
//
//  Created by 李晓航 on 16/3/24.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "SpecialViewController.h"
#import "ShopListViewController.h"
#import "TempServerViewController.h"

@interface SpecialViewController ()

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray     * dataSource;

@end

@implementation SpecialViewController

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

- (void)initWidget{

    [self initTable];
    
}

- (void)initTable{
    
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-kTabBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"commonCell"];
    [self.view addSubview:self.tableView];
}

- (void)configUI{
    
}


#pragma mark- method response

#pragma mark- UITableDelegate & UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"commonCell"];
    cell.textLabel.text    = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ShopListViewController * svc = [[ShopListViewController alloc] init];
        [self pushVC:svc];
    }else{
        TempServerViewController * tsvc = [[TempServerViewController alloc] init];
        [self pushVC:tsvc];
    }

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- private method
- (void)initData{
    self.dataSource = @[@"豪车精洗",@"豪车美容",@"在线问诊",@"保险咨询",@"道路救援",@"车辆维修"];
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
