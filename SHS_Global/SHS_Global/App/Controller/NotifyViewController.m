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

//“暂无爱车” Label
@property (nonatomic, strong) CustomLabel * emptyLabel;

@end

@implementation NotifyViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
    [self initData];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout

- (void)initWidget {
    
    self.emptyLabel = [[CustomLabel alloc] init];
    
    [self initTable];
    [self configUI];
    
    [self.tableView addSubview:self.emptyLabel];
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
    
    self.emptyLabel.frame         = CGRectMake(0, 150, self.viewWidth, 30);
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyLabel.text          = @"暂无通知";
    self.emptyLabel.hidden        = YES;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotifyModel * notify = self.dataSource[indexPath.row];
    CarDetailViewController * cvc = [[CarDetailViewController alloc] init];
    cvc.carID                     = notify.targetID;
    [self pushVC:cvc];
    
//    switch (notify.type) {
//        case NotifyCheckCarSuccess:
//            
//            break;
//        case NotifyCheckCarFail:
//            
//            break;
//        default:
//            break;
//    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- private method
- (void)initData {
    
    [self setNavBarTitle:@"通知"];
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    for (int i=0; i<10; i++) {
        
        NotifyModel * notify = [[NotifyModel alloc] init];
        notify.targetID      = 48;
        notify.title = @"测试";
        if (i%2 == 1) {
            notify.type     = NotifyCheckCarSuccess;
            notify.message  = @"审核通过";
            notify.isUnread = YES;
        }else{
            notify.type     = NotifyCheckCarFail;
            notify.message = @"审核未通过";
        }
        [self.dataSource addObject:notify];
    }
    
    [self.tableView reloadData];
}

@end
