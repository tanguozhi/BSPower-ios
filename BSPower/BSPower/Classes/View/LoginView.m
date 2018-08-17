//
//  LoginView.m
//  BSPower
//
//  Created by guozhi tan on 2018/8/16.
//  Copyright © 2018 sinosoft. All rights reserved.
//

#import "LoginView.h"
#import "NetworkUtils.h"


@interface LoginView () <NetworkUtilsDelegate, UITextFieldDelegate>{
    BOOL        mIsChecked;
}

@property(nonatomic, retain)UITextField *mUserTxtField;
@property(nonatomic, retain)UITextField *mPassxtField;
@property(nonatomic, retain)id<ViewControllerDelegate> mDelegate;

@end

@implementation LoginView

- (void)initView:(id<ViewControllerDelegate>)delegate {
    _mDelegate = delegate;
    
    [self createBG];
    
    CGFloat viewLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat viewTop = CGRectGetHeight(self.frame)/2-[[BSPUtils sharedBSPUtils] adaptedNumber:50];
    CGFloat viewWidth = CGRectGetWidth(self.frame)-2*viewLeft;
    CGFloat viewHeight = CGRectGetHeight(self.frame)-viewTop;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewLeft, viewTop, viewWidth, viewHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    CGFloat userImgHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat userImgLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat userImgTop = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(userImgLeft, userImgTop, userImgHeight, userImgHeight)];
    userImageView.image = [UIImage imageNamed:@"server_img.png"];
    [view addSubview:userImageView];
    
    //用户名输入框
    CGFloat userTxtHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat userTxtWidth = CGRectGetWidth(self.frame)-CGRectGetMaxX(userImageView.frame)-[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat userTxtLeft = CGRectGetMaxX(userImageView.frame);
    CGFloat userTxtTop = userImgTop;
    _mUserTxtField = [[UITextField alloc] initWithFrame:CGRectMake(userTxtLeft, userTxtTop, userTxtWidth, userTxtHeight)];
    _mUserTxtField.placeholder = @"请输入用户名";
    _mUserTxtField.delegate = self;
    [view addSubview:_mUserTxtField];
    
    CGFloat passImgHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat passImgLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat passImgTop = CGRectGetMaxY(userImageView.frame)+[[BSPUtils sharedBSPUtils] adaptedNumber:20];
    UIImageView *passImageView = [[UIImageView alloc] initWithFrame:CGRectMake(passImgLeft, passImgTop, passImgHeight, passImgHeight)];
    passImageView.image = [UIImage imageNamed:@"server_img.png"];
    [view addSubview:passImageView];
    
    //密码输入框
    CGFloat passTxtHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat passTxtWidth = CGRectGetWidth(self.frame)-CGRectGetMaxX(userImageView.frame)-[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat passTxtLeft = CGRectGetMaxX(userImageView.frame);
    CGFloat passTxtTop = passImgTop;
    _mPassxtField = [[UITextField alloc] initWithFrame:CGRectMake(passTxtLeft, passTxtTop, passTxtWidth, passTxtHeight)];
    _mPassxtField.placeholder = @"请输入密码";
    _mPassxtField.delegate = self;
    _mPassxtField.secureTextEntry = true;
    [view addSubview:_mPassxtField];
    
    //记住密码按钮
    CGFloat checkboxBtnHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat checkboxBtnWidth = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat checkboxBtnLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat checkboxBtnTop = CGRectGetMaxY(passImageView.frame)+[[BSPUtils sharedBSPUtils] adaptedNumber:20];
    UIButton *checkboxBtn = [[UIButton alloc] initWithFrame:CGRectMake(checkboxBtnLeft, checkboxBtnTop, checkboxBtnWidth, checkboxBtnHeight)];
    [checkboxBtn setImage:[UIImage imageNamed:@"checkBox"] forState:UIControlStateNormal];
    [checkboxBtn addTarget:self action:@selector(checkboxBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:checkboxBtn];
    NSString *isSavePassword = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_IS_SAVE_PASSWORD];
    if (isSavePassword && [isSavePassword boolValue]) {
        mIsChecked = true;
        [checkboxBtn setImage:[UIImage imageNamed:@"checkBoxSelected"] forState:UIControlStateNormal];
    }
    
    //记住密码
    CGFloat labelHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat labelWidth = [[BSPUtils sharedBSPUtils] adaptedNumber:100];
    CGFloat labelTop = checkboxBtnTop;
    CGFloat labelLeft = CGRectGetMaxX(checkboxBtn.frame)+[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, labelTop, labelWidth, labelHeight)];
    label.text = @"记住密码";
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:[[BSPUtils sharedBSPUtils] adaptedNumber:12]]];
    [view addSubview:label];
    
    //服务器地址设置按钮
    CGFloat settingBtnHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat settingBtnWidth = [[BSPUtils sharedBSPUtils] adaptedNumber:100];
    CGFloat settingBtnLeft = CGRectGetWidth(view.frame)-settingBtnWidth;
    CGFloat settingBtnTop = CGRectGetMaxY(passImageView.frame)+[[BSPUtils sharedBSPUtils] adaptedNumber:20];
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(settingBtnLeft, settingBtnTop, settingBtnWidth, settingBtnHeight)];
    [settingBtn setTitle:@"设置地址" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[[BSPUtils sharedBSPUtils] getColorFromHex:@"#aec8e4"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:[[BSPUtils sharedBSPUtils] adaptedNumber:12]];
    [view addSubview:settingBtn];
    
    //登录按钮
    CGFloat enterBtnHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat enterBtnWidth = CGRectGetWidth(view.frame)-2*[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat enterBtnLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat enterBtnTop = CGRectGetMaxY(checkboxBtn.frame)+[[BSPUtils sharedBSPUtils] adaptedNumber:20];
    UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(enterBtnLeft, enterBtnTop, enterBtnWidth, enterBtnHeight)];
    [enterBtn setTitle:@"登 录" forState:UIControlStateNormal];
    enterBtn.backgroundColor = [[BSPUtils sharedBSPUtils] getColorFromHex:@"#4e96de"];
    [enterBtn addTarget:self action:@selector(enterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:enterBtn];

    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_NAME];
    if (userName && ![@"" isEqualToString:userName]) {
        _mUserTxtField.text = userName;
    }
    
    NSString *userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_PASSWORD];
    if (userPassword && ![@"" isEqualToString:userPassword]) {
        _mPassxtField.text = userPassword;
    }
}

- (void)createBG {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    UIColor *startColor = [[BSPUtils sharedBSPUtils] getColorFromHex:@"#4e91d3"];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2+[[BSPUtils sharedBSPUtils] adaptedNumber:20]);
    [self.layer addSublayer:gradientLayer];
    
    //label
    CGFloat labelHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat labelTop = [[BSPUtils sharedBSPUtils] adaptedNumber:50];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, labelTop, CGRectGetWidth(self.frame), labelHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"百色电力责任有限公司";
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:[[BSPUtils sharedBSPUtils] adaptedNumber:20]]];
    [self addSubview:label];
    
    //label
    CGFloat labelHeight2 = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat labelTop2 = CGRectGetMaxY(label.frame)+[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, labelTop2, CGRectGetWidth(self.frame), labelHeight2)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"综合办公平台";
    [label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:[[BSPUtils sharedBSPUtils] adaptedNumber:23]]];
    [label2 setTextColor:[UIColor whiteColor]];
    [self addSubview:label2];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//收起键盘
    return YES;
}

- (void)checkboxBtnAction:(id)sender {
    mIsChecked = !mIsChecked;
    if (mIsChecked) {
        [((UIButton *)sender) setImage:[UIImage imageNamed:@"checkBoxSelected"] forState:UIControlStateNormal];
    } else {
        [((UIButton *)sender) setImage:[UIImage imageNamed:@"checkBox"] forState:UIControlStateNormal];
    }
}
- (void)settingBtnAction:(id)sender {
    if (_mDelegate && [_mDelegate respondsToSelector:@selector(replace:transition:)]) {
        [_mDelegate replace:@"developer" transition:@"UIViewAnimationTransitionFlipFromRight"];
    }
}

- (void)enterBtnAction:(id)sender {
    if ([@"" isEqualToString:_mUserTxtField.text]) {
        [[BSPAlert sharedBSPAlert] alertWithTitle:@"提示" message:@"用户名不能为空！" okHanler:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    if ([@"" isEqualToString:_mPassxtField.text]) {
        [[BSPAlert sharedBSPAlert] alertWithTitle:@"提示" message:@"密码不能为空！" okHanler:^(UIAlertAction *action) {
            
        }];
        return;
    }
    //存入数组并同步
    [[NSUserDefaults standardUserDefaults] setObject:_mUserTxtField.text forKey:LOGIN_USER_NAME];
    if (mIsChecked) {
        [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:LOGIN_IS_SAVE_PASSWORD];
        [[NSUserDefaults standardUserDefaults] setObject:_mPassxtField.text forKey:LOGIN_USER_PASSWORD];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_IS_SAVE_PASSWORD];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_USER_PASSWORD];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *url = [NSString stringWithFormat:@"%@/module/loginAction.do?method=mobilLogin", [[BSPConfig sharedBSPConfig] getServerUrl]];
    NSString *_body = [NSString stringWithFormat:@"userCode=%@&userPassword=%@", _mUserTxtField.text, _mPassxtField.text];
    NSData *body = [_body dataUsingEncoding:NSUTF8StringEncoding];
    [[NetworkUtils sharedNetworkUtils] startAsyn:url header:nil body:body method:@"post" delegate:self];
}

/**connection请求成功后回调并返回请求结果.
 */
- (void)connectionDidFinish:(NSMutableDictionary *)resultDic {
    NSData *responseData = [resultDic objectForKey:NETWORK_RESPONSE_DATA];
    if (responseData) {
        NSString *resultJson = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = [[BSPUtils sharedBSPUtils] dictionaryWithJsonString:resultJson];
        if (resultDic) {
            NSString *result = [resultDic objectForKey:@"result"];
            if ([@"1" isEqualToString:result]) {
                if (_mDelegate && [_mDelegate respondsToSelector:@selector(replace:transition:)]) {
                    [_mDelegate replace:@"webview" transition:@"UIViewAnimationTransitionFlipFromRight"];
                } else {
                    [self handleLoginFaile];
                }
            }
        } else {
            [self handleLoginFaile];
        }
    }
}

/**connection请求失败后回调并返回失败结果.
 */
- (void)connectionDidFaile:(NSMutableDictionary *)resultDic  {
    [[BSPAlert sharedBSPAlert] alertWithTitle:@"提示" message:@"网络请求失败！" okHanler:^(UIAlertAction *action) {
        
    }];
}

- (void)handleLoginFaile {
    [[BSPAlert sharedBSPAlert] alertWithTitle:@"提示" message:@"登录失败" okHanler:^(UIAlertAction *action) {
        
    }];
}

@end
