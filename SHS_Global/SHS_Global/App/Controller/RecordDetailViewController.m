//
//  RecordDetailViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/18.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RecordDetailViewController.h"
#import "QRCodeGenerator.h"
#import "OrderModel.h"

NS_ENUM(NSInteger){
    TableOrder  = 0,
    TableQrcode = 1,
    TableShop   = 2,
    TablePhone  = 3,
    TableGoods  = 4,
    TableAmount = 5,
    TableCar    = 6,
    TableState  = 7
};

@interface RecordDetailViewController ()

@property (nonatomic, strong) OrderModel  * orderModel;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray     * titleArr;

@end

@implementation RecordDetailViewController

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
    self.tableView                              = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusHeight, self.viewWidth, self.viewHeight-kNavBarAndStatusHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)configUI {
    
    [self setNavBarTitle:@"订单详情"];
}

#pragma mark- method response
- (void)qrcodeClick:(CustomButton *)sender
{
    [sender removeFromSuperview];
}

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.titleArr[indexPath.row];
        
        if (indexPath.row == TableQrcode) {
            CustomImageView * qrcodeImageView = [[CustomImageView alloc] initWithFrame:CGRectMake(self.viewWidth-60, 5, 50, 50)];
            qrcodeImageView.backgroundColor   = [UIColor redColor];
            [cell.contentView addSubview:qrcodeImageView];
        }else{
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
                case TableState:
                    if (self.orderModel.state == 1) {
                        titleLabel.text = @"服务中";
                    }else{
                        titleLabel.text = @"已完成";
                    }
                    break;
                default:
                    break;
            }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == TableQrcode) {
        
        CustomButton * qrBtn   = [[CustomButton alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight)];
        qrBtn.backgroundColor  = [UIColor colorWithWhite:0.5 alpha:0.5];
        CustomImageView * qriv = [[CustomImageView alloc] initWithFrame:CGRectMake(kCenterOriginX(200), (self.viewHeight-200)/2, 200, 200)];
        qriv.image             = [QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"biz%@", self.orderModel.out_trade_no] imageSize:200];
        qriv.backgroundColor   = [UIColor whiteColor];
        [qrBtn addSubview:qriv];
        [qrBtn addTarget:self action:@selector(qrcodeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:qrBtn];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 150)];
    view.backgroundColor = [UIColor colorWithHexString:ColorBackGray];
    CustomLabel * label  = [[CustomLabel alloc] initWithFrame:CGRectMake(kCenterOriginX((self.viewWidth-30)), 15, (self.viewWidth-30), 40)];
    label.font           = [UIFont systemFontOfSize:15];
    label.textColor      = [UIColor redColor];
    label.text           = @"订单号或者二维码须提供给商家，以便于商家确认为您服务";
    label.numberOfLines  = 0;
    [view addSubview:label];
    
    return view;
}


#pragma mark- private method
- (void)initData {
    
    self.titleArr = @[@"订单号",@"订单二维码",@"商家",@"联系电话",@"服务项目",@"消费金额",@"服务车辆",@"服务状态"];
    
    NSString * url = [API_ServiceDetails stringByAppendingFormat:@"?order_id=%ld", self.rid];
    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
        
        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == HttpStatusCodeSuccess) {
            
            self.orderModel = [[OrderModel alloc] init];
            [self.orderModel setModelWithDic:responseData[HttpResult][0]];

            [self initTable];
            
        }else{
            [self showHint:responseData[HttpMessage]];
        }
        
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];
    
}

@end
