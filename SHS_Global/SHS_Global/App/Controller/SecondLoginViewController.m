//
//  SecondLoginViewController.m
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/19.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "SecondLoginViewController.h"
#import "NSString+Encrypt.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"

@interface SecondLoginViewController ()

//密码
@property(nonatomic, strong) CustomTextField * passwordTextField;
//登录
@property(nonatomic, strong) CustomButton * loginBtn;
//找回密码
@property(nonatomic, strong) CustomButton * findPwdBtn;

@end

@implementation SecondLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWidget];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- layout
- (void)initWidget
{
    UIView * pwdBackView        = [[UIView alloc] initWithFrame:CGRectMake(0, 72, self.viewWidth, 60)];
    pwdBackView.backgroundColor = [UIColor colorWithHexString:ColorWhite];
    [self.view addSubview:pwdBackView];
    
    //登录按钮
    self.loginBtn          = [[CustomButton alloc] init];
    //密码textfield
    self.passwordTextField = [[CustomTextField alloc] init];
    self.findPwdBtn        = [[CustomButton alloc] init];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.findPwdBtn];
    
    //设置事件
    [self.loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.findPwdBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)configUI
{
    
    self.view.backgroundColor   = [UIColor colorWithHexString:ColorSecondLoginBackground];
    
    //placeHolder处理
    UIFont * placeHolderFont                  = [UIFont systemFontOfSize:FontLoginTextField];
    UIColor * placeHolderWhite                = [UIColor colorWithHexString:ColorSecondLoginPlaceHolder];
    NSAttributedString * placeHolderString    = [[NSAttributedString alloc] initWithString:GlobalString(@"请输入密码") attributes:@{NSFontAttributeName:placeHolderFont,NSForegroundColorAttributeName:placeHolderWhite}];
    //loginTextFiled样式处理
    self.passwordTextField.frame                 = CGRectMake(kCenterOriginX((self.viewWidth-50)), 85, self.viewWidth-50, 35);
    self.passwordTextField.delegate              = self;
    self.passwordTextField.secureTextEntry       = YES;
    self.passwordTextField.clearButtonMode       = UITextFieldViewModeWhileEditing;
    self.passwordTextField.attributedPlaceholder = placeHolderString;
    self.passwordTextField.font                  = placeHolderFont;
    self.passwordTextField.textColor             = [UIColor colorWithHexString:ColorBlack];
    self.passwordTextField.tintColor             = [UIColor colorWithHexString:ColorBlack];
    self.passwordTextField.backgroundColor       = [UIColor colorWithHexString:ColorWhite];
    
    //btn样式处理
    self.loginBtn.frame                       = CGRectMake(kCenterOriginX((self.viewWidth-30)), 192, (self.viewWidth-30), 45);
    self.loginBtn.layer.cornerRadius          = 5;
    self.loginBtn.fontSize                    = FontLoginButton;
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:ColorWhite] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:ColorLoginBtnGary]];
    [self.loginBtn setTitle:GlobalString(@"SecondLogin_Login") forState:UIControlStateNormal];
    
    //找回密码
    self.findPwdBtn.frame                        = CGRectMake(self.viewWidth-100, self.loginBtn.bottom+15, 85, 13);
    self.findPwdBtn.fontSize                     = 13;
    self.findPwdBtn.contentHorizontalAlignment   = UIControlContentHorizontalAlignmentRight;
    [self.findPwdBtn setTitleColor:[UIColor colorWithHexString:ColorBlack] forState:UIControlStateNormal];
    [self.findPwdBtn setTitle:GlobalString(@"SecondLogin_ForgetPwd") forState:UIControlStateNormal];

}

#pragma mark- override
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.passwordTextField resignFirstResponder];
}

#pragma mark- method response
- (void)loginClick:(id)sender {
    
    if (self.passwordTextField.text.length < 6) {
        [self showHint:GlobalString(@"SecondLogin_PwdAtLeastSix")];
        return;
    }
    NSDictionary * dic = @{@"username":self.username,
                           @"password":[self.passwordTextField.text MD5]};
    [HttpService postWithUrlString:API_LoginUser params:dic andCompletion:^(id responseData) {

        int status = [responseData[@"status"] intValue];
        if (status == HttpStatusCodeSuccess) {

            //数据注入
            [[[UserService sharedService] user] setModelWithDic:responseData[@"result"]];
            //数据本地缓存
            [[UserService sharedService] saveAndUpdate];
            //进入主页
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ENTER_MAIN object:nil];
            
        }else{
            [self showFail:GlobalString(@"SecondLogin_UsernameOrPwdError")];
        }
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];
    
}

- (void)forgetPwd:(id)sender {
    
    //忘记密码
    RegisterViewController * vvc = [[RegisterViewController alloc] init];
    vvc.phoneNumber            = self.username;
    vvc.isFindPwd              = YES;
    [self pushVC:vvc];
    
}

#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.passwordTextField resignFirstResponder];
    return YES;
}

@end
