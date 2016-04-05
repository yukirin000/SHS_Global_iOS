//
//  TempServerViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/1.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "TempServerViewController.h"

@interface TempServerViewController ()

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray     * dataSource;

@end

@implementation TempServerViewController

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
    
    CustomButton * bottomBtn  = [[CustomButton alloc] initWithFrame:CGRectMake(0, self.viewHeight-40, self.viewWidth, 40)];
    bottomBtn.backgroundColor = [UIColor blackColor];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"一键呼叫管家" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    [self initTable];
    
}

- (void)initTable{
    
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight-40) style:UITableViewStylePlain];
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
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    cell.textLabel.text    = [NSString stringWithFormat:@"%ld、%@", indexPath.row+1, self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark- private method
- (void)initData{
    self.dataSource = @[@"精洗车辆",@"内饰清洁",@"漆面抛光、打蜡",@"漆面镀膜、镀晶",@"汽车隔热膜",@"改色贴膜",@"汽车表面透明膜"];
}

#pragma mark- method resopnse
- (void)bottomPress:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008693911"]];
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
