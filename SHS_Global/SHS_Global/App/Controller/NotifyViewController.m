//
//  NotifyViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "NotifyViewController.h"
#import "CarDetailViewController.h"
#import "NotifyCell.h"

@interface NotifyViewController ()

@property (nonatomic, strong) UITableView    * tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation NotifyViewController

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

- (void)initTable {
    
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight) style:UITableViewStylePlain];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.tableView registerClass:[NotifyCell class] forCellReuseIdentifier:@"notify"];
    [self.view addSubview:self.tableView];
}

- (void)configUI {
    
}

#pragma mark- method response

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotifyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"notify"];
    
    [cell setWithModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark- private method
- (void)initData {
    
}

@end
