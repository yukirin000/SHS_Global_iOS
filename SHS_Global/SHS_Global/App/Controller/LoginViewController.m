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
    self.view.backgroundColor    = [UIColor colorWithHexString:ColorWhite];
    //请输入手机号
    CustomLabel * usernamePrompt = [[CustomLabel alloc] initWithFontSize:15];
    usernamePrompt.frame         = CGRectMake(15, 72, 200, 15);
    usernamePrompt.textColor     = [UIColor colorWithHexString:ColorBlack];
    usernamePrompt.text          = GlobalString(@"Login_PleaseEnterMobile");
    [self.view addSubview:usernamePrompt];
    
    //placeHolder处理
    UIFont * placeHolderFont                  = [UIFont systemFontOfSize:FontLoginTextField];
    //loginTextFiled样式处理
    self.loginTextField.frame                 = CGRectMake(kCenterOriginX((self.viewWidth-30)), 100, self.viewWidth-30, 18);
    self.loginTextField.delegate              = self;
    self.loginTextField.font                  = placeHolderFont;
    self.loginTextField.clearButtonMode       = UITextFieldViewModeWhileEditing;
    self.loginTextField.textColor             = [UIColor colorWithHexString:ColorBlack];
    self.loginTextField.tintColor             = [UIColor colorWithHexString:ColorBlack];
    self.loginTextField.keyboardType          = UIKeyboardTypeNumberPad;
    self.loginTextField.backgroundColor       = [UIColor whiteColor];
    
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(kCenterOriginX((self.viewWidth-30)), 128, self.viewWidth-30, 1)];
    bottomLine.backgroundColor = [UIColor colorWithHexString:ColorLoginLineGary];
    [self.view addSubview:bottomLine];
    
    //btn样式处理
    self.loginBtn.frame                       = CGRectMake(kCenterOriginX((self.viewWidth-30)), bottomLine.bottom+60, (self.viewWidth-30), 45);
    self.loginBtn.layer.cornerRadius          = 5;
    self.loginBtn.fontSize                    = FontLoginButton;
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:ColorWhite] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:ColorLoginBtnGary]];
    [self.loginBtn setTitle:GlobalString(@"Common_Next") forState:UIControlStateNormal];
    
    //用户协议
    self.protocolBtn.frame                    = CGRectMake(kCenterOriginX(280), self.view.bottom-50, 280, 40);
    self.protocolBtn.fontSize                 = 13;
    self.protocolBtn.titleLabel.textColor     = [UIColor whiteColor];
    NSMutableAttributedString * protocolStr   = [[NSMutableAttributedString alloc] initWithString:GlobalString(@"Login_Protocol")];
    [self.protocolBtn setAttributedTitle:protocolStr forState:UIControlStateNormal];
}

#pragma mark- event Response


- (void)nextLogin:(id)sender
{
    
//    //进入主页
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ENTER_MAIN object:nil];
//    return;
    
    if (self.loginTextField.text.length < 1) {
        [self showHint:GlobalString(@"Login_UsernameNotNull")];
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
                slVC.hideNavbar                  = YES;                
                slVC.username                    = self.loginTextField.text;
                [self pushVC:slVC];
            }
            
            if (direction == registerDirection) {
                [self hideHud];
                RegisterViewController * rvc = [[RegisterViewController alloc] init];
                rvc.phoneNumber              = self.loginTextField.text;
                rvc.hideNavbar               = YES;
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
