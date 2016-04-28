//
//  ChoiceCarTypeViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/14.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "ChoiceCarTypeViewController.h"

@interface ChoiceCarTypeViewController ()

@property (nonatomic, strong) NSArray     * dataSource;

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ChoiceCarTypeViewController
{
    CarTypeBlock _block;
}

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
    [self configUI];
}

- (void)initTable
{
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight) style:UITableViewStylePlain];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
}

- (void)configUI{
    
    if (self.level == 1) {
        [self setNavBarTitle:GlobalString(@"CarTypeBrand")];
    }else{
        [self setNavBarTitle:GlobalString(@"CarTypeType")];
    }
    
}

#pragma mark- method response

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (self.level == 1) {
        cell.imageView.contentMode = UIViewContentModeScaleToFill;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row][@"image"]]];
    }
    cell.textLabel.text = self.dataSource[indexPath.row][@"name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.level == 1) {
        if ([self.dataSource[indexPath.row][@"has_second"] integerValue]) {
            ChoiceCarTypeViewController * cctvc = [[ChoiceCarTypeViewController alloc] init];
            cctvc.level                         = 2;
            cctvc.returnVC                      = self.returnVC;
            cctvc.brandNum                      = self.dataSource[indexPath.row][@"first_code"];
            cctvc.brandName                     = self.dataSource[indexPath.row][@"name"];
            [cctvc setBlock:_block];
            [self pushVC:cctvc];
        }else{
            if (_block) {
                NSString * carType     = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.row][@"name"]];
                NSString * carTypeCode = [NSString stringWithFormat:@"%@0001", self.dataSource[indexPath.row][@"first_code"]];
                _block(carType, carTypeCode);
            }
            [self.navigationController popToViewController:self.returnVC animated:YES];
        }
    }else{
        if (_block) {
            NSString * carType     = [NSString stringWithFormat:@"%@ %@", self.brandName, self.dataSource[indexPath.row][@"name"]];
            NSString * carTypeCode = [NSString stringWithFormat:@"%@%@", self.brandNum, self.dataSource[indexPath.row][@"second_code"]];
            _block(carType, carTypeCode);
        }
        [self.navigationController popToViewController:self.returnVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- public method
- (void)setBlock:(CarTypeBlock)block
{
    _block = [block copy];
}

#pragma mark- private method
- (void)initData
{
    NSString * url = API_CarCategory;
    
    if (self.level == 2) {
        url = [NSString stringWithFormat:@"%@?first_code=%@", API_CarClassify , self.brandNum];
    }
    
    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == HttpStatusCodeSuccess) {
            self.dataSource = responseData[HttpResult];
            [self.tableView reloadData];
        }else{
            [self showFail:StringCommonNetException];
        }
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];
}

@end
