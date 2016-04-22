//
//  LoginViewController.m
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/19.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SecondLoginViewController.h"
#import "WebViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) CustomButton    * loginBtn;
@property (nonatomic, strong) CustomTextField * loginTextField;
//免责声明
@property (nonatomic, strong) CustomButton    * protocolBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWidget];
    [self configUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

#pragma mark- layout
- (void)createWidget
{
    
    //登录按钮
    self.loginBtn       = [[CustomButton alloc] init];
    //登录textfield
    self.loginTextField = [[CustomTextField alloc] init];
    //用户协议
    self.protocolBtn    = [[CustomButton alloc] init];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.loginTextField];
    [self.view addSubview:self.protocolBtn];
    
    //绑定事件
    [self.loginBtn addTarget:self action:@selector(nextLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.protocolBtn addTarget:self action:@selector(userProtocolPress:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configUI
{
    //loginTextFiled样式处理
    self.loginTextField.frame               = CGRectMake(kCenterOriginX((self.viewWidth-30)), kNavBarAndStatusHeight+50, self.viewWidth-30, 45);
    self.loginTextField.placeholder         = GlobalString(@"LoginPleaseEnterMobile");
    self.loginTextField.layer.cornerRadius  = 3;
    self.loginTextField.leftView            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.loginTextField.leftViewMode        = UITextFieldViewModeAlways;
    self.loginTextField.layer.borderWidth   = 1;
    self.loginTextField.layer.masksToBounds = YES;
    self.loginTextField.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    self.loginTextField.delegate            = self;
    self.loginTextField.font                = [UIFont systemFontOfSize:FontLoginTextField];
    self.loginTextField.clearButtonMode     = UITextFieldViewModeWhileEditing;
    self.loginTextField.textColor           = [UIColor colorWithHexString:ColorBlack];
    self.loginTextField.tintColor           = [UIColor colorWithHexString:ColorBlack];
    self.loginTextField.keyboardType        = UIKeyboardTypeNumberPad;
    self.loginTextField.backgroundColor     = [UIColor whiteColor];
    
    //btn样式处理
    self.loginBtn.frame                       = CGRectMake(kCenterOriginX((self.viewWidth-30)), self.loginTextField.bottom+50, (self.viewWidth-30), 45);
    self.loginBtn.layer.cornerRadius          = 5;
    self.loginBtn.layer.borderWidth           = 1;
    self.loginBtn.layer.masksToBounds         = YES;
    self.loginBtn.layer.borderColor           = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    self.loginBtn.fontSize                    = FontLoginButton;
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:ColorLoginBtnGray] forState:UIControlStateHighlighted];
    [self.loginBtn setTitle:GlobalString(@"CommonNext") forState:UIControlStateNormal];
    
    //用户协议
//    self.protocolBtn.frame                    = CGRectMake(kCenterOriginX(280), self.view.bottom-50, 280, 40);
//    self.protocolBtn.fontSize                 = 13;
//    self.protocolBtn.titleLabel.textColor     = [UIColor whiteColor];
//    NSMutableAttributedString * protocolStr   = [[NSMutableAttributedString alloc] initWithString:GlobalString(@"LoginProtocol")];
//    [self.protocolBtn setAttributedTitle:protocolStr forState:UIControlStateNormal];
    
    CustomButton * bottomBtn      = [[CustomButton alloc] initWithFrame:CGRectMake(kCenterOriginX(250), kNavBarAndStatusHeight+260, 250, 45)];
    bottomBtn.backgroundColor     = [UIColor colorWithHexString:ColorWhite];
    bottomBtn.layer.cornerRadius  = 22.5;
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.borderWidth   = 1;
    bottomBtn.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    bottomBtn.titleLabel.font     = [UIFont systemFontOfSize:14];
    [bottomBtn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"先看看" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}

#pragma mark- event Response
- (void)bottomPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextLogin:(id)sender
{
    
//    //进入主页
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ENTER_MAIN object:nil];
//    return;
    
    if (self.loginTextField.text.length < 1) {
        [self showHint:GlobalString(@"LoginUsernameNotNull")];
        return;
    }
    
    [self showHudInView:self.view hint:nil];
    NSDictionary * params = @{@"username":self.loginTextField.text};
    debugLog(@"%@ %@", API_IsUser, params);
    [HttpService postWithUrlString:API_IsUser params:params andCompletion:^(id responseData) {
        //登录
        int loginDirection    = 1;
        //注册
        int registerDirection = 2;
        int status = [responseData[@"status"] intValue];
        if (status == HttpStatusCodeSuccess) {
            int direction = [responseData[@"result"][@"direction"] intValue];
            if (direction == loginDirection) {
                [self hideHud];
                SecondLoginViewController * slVC = [[SecondLoginViewController alloc] init];
                slVC.username                    = self.loginTextField.text;
                [self pushVC:slVC];
            }
            
            if (direction == registerDirection) {
                [self hideHud];
                RegisterViewController * rvc = [[RegisterViewController alloc] init];
                rvc.phoneNumber              = self.loginTextField.text;
                [self pushVC:rvc];
            }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
        }else{
            [self showHint:StringCommonNetException];
        }
        
    } andFail:^(NSError *error) {
        [self showHint:StringCommonNetException];
    }];
    
}

#pragma mark- override
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.loginTextField resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.loginTextField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //手机号不超过11位
    if (range.length == 0) {
        if ((textField.text.length+string.length)>11) {
            return NO;
        }
    }

    return YES;
}
#pragma mark- method response
- (void)userProtocolPress:(id)sender
{
    WebViewController * wvc = [[WebViewController alloc] init];
//    wvc.webURL              = [NSURL URLWithString:@""];
    [self pushVC:wvc];
}

#pragma mark- privateMethod

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
