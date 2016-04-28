//
//  RegisterViewController.m
//  SHS_Contact_iOS
//
//  Created by 李晓航 on 16/2/19.
//  Copyright © 2016年 SHS. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+Encrypt.h"

@interface RegisterViewController ()

//注册按钮
@property (nonatomic, strong) CustomButton    * registerBtn;
//密码textfield
@property (nonatomic, strong) CustomTextField * passwordTextField;

@property (nonatomic, strong) CustomButton    * reverifyBtn;
@property (nonatomic, strong) CustomTextField * verifyTextField;
//倒计时
@property (nonatomic, strong) NSTimer         * timer;
@property (nonatomic, assign) int             timerNum;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取验证码
    [self getVerify];
    
    self.timerNum = 60;
    
    [self createWidget];
    [self configUI];
    [self initOperator];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
    }
}

#pragma mark- override
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.verifyTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark- layout
- (void)createWidget
{
    
    //验证码
    self.verifyTextField   = [[CustomTextField alloc] init];
    //重新验证
    self.reverifyBtn       = [[CustomButton alloc] init];
    //注册
    self.registerBtn       = [[CustomButton alloc] init];
    //密码
    self.passwordTextField = [[CustomTextField alloc] init];
    [self.view addSubview:self.registerBtn];

    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.verifyTextField];
    [self.view addSubview:self.reverifyBtn];
    
    [self.reverifyBtn addTarget:self action:@selector(resend:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn addTarget:self action:@selector(verifyPress:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)configUI
{
    [self setNavBarTitle:GlobalString(@"RegisterTitle")];
    self.view.backgroundColor = [UIColor colorWithHexString:ColorWhite];
    //标题
    CustomLabel * textLabel                    = [[CustomLabel alloc] initWithFontSize:14];
    textLabel.textColor                        = [UIColor colorWithHexString:ColorBlack];
    textLabel.frame                            = CGRectMake(kCenterOriginX((self.viewWidth-30)), kNavBarAndStatusHeight+25, self.viewWidth-30, 14);
    textLabel.text                             = [NSString stringWithFormat:GlobalString(@"RegisterHasSend") , self.phoneNumber];
    [self.view addSubview:textLabel];
    
    //验证textView
    self.verifyTextField.frame               = CGRectMake(15, textLabel.bottom+15, self.viewWidth-143, 45);
    self.verifyTextField.delegate            = self;
    self.verifyTextField.placeholder         = GlobalString(@"RegisterPleaseEnterVerify");
    self.verifyTextField.font                = [UIFont systemFontOfSize:FontLoginTextField];
    self.verifyTextField.clearButtonMode     = UITextFieldViewModeWhileEditing;
    self.verifyTextField.keyboardType        = UIKeyboardTypeNumberPad;
    self.verifyTextField.layer.cornerRadius  = 3;
    self.verifyTextField.leftView            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.verifyTextField.leftViewMode        = UITextFieldViewModeAlways;
    self.verifyTextField.layer.borderWidth   = 1;
    self.verifyTextField.layer.masksToBounds = YES;
    self.verifyTextField.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    
    //重发按钮
    self.reverifyBtn.frame                     = CGRectMake(self.verifyTextField.right+10, self.verifyTextField.y, 103, self.verifyTextField.height);
    self.reverifyBtn.backgroundColor           = [UIColor colorWithHexString:ColorVerifyBack];
    self.reverifyBtn.titleLabel.font           = [UIFont systemFontOfSize:FontLoginTextField];
    self.reverifyBtn.layer.cornerRadius        = 3;
    self.reverifyBtn.enabled                   = NO;
    [self.reverifyBtn setTitleColor:[UIColor colorWithHexString:ColorWhite] forState:UIControlStateNormal];
    [self.reverifyBtn setTitle:@"60s" forState:UIControlStateNormal];
    
    //loginTextFiled样式处理
    self.passwordTextField.frame               = CGRectMake(kCenterOriginX((self.viewWidth-30)), self.reverifyBtn.bottom+20, self.viewWidth-30, 45);
    self.passwordTextField.placeholder         = GlobalString(@"SecondLogin_PleaseEnterPwd");
    self.passwordTextField.layer.cornerRadius  = 3;
    self.passwordTextField.secureTextEntry     = YES;    
    self.passwordTextField.leftView            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.passwordTextField.leftViewMode        = UITextFieldViewModeAlways;
    self.passwordTextField.layer.borderWidth   = 1;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderColor   = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    self.passwordTextField.delegate            = self;
    self.passwordTextField.font                = [UIFont systemFontOfSize:FontLoginTextField];
    self.passwordTextField.clearButtonMode     = UITextFieldViewModeWhileEditing;
    self.passwordTextField.textColor           = [UIColor colorWithHexString:ColorBlack];
    self.passwordTextField.tintColor           = [UIColor colorWithHexString:ColorBlack];
    self.passwordTextField.keyboardType        = UIKeyboardTypeNumberPad;
    self.passwordTextField.backgroundColor     = [UIColor whiteColor];
    
    //btn样式处理
    self.registerBtn.frame                       = CGRectMake(kCenterOriginX((self.viewWidth-30)), self.passwordTextField.bottom+30, (self.viewWidth-30), 45);
    self.registerBtn.layer.cornerRadius          = 5;
    self.registerBtn.layer.borderWidth           = 1;
    self.registerBtn.layer.masksToBounds         = YES;
    self.registerBtn.layer.borderColor           = [UIColor colorWithHexString:ColorTextBorder].CGColor;
    self.registerBtn.fontSize                    = FontLoginButton;
    [self.registerBtn setTitleColor:[UIColor colorWithHexString:ColorTextBorder] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorWithHexString:ColorLoginBtnGray] forState:UIControlStateHighlighted];
    [self.registerBtn setTitle:GlobalString(@"Common_Next") forState:UIControlStateNormal];
    
}

#pragma mark- event Response
- (void)verifyPress:(id)sender
{
    
    if (self.isFindPwd) {
        [self findPwdLogin:nil];
    }else{
        [self registerLogin:nil];
    }

}

- (void)registerLogin:(id)sender
{
    if (self.verifyTextField.text.length < 1) {
        [self showHint:GlobalString(@"RegisterVerifyNotNull")];
        return;
    }
    
    if (self.passwordTextField.text.length < 6) {
        [self showHint:GlobalString(@"SecondLogin_PwdAtLeastSix")];
        return;
    }
    
    NSDictionary * dic = @{@"username":self.phoneNumber,
                           @"password":[self.passwordTextField.text MD5],
                           @"code":[self.verifyTextField.text trim]};
    [HttpService postWithUrlString:API_RegisterUser params:dic andCompletion:^(id responseData) {
        NSLog(@"%@", responseData);
        
        int status = [responseData[@"status"] intValue];
        if (status == HttpStatusCodeSuccess) {
            [[[UserService sharedService] user] setModelWithDic:responseData[@"result"]];
            //数据本地缓存
            [[UserService sharedService] saveAndUpdate];
            //隐藏
            [self hideHud];
            [self showSuccess:GlobalString(@"RegisterRegisterSuccess")];
//            //找回密码成功进入主页
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ENTER_MAIN object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];            
        }else{
            [self showFail:GlobalString(@"RegisterVerifyError")];
        }
  
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];
}

- (void)findPwdLogin:(id)sender
{
    
    if (self.verifyTextField.text.length < 1) {
        [self showHint:GlobalString(@"RegisterVerifyNotNull")];
        return;
    }
    
    if (self.passwordTextField.text.length < 6) {
        [self showHint:GlobalString(@"SecondLogin_PwdAtLeastSix")];
        return;
    }
    
    NSDictionary * dic = @{@"username":self.phoneNumber,
                           @"password":[self.passwordTextField.text MD5],
                           @"code":[self.verifyTextField.text trim]};
    [HttpService postWithUrlString:API_FindPwdUser params:dic andCompletion:^(id responseData) {
        
        int status = [responseData[@"status"] intValue];
        if (status == HttpStatusCodeSuccess) {
            [[[UserService sharedService] user] setModelWithDic:responseData[@"result"]];
            //数据本地缓存
            [[UserService sharedService] saveAndUpdate];

            //隐藏
            [self hideHud];
            [self showSuccess:GlobalString(@"RegisterUpdateSuccess")];
//            //找回密码成功进入主页
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ENTER_MAIN object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self showFail:StringCommonNetException];
        }

    } andFail:^(NSError *error) {
           [self showFail:StringCommonNetException];
    }];
}

#pragma mark- UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark- private method
- (void)initOperator
{
   self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerResend:) userInfo:nil repeats:YES];
}

//获取验证码
- (void)getVerify
{

    NSString * url = API_RegisterSms;
    if (self.isFindPwd) {
        url = API_FindPwdSms;
    }
    debugLog(@"%@", url);
    NSDictionary * dic = @{@"phone_num":self.phoneNumber};
    [HttpService postWithUrlString:url params:dic andCompletion:^(id responseData) {

        if ([responseData[HttpStatus] integerValue] == 1) {
            [self hideHud];
            [self showSuccess:GlobalString(@"RegisterVerifySendSuccess")];
        }else{
            [self hideHud];
            [self showHint:GlobalString(@"RegisterVerifySendFail")];
            [self.timer invalidate];
            //点击重发
            [self.reverifyBtn setTitle:GlobalString(@"RegisterResend") forState:UIControlStateNormal];
            self.reverifyBtn.enabled = YES;
        }
        
    } andFail:^(NSError *error) {
        [self hideHud];
        [self showHint:GlobalString(@"RegisterVerifySendFail")];
        [self.timer invalidate];
        //点击重发
        [self.reverifyBtn setTitle:GlobalString(@"RegisterResend") forState:UIControlStateNormal];
        self.reverifyBtn.enabled = YES;
    }];
}

- (void)timerResend:(id)sender
{
    self.timerNum --;
    [self.reverifyBtn setTitle:[NSString stringWithFormat:@"%ds", self.timerNum] forState:UIControlStateNormal];
    
    if (self.timerNum == 0) {
        [self.timer invalidate];
        [self.reverifyBtn setTitle:[NSString stringWithFormat:GlobalString(@"RegisterResend")] forState:UIControlStateNormal];
        self.reverifyBtn.enabled = YES;
        return;
    }
    
}

- (void)resend:(id)sender
{
    [self showHudInView:self.view hint:GlobalString(@"RegisterResending")];

    //获取验证码
    [self getVerify];
    self.timerNum = 60;
    self.reverifyBtn.enabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerResend:) userInfo:nil repeats:YES];
    
}

@end
