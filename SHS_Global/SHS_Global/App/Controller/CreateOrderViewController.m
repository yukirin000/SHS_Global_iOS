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
    TableShop   = 0,
    TablePhone  = 1,
    TableGoods  = 2,
    TableAmount = 3,
    TableCar    = 4
};

@interface CreateOrderViewController ()

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray     * titleArr;

@end

@implementation CreateOrderViewController


#pragma mark- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNotify];
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
    self.tableView.backgroundColor              = [UIColor clearColor];
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces                      = NO;
    [self.view addSubview:self.tableView];
}

- (void)configUI {
    
    [self setNavBarTitle:GlobalString(@"RecordDetail")];
}

#pragma mark- method response
- (void)pay
{
 
    if (![WXApi isWXAppInstalled]) {
        [self showHint:GlobalString(@"CreateOrderNoWX")];
        return;
    }
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString * url = [API_CreateOrder stringByAppendingFormat:@"?user_id=%ld&shop_id=%ld&goods_id=%ld&car_id=%ld", [UserService getUserID], self.shop_id, self.goods_id, self.carID];
    debugLog(@"%@", url);
    
    [self showHudInView:self.view hint:GlobalString(@"CreateOrderING")];
    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
        
        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == HttpStatusCodeSuccess) {
            [self hideHud];
            [self wxPay:responseData[HttpResult]];
    
        }else{
            [self showHint:GlobalString(@"CreateOrderFail")];
        }
        
    } andFail:^(NSError *error) {
        [self showHint:StringCommonNetException];
    }];

    
}

#pragma mark- Delegate & Datasource
#pragma mark- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        cell.selectionStyle              = UITableViewCellSelectionStyleNone;
        cell.textLabel.text              = self.titleArr[indexPath.row];
        cell.textLabel.textColor         = [UIColor colorWithHexString:ColorTitle];
        cell.textLabel.font              = [UIFont systemFontOfSize:FontListName];
        cell.contentView.backgroundColor = [UIColor colorWithHexString:ColorWhite];

        CustomLabel * titleLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-150, 0, 135, 50)];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font          = [UIFont systemFontOfSize:14];
        titleLabel.textColor     = [UIColor colorWithHexString:@"888888"];
        [cell.contentView addSubview:titleLabel];
        
        switch (indexPath.row) {
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
        
        UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(15, 49, self.viewWidth, 1)];
        lineView.backgroundColor = [ UIColor colorWithHexString:ColorLineGray];
        [cell.contentView addSubview:lineView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 150)];
    
    CustomLabel * label = [[CustomLabel alloc] initWithFrame:CGRectMake(kCenterOriginX((self.viewWidth-30)), 20, (self.viewWidth-30), 40)];
    label.font          = [UIFont systemFontOfSize:13];
    label.textColor     = [UIColor colorWithHexString:@"a5a5a5"];
    label.text          = GlobalString(@"RecordPrompt");
    label.numberOfLines = 0;
    [view addSubview:label];
    
    //btn样式处理
    CustomButton * btn      = [[CustomButton alloc] init];
    btn.frame               = CGRectMake(kCenterOriginX((self.viewWidth-30)), 80, (self.viewWidth-30), 45);
    btn.backgroundColor     = [UIColor colorWithHexString:ColorWhite];
    btn.layer.cornerRadius  = 5;
    btn.layer.borderWidth   = 1;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    btn.fontSize            = FontLoginButton;
    [btn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:ColorLoginBtnGray] forState:UIControlStateHighlighted];
    [btn setTitle:GlobalString(@"CreatePay") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    CustomButton * promptBtn  = [[CustomButton alloc] initWithFrame:CGRectMake(0, btn.bottom+50, self.viewWidth, 29)];
    promptBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    promptBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [promptBtn setImage:[UIImage imageNamed:@"pay"] forState:UIControlStateNormal];
    [promptBtn setTitle:GlobalString(@"CreateNeedUseWX") forState:UIControlStateNormal];
    [promptBtn setTitleColor:[UIColor colorWithHexString:ColorBlack] forState:UIControlStateNormal];
    [view addSubview:promptBtn];

    return view;
}


#pragma mark- private method
- (void)initData {
    
    self.titleArr = @[GlobalString(@"OrderShopName"),GlobalString(@"OrderShopPhone"),GlobalString(@"OrderGoodsName"),GlobalString(@"OrderAmount"),GlobalString(@"OrderCar")];
    
    [self initTable];
}

- (void)registerNotify {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:NotifyPaySuccess object:nil];
}

- (void)paySuccess:(NSNotification *)notify {
    [self popToTabBarViewController];
}

- (void)wxPay:(NSDictionary *)dict {
    
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
//    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    
}

@end
