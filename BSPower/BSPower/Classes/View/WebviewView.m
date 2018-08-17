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

@end

@implementation WebviewView

- (void)initView:(id<ViewControllerDelegate>)delegate {
    _mDelegate = delegate;
    
    self.backgroundColor = [UIColor blackColor];
    
//    NSString *url = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    NSString *url = [[BSPConfig sharedBSPConfig] getWebUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    [self addSubview:webview];
    webview.delegate = self;
    [webview loadRequest:request];
    
    CGFloat backBtnHeight = [[BSPUtils sharedBSPUtils] adaptedNumber:17];
    CGFloat backBtnWidth = [[BSPUtils sharedBSPUtils] adaptedNumber:12];
    CGFloat backBtnLeft = [[BSPUtils sharedBSPUtils] adaptedNumber:10];
    CGFloat backBtnTop = [[BSPUtils sharedBSPUtils] adaptedNumber:20];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(backBtnLeft, backBtnTop, backBtnWidth, backBtnHeight)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:backBtn];
}

- (void)backBtnAction:(id)sender {
    if (_mDelegate && [_mDelegate respondsToSelector:@selector(replace:transition:)]) {
        [_mDelegate replace:@"login" transition:nil];
    }
}

-(void)jsLogout {
    if (self->_mDelegate && [self->_mDelegate respondsToSelector:@selector(replace:transition:)]) {
        [self->_mDelegate replace:@"login"transition:@"UIViewAnimationTransitionFlipFromLeft"];
    }
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    AppJSObject *jsObject = [AppJSObject new];
    jsObject.delegate = self;
    context[@"nativeUtils"] = jsObject;
    
}

@end
