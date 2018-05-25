//
//  GHLoginViewController.m
//  GodHorses
//
//  Created by Mac on 2017/11/14.
//  Copyright © 2017年 stoneobs@icloud.com. All rights reserved.
//

#import "ViewController.h"
#import "UIView+TMTools.h"
#import "UIView+STKeybordAdjust.h"
#define UIScreenWidth UIScreen.mainScreen.bounds.size.width
@interface ViewController ()
@property(nonatomic, strong) UITextField                     *accountTextFiled;
@property(nonatomic, strong) UITextField                     *phoneTextFiled;
@property(nonatomic, strong) UITextField                     *pwdTextFiled;
@property(nonatomic, strong) UITextField                     *confimTextFiled;
@property(nonatomic, strong) UITextField                     *codeTextFiled;
@property(nonatomic, strong) UITextField                     *inviteTextFiled;
@property(nonatomic, strong) UITextField                     *ageTextFiled;
@property(nonatomic, strong) UIScrollView                     *scrollView;
@end

@implementation ViewController
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark --vc 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configSubView];
    [self addNotifacations];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark --Notifacation
- (void)addNotifacations{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChangeNotification:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
}
- (void)textFieldTextDidChangeNotification:(NSNotification*)notify{
    if (notify.object == self.pwdTextFiled) {
    }
}
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)loadView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.scrollView.backgroundColor = UIColor.whiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        [self.scrollView setContentInsetAdjustmentBehavior:@(2)];
    }
    self.view = self.scrollView;
}
#pragma mark --subView
- (void)configSubView{
    [self.view st_autoAdjustAllResponder];
    self.view.backgroundColor = UIColor.whiteColor;
    self.accountTextFiled = [UITextField new];
    self.phoneTextFiled = [UITextField new];
    self.pwdTextFiled = [UITextField new];
    self.pwdTextFiled.secureTextEntry = YES;
    self.confimTextFiled = [UITextField new];
    self.confimTextFiled.secureTextEntry = YES;
    self.codeTextFiled = [UITextField new];
    self.inviteTextFiled = [UITextField new];
    self.ageTextFiled = [UITextField new];
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 172)];
    backImageView.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:backImageView];
    
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 95, 46)];
    iconImageView.image = [UIImage imageNamed:@"title"];
    iconImageView.centerX = UIScreenWidth /2;
    iconImageView.top = 80;
    [self.view addSubview:iconImageView];
    
    
    
    UIView * accountView = [self normalTextField:self.accountTextFiled title:@"用户名"];
    accountView.top = backImageView.bottom  +10;
    self.accountTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:accountView];
    
    UIView * phoneView = [self normalTextField:self.phoneTextFiled title:@"手机号码"];
    phoneView.top = accountView.bottom  +20;
    self.phoneTextFiled.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:phoneView];
    
    
    UIView * pwdView = [self normalTextField:self.pwdTextFiled title:@"密码"];
    pwdView.top = phoneView.bottom + 20;
    self.accountTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:pwdView];
    
    UIView * confimView = [self normalTextField:self.confimTextFiled title:@"确认密码"];
    confimView.top = pwdView.bottom  + 20;
    self.accountTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:confimView];
    
    UIView * codeView = [self normalTextField:self.codeTextFiled title:@"手机验证码"];
    codeView.top = confimView.bottom  +20;
    self.codeTextFiled.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:codeView];
    
    UIView * inviteView = [self normalTextField:self.inviteTextFiled title:@"邀请码"];
    inviteView.top = codeView.bottom  +20;
    self.inviteTextFiled.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:inviteView];
    
    UIView * ageView = [self normalTextField:self.ageTextFiled title:@"年龄"];
    ageView.top = inviteView.bottom  +20;
    self.ageTextFiled.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:ageView];
    
    self.scrollView.contentSize = CGSizeMake(0, ageView.bottom  +30);
    
}
#pragma mark --STSendButtonDlegate
- (BOOL)STSendButtonWillClic:(UIButton *)button{
    if (self.phoneTextFiled.text.length != 11) {
        //[SVProgressHUD showErrorWithStatus:@"手机号格式错误"];
        return NO;
    }
    return YES;
}
#pragma mark --Action Method
- (void)onSelectedLoginButton{
    if (self.accountTextFiled.text.length == 0) {
       // [SVProgressHUD showErrorWithStatus:@"请输入用户名/手机号"];
        return;
    }
    
    if (self.pwdTextFiled.text.length == 0) {
       // [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    //[SVProgressHUD showWithStatus:@"注册中"];
    
}
- (void)onSelectedforgotButton{

}
- (void)onSelectedregisterButton{

}

#pragma mark --NetWork Method
- (void)sendcodeRequest{

}
- (void)sendRegisterRequest{
    
}
#pragma mark --private
- (UIView *)normalTextField:(UITextField *)textFiled title:(NSString *)title{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 70)];
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(15, 0, UIScreenWidth - 30, 35);
    label.text = title;
    label.textColor = UIColor.purpleColor;
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    textFiled.frame = CGRectMake(label.left, label.bottom, label.width, label.height);
    textFiled.placeholder = [NSString stringWithFormat:@"请输入%@",title];
    textFiled.textColor = UIColor.orangeColor;
    [view addSubview:textFiled];
    return view;
}

@end

