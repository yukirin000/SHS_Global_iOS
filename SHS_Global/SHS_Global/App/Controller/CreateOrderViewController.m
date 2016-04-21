//
//  CreateOrderViewController.m
//  SHS_Global
//
//  Created by 李晓航 on 16/4/15.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "CreateOrderViewController.h"
#import "OrderModel.h"
#import "WXApi.h"

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
//    [[NSNotificationCenter defaultCenter] postNotificationName:NotifyPaySuccess object:nil];
//    
//    [self popToTabBarViewController];
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString * res;
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                res = @"";
            }else{
                res = [dict objectForKey:@"retmsg"];
            }
        }else{
            res = @"服务器返回错误，未获取到json对象";
        }
    }else{
        res = @"服务器返回错误";
    }
    
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
    
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
