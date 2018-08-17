//
//  WebviewView.m
//  BSPower
//
//  Created by guozhi tan on 2018/8/16.
//  Copyright © 2018 sinosoft. All rights reserved.
//

#import "WebviewView.h"
#import <JavaScriptCore/JSContext.h>

@implementation AppJSObject

-(void)jsShowBackButton:(BOOL)isShow {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self->_delegate) {
            [self->_delegate jsShowBackButton:isShow];
        }
    }];
}

-(void)jsLogout{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self->_delegate) {
            [self->_delegate jsLogout];
        }
    }];
}

@end

@interface WebviewView () <UIWebViewDelegate, AppJSObjectDelegate>

@property(nonatomic, retain)id<ViewControllerDelegate> mDelegate;
@property(nonatomic, retain)JSContext *mJSContext;
@property(nonatomic, retain)UIButton *mBackBtn;

@end

@implementation WebviewView

- (void)initView:(id<ViewControllerDelegate>)delegate {
    _mDelegate = delegate;
    
    self.backgroundColor = [UIColor blackColor];
    
    CGFloat navHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:60];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), navHeight)];
    [self addSubview:navView];
    navView.backgroundColor = [[BSPUtils sharedBSPUtils] getColorFromHex:@"#5f93cf"];
    
    CGFloat backBtnHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat backBtnWidth = [[BSPUtils sharedBSPUtils] adaptedNumber:30];
    CGFloat backBtnLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat backBtnTop = [[BSPUtils sharedBSPUtils] adaptedNumber:25];
    _mBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(backBtnLeft, backBtnTop, backBtnWidth, backBtnHeight)];
    [_mBackBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [_mBackBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    _mBackBtn.hidden = YES;
    [navView addSubview:_mBackBtn];
    
    
    CGFloat titleTop = [[BSPUtils sharedBSPUtils] adaptedNumber:20];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, titleTop, CGRectGetWidth(self.frame), navHeight-titleTop)];
    titleLabel.text = @"百色电力综合业务协同办公系统";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:[[BSPUtils sharedBSPUtils] adaptedNumber:15]];
    [navView addSubview:titleLabel];
    
    
//    NSString *url = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, navHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-navHeight)];
    webview.backgroundColor = [UIColor grayColor];
    NSString *url = [[BSPConfig sharedBSPConfig] getWebUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    [self addSubview:webview];
    webview.delegate = self;
    [webview loadRequest:request];
    
    
}

- (void)backBtnAction:(id)sender {
    if (_mJSContext) {
        [_mJSContext evaluateScript:@"history.back()"];
    }
}

-(void)jsShowBackButton:(BOOL)isShow {
    if (_mBackBtn) {
        _mBackBtn.hidden = !isShow;
    }
}

-(void)jsLogout {
    if (self->_mDelegate && [self->_mDelegate respondsToSelector:@selector(replace:transition:)]) {
        [self->_mDelegate replace:@"login"transition:@"UIViewAnimationTransitionFlipFromLeft"];
    }
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.mJSContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    AppJSObject *jsObject = [AppJSObject new];
    jsObject.delegate = self;
    _mJSContext[@"nativeUtils"] = jsObject;
}

//主要的协议方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //1.截取到当前地址
    NSString *url = request.URL.absoluteString;
    //2.做你想做的操作
    if (url && ([url rangeOfString:@"module/loginAction.do?method=logout"].length>0
                || [url rangeOfString:@"app/loginMobile.jsp"].length>0
                || [url rangeOfString:@"app/jsp/error/error404.jsp"].length>0)) {
        [self jsLogout];
        return NO;
    }
    return YES;
}

@end
