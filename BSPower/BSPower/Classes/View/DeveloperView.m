//
//  DeveloperView.m
//  BSPower
//
//  Created by guozhi tan on 2018/8/16.
//  Copyright © 2018 sinosoft. All rights reserved.
//

#import "DeveloperView.h"

@interface DeveloperView ()


@property(nonatomic, retain)UITextField *mServerUrlTxtField;
@property(nonatomic, retain)UITextField *mTxtField;
@property(nonatomic, retain)id<ViewControllerDelegate> mDelegate;

@end

@implementation DeveloperView

- (void)initView:(id<ViewControllerDelegate>)delegate {
    _mDelegate = delegate;
    
    [self createBG];
    
    //label
    CGFloat serverLabelHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat serverLabelTop = (CGRectGetHeight(self.frame)-serverLabelHeight)/2;
    UILabel *serverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, serverLabelTop, CGRectGetWidth(self.frame), serverLabelHeight)];
    serverLabel.textAlignment = NSTextAlignmentCenter;
    serverLabel.text = @"服务器地址";
    serverLabel.font = [UIFont systemFontOfSize:[[BSPUtils sharedBSPUtils] adaptedNumber:12]];
    [self addSubview:serverLabel];
    
    CGFloat serverImgHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat serverImgLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat serverImgTop = serverLabelTop+serverLabelHeight+[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    UIImageView *serverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(serverImgLeft, serverImgTop, serverImgHeight, serverImgHeight)];
    serverImageView.image = [UIImage imageNamed:@"server_img.png"];
    [self addSubview:serverImageView];
    
    CGFloat serverTxtHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat serverTxtWidth = CGRectGetWidth(self.frame)-CGRectGetMaxX(serverImageView.frame)-[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat serverTxtLeft = CGRectGetMaxX(serverImageView.frame);
    CGFloat serverTxtTop = serverImgTop;
    _mServerUrlTxtField = [[UITextField alloc] initWithFrame:CGRectMake(serverTxtLeft, serverTxtTop, serverTxtWidth, serverTxtHeight)];
    _mServerUrlTxtField.borderStyle = UITextBorderStyleLine;
    _mServerUrlTxtField.text = @"http://";
    [self addSubview:_mServerUrlTxtField];
    
    //label
    CGFloat labelHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat labelTop = CGRectGetMaxY(serverImageView.frame)+ [[BSPUtils sharedBSPUtils] adaptedNumber:20];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, labelTop, CGRectGetWidth(self.frame), labelHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"H5地址";
    label.font = [UIFont systemFontOfSize:[[BSPUtils sharedBSPUtils] adaptedNumber:12]];
    [self addSubview:label];
    
    CGFloat imgHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat imgLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat imgTop = labelTop+labelHeight+[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgLeft, imgTop, imgHeight, imgHeight)];
    imageView.image = [UIImage imageNamed:@"server_img.png"];
    [self addSubview:imageView];
    
    CGFloat txtHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat txtWidth = CGRectGetWidth(self.frame)-CGRectGetMaxX(imageView.frame)-[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat txtLeft = CGRectGetMaxX(imageView.frame);
    CGFloat txtTop = imgTop;
    _mTxtField = [[UITextField alloc] initWithFrame:CGRectMake(txtLeft, txtTop, txtWidth, txtHeight)];
    _mTxtField.borderStyle = UITextBorderStyleLine;
    _mTxtField.text = @"http://";
    [self addSubview:_mTxtField];
    
    CGFloat enterBtnHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat enterBtnWidth = CGRectGetWidth(self.frame)-2*[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat enterBtnLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat enterBtnTop = CGRectGetMaxY(imageView.frame)+[[BSPUtils sharedBSPUtils] adaptedNumber:10];
    UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(enterBtnLeft, enterBtnTop, enterBtnWidth, enterBtnHeight)];
    [enterBtn setTitle:@"确定" forState:UIControlStateNormal];
    enterBtn.backgroundColor = [UIColor redColor];
    [enterBtn addTarget:self action:@selector(enterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:enterBtn];
    
    
    NSString *webUrl = [[NSUserDefaults standardUserDefaults] objectForKey:WEBVIEW_URL];
    if (webUrl && ![@"" isEqualToString:webUrl]) {
        _mTxtField.text = webUrl;
    }
    
    NSString *serverUrl = [[NSUserDefaults standardUserDefaults] objectForKey:SERVER_URL];
    if (serverUrl && ![@"" isEqualToString:serverUrl]) {
        _mServerUrlTxtField.text = serverUrl;
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

- (void)enterBtnAction:(id)sender {
    //存入数组并同步
    [[NSUserDefaults standardUserDefaults] setObject:_mServerUrlTxtField.text forKey:SERVER_URL];
    [[NSUserDefaults standardUserDefaults] setObject:_mTxtField.text forKey:WEBVIEW_URL];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[BSPConfig sharedBSPConfig] setWebUrl:_mTxtField.text];
    if (_mDelegate && [_mDelegate respondsToSelector:@selector(replace:transition:)]) {
        [_mDelegate replace:@"login" transition:@"UIViewAnimationTransitionFlipFromLeft"];
    }
}

@end
