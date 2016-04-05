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

    
    [self.reverifyBtn addTarget:self action:@selector(resend:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn addTarget:self action:@selector(verifyPress:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)configUI
{
    self.view.backgroundColor     = [UIColor colorWithHexString:ColorSecondLoginBackground];
    
    //顶部白色背景
    UIView * whiteBackView        = [[UIView alloc] initWithFrame:CGRectMake(0, 119, self.viewWidth, 120)];
    whiteBackView.backgroundColor = [UIColor colorWithHexString:ColorWhite];
    [self.view addSubview:whiteBackView];
    
    [whiteBackView addSubview:self.passwordTextField];
    [whiteBackView addSubview:self.verifyTextField];
    [whiteBackView addSubview:self.reverifyBtn];
    
    //标题
    CustomLabel * textLabel                    = [[CustomLabel alloc] initWithFontSize:14];
    textLabel.textColor                        = [UIColor colorWithHexString:ColorBlack];
    textLabel.frame                            = CGRectMake(kCenterOriginX((self.viewWidth-30)), 79, self.viewWidth-30, 15);
    textLabel.text                             = [NSString stringWithFormat:GlobalString(@"RegisterHasSend") , self.phoneNumber];
    [self.view addSubview:textLabel];
    
    //placeHolder处理 验证textView
    UIFont * placeHolderFont                   = [UIFont systemFontOfSize:FontLoginTextField];
    UIColor * placeHolderWhite                 = [UIColor colorWithHexString:ColorSecondLoginPlaceHolder];
    NSAttributedString * placeHolderString1    = [[NSAttributedString alloc] initWithString:GlobalString(@"RegisterPleaseEnterVerify") attributes:@{NSFontAttributeName:placeHolderFont,NSForegroundColorAttributeName:placeHolderWhite}];
    //loginTextFiled样式处理
    self.verifyTextField.frame                 = CGRectMake(25, 13, self.viewWidth-110, 35);
    self.verifyTextField.delegate              = self;
    self.verifyTextField.attributedPlaceholder = placeHolderString1;
    self.verifyTextField.font                  = placeHolderFont;
    self.verifyTextField.clearButtonMode       = UITextFieldViewModeWhileEditing;
    self.verifyTextField.textColor             = [UIColor colorWithHexString:ColorBlack];
    self.verifyTextField.tintColor             = [UIColor colorWithHexString:ColorBlack];
    self.verifyTextField.keyboardType          = UIKeyboardTypeNumberPad;
    self.verifyTextField.backgroundColor       = [UIColor colorWithHexString:ColorWhite];
    
    //重发按钮
    self.reverifyBtn.frame                     = CGRectMake(self.verifyTextField.right+5, self.verifyTextField.y, 65, self.verifyTextField.height);
    self.reverifyBtn.titleLabel.font           = [UIFont systemFontOfSize:13];
    [self.reverifyBtn setTitleColor:[UIColor colorWithHexString:ColorBlack] forState:UIControlStateNormal];
    self.reverifyBtn.enabled                   = NO;
    [self.reverifyBtn setTitle:@"60s" forState:UIControlStateNormal];
    
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(kCenterOriginX((self.viewWidth-30)), 59, self.viewWidth-30, 1)];
    bottomLine.backgroundColor = [UIColor colorWithHexString:ColorLoginLineGary];
    [whiteBackView addSubview:bottomLine];
    
    //placeHolder处理
    NSAttributedString * placeHolderString       = [[NSAttributedString alloc] initWithString:GlobalString(@"SecondLogin_PleaseEnterPwd") attributes:@{NSFontAttributeName:placeHolderFont,NSForegroundColorAttributeName:placeHolderWhite}];
    //loginTextFiled样式处理
    self.passwordTextField.frame                 = CGRectMake(25, 73, 280, 35);
    self.passwordTextField.delegate              = self;
    self.passwordTextField.secureTextEntry       = YES;
    self.passwordTextField.clearButtonMode       = UITextFieldViewModeWhileEditing;
    self.passwordTextField.attributedPlaceholder = placeHolderString;
    self.passwordTextField.font                  = placeHolderFont;
    self.passwordTextField.textColor             = [UIColor colorWithHexString:ColorBlack];
    self.passwordTextField.tintColor             = [UIColor colorWithHexString:ColorBlack];
    self.passwordTextField.backgroundColor       = [UIColor whiteColor];
    
    //btn样式处理
    self.registerBtn.frame                       = CGRectMake(kCenterOriginX((self.viewWidth-30)), whiteBackView.bottom+60, (self.viewWidth-30), 45);
    self.registerBtn.layer.cornerRadius          = 5;
    self.registerBtn.fontSize                    = FontLoginButton;
    [self.registerBtn setTitleColor:[UIColor colorWithHexString:ColorWhite] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:[UIColor colorWithHexString:ColorLoginBtnGary]];
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
            //找回密码成功进入主页
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ENTER_MAIN object:nil];
            
        }else{
            [self showFail:GlobalString(@"RegisterVerifyError")];
        }
  
    } andFail:^(NSError *error) {
        [self showFail:StringCommonNetException];
    }];
}

- (void)findPwdLogin:(id)sender
{
    
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
            //找回密码成功进入主页
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ENTER_MAIN object:nil];
            
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
