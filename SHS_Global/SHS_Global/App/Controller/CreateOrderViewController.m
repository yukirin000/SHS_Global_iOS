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
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString * url = [API_CreateOrder stringByAppendingFormat:@"?user_id=%ld&shop_id=%ld&goods_id=%ld&car_id=%ld", [UserService getUserID], self.shop_id, self.goods_id, self.carID];
    debugLog(@"%@", url);
    
    [self showHudInView:self.view hint:@"订单创建中.."];
    [HttpService getWithUrlString:url andCompletion:^(id responseData) {
        
        NSInteger status = [responseData[HttpStatus] integerValue];
        if (status == HttpStatusCodeSuccess) {
            
            [self hideHud];
            [self wxPay:responseData[HttpResult]];
    
        }else{
            [self showHint:@"订单创建失败"];
            [self hideHud];
        }
        
    } andFail:^(NSError *error) {
        [self showHint:StringCommonNetException];
        [self hideHud];
    }];
    
//    NSString * res;
//    NSString *urlString   = [API_CreateOrder stringByAppendingFormat:@"?user_id=%ld&shop_id=%ld&goods_id=%ld&car_id=%ld", [UserService getUserID], self.shop_id, self.goods_id, self.carID];
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                dict = dict[HttpResult];
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.partnerId           = [dict objectForKey:@"partnerid"];
//                req.prepayId            = [dict objectForKey:@"prepayid"];
//                req.nonceStr            = [dict objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [dict objectForKey:@"package"];
//                req.sign                = [dict objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                res = @"";
//            }else{
//                res = [dict objectForKey:@"retmsg"];
//            }
//        }else{
//            res = @"服务器返回错误，未获取到json对象";
//        }
//    }else{
//        res = @"服务器返回错误";
//    }
//    
//    if( ![@"" isEqual:res] ){
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alter show];
//    }
    
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
        
        cell.textLabel.text      = self.titleArr[indexPath.row];

        CustomLabel * titleLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(self.viewWidth-150, 0, 140, 60)];
        titleLabel.textAlignment = NSTextAlignmentRight;
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
    
    self.titleArr = @[@"商家",@"联系电话",@"服务项目",@"消费金额",@"服务车辆"];
    

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
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    
//    appid=wxb4ba3c02aa476ea1
//    partid=10000100
//    prepayid=wx20160425165423b3893480ed0309964146
//    noncestr=449768401ee68e070c4866f2f6d7c849
//    timestamp=1461574463
//    package=Sign=WXPay
//    sign=38B0E301C008A2CD4B582DE16F43584C
    
//    appid=wx7941b7c16b724574
//    partid=1335376801
//    prepayid=wx2016042516560195c90eb95c0495221043
//    noncestr=08p6q98tmmlwd69t4z0725h73pt3fpgq
//    timestamp=1461574561
//    package=Sign=WXPay
//    sign=A864E6DA4F881172F8323E3E9227A428
}

@end
