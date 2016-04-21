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
#import "PushService.h"

@interface NotifyViewController ()

@property (nonatomic, strong) UITableView    * tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) NSMutableArray * notifySource;

//“暂无通知” Label
@property (nonatomic, strong) CustomLabel * emptyLabel;

@end

@implementation NotifyViewController

#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
    [self initData];
    [self registerNotify];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    //更新
    notify.isRead              = YES;
    NSDictionary * dic         = self.notifySource[indexPath.row];
    dic[@"content"][@"isRead"] = @"1";
    [PushService saveNotifyList:self.notifySource];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.notifySource removeObjectAtIndex:indexPath.row];
    [PushService saveNotifyList:self.notifySource];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark- private method
- (void)initData {
    
    [self setNavBarTitle:@"通知"];
    
    self.dataSource   = [[NSMutableArray alloc] init];
    self.notifySource = [[NSMutableArray alloc] init];
    [self refresh:nil];
}

- (void)registerNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:NotifyNewNotify object:nil];
}

//刷新
- (void)refresh:(NSNotification *)notify {
    
    [self.dataSource removeAllObjects];
    [self.notifySource removeAllObjects];
    
    [self.notifySource addObjectsFromArray:[PushService getNotifyList]];
    
    for (NSDictionary * dic in self.notifySource) {
        NotifyModel * notify = [[NotifyModel alloc] init];
        notify.targetID      = [dic[@"content"][@"id"] integerValue];
        notify.title         = dic[@"content"][@"plate_number"];
        notify.message       = dic[@"content"][@"message"];
        notify.type          = [dic[@"type"] integerValue];
        notify.isRead        = [dic[@"content"][@"isRead"] boolValue];
        [self.dataSource addObject:notify];
    }
    
    //暂无通知
    if (self.notifySource.count > 0) {
        self.emptyLabel.hidden = YES;
    }else{
        self.emptyLabel.hidden = NO;
    }
    
    [self.tableView reloadData];
}

@end
