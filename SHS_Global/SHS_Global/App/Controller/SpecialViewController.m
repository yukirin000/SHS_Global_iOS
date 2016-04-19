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

@property (nonatomic, strong) NSArray     * titleSource;
@property (nonatomic, strong) NSArray     * imageSource;

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
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

- (void)configUI{
    
}


#pragma mark- method response

#pragma mark- UITableDelegate & UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"commonCell%ld", indexPath.row]];
    if (!cell) {
        cell                 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"commonCell%ld", indexPath.row]];
        UIView * line        = [[UIView alloc] initWithFrame:CGRectMake(15, 64, self.viewWidth-15, 1)];
        line.backgroundColor = [UIColor colorWithHexString:ColorLineGray];
        [cell.contentView addSubview:line];
        
        cell.textLabel.text    = GlobalString(self.titleSource[indexPath.row]);
        cell.textLabel.font    = [UIFont systemFontOfSize:15];
        cell.imageView.image   = [UIImage imageNamed:self.imageSource[indexPath.row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ShopListViewController * svc = [[ShopListViewController alloc] init];
        [self pushVC:svc];
    }else if (indexPath.row == 1) {
        TempServerViewController * tsvc = [[TempServerViewController alloc] init];
        tsvc.type                       = 2;
        [self pushVC:tsvc];
    } else{
        TempServerViewController * tsvc = [[TempServerViewController alloc] init];
        tsvc.type                       = 1;
        [self pushVC:tsvc];
    }

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- private method
- (void)initData{
    
    self.titleSource = @[@"SpecialWash", @"SpecialOnline", @"SpecialConsult",@"SpecialRepair"];
    self.imageSource = @[@"wash", @"wash", @"consult", @"repair"];
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
