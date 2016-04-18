//
//  CreateOrderViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "CreateOrderViewController.h"
#import "OrderModel.h"

NS_ENUM(NSInteger){
    TableOrder  = 0,
    TableShop   = 1,
    TablePhone  = 2,
    TableGoods  = 3,
    TableAmount = 4,
    TableCar    = 5
};

@interface CreateOrderViewController ()

@property (nonatomic, strong) OrderModel  * orderModel;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray     * titleArr;

@end

@implementation CreateOrderViewController


#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initWidget];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- layout

- (void)initWidget {
    
    [self configUI];
}

- (void)initTable
{
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight) style:UITableViewStylePlain];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces                      = NO;
    [self.view addSubview:self.tableView];
}

- (void)configUI {
    
    [self setNavBarTitle:@"订单详情"];
}

#pragma mark- method response
- (void)pay
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotifyPaySuccess object:nil];
    
    [self popToTabBarViewController];
}

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        
        cell.textLabel.text      = self.titleArr[indexPath.row];

        CustomLabel * titleLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-150, 0, 140, 60)];
        titleLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:titleLabel];
        
        switch (indexPath.row) {
            case TableOrder:
                titleLabel.text = self.orderModel.out_trade_no;
                break;
            case TableShop:
                titleLabel.text = self.orderModel.shop_name;
                break;
            case TablePhone:
                titleLabel.text = self.orderModel.shop_phone;
                break;
            case TableGoods:
                titleLabel.text = self.orderModel.goods_name;
                break;
            case TableAmount:
                titleLabel.text = self.orderModel.total_fee;
                break;
            case TableCar:
                titleLabel.text = self.orderModel.car_type;
                break;
            default:
                break;
        }
        
        UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(0, 59, self.viewWidth, 1)];
        lineView.backgroundColor = [ UIColor colorWithHexString:ColorLineGray];
        [cell.contentView addSubview:lineView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 150)];
    
    CustomLabel * label = [[CustomLabel alloc] initWithFrame:CGRectMake(kCenterOriginX((self.viewWidth-30)), 30, (self.viewWidth-30), 40)];
    label.font          = [UIFont systemFontOfSize:15];
    label.textColor     = [UIColor redColor];
    label.text          = @"订单号或者二维码须提供给商家，以便于商家确认为您服务";
    label.numberOfLines = 0;
    [view addSubview:label];
    
    //btn样式处理
    CustomButton * btn      = [[CustomButton alloc] init];
    btn.frame               = CGRectMake(kCenterOriginX((self.viewWidth-30)), 80, (self.viewWidth-30), 45);
    btn.layer.cornerRadius  = 5;
    btn.layer.borderWidth   = 1;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    btn.fontSize            = FontLoginButton;
    [btn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:ColorLoginBtnGray] forState:UIControlStateHighlighted];
    [btn setTitle:StringCommonSubmit forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    return view;
}


#pragma mark- private method
- (void)initData {
    
    self.titleArr = @[@"订单号",@"商家",@"联系电话",@"服务项目",@"消费金额",@"服务车辆"];
    
    self.orderModel              = [[OrderModel alloc] init];
    self.orderModel.out_trade_no = @"123456";
    self.orderModel.shop_name    = @"商家";
    self.orderModel.shop_phone   = @"13456423145";
    self.orderModel.goods_name   = @"商品";
    self.orderModel.total_fee    = @"金额";
    self.orderModel.car_type     = @"车辆";

    [self initTable];
    
}

@end
