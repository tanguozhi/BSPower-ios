//
//  ViewController.m
//  BSPower
//
//  Created by guozhi tan on 2018/8/16.
//  Copyright © 2018 sinosoft. All rights reserved.
//

#import "ViewController.h"
#import "DeveloperView.h"
#import "LoginView.h"
#import "WebviewView.h"

@interface ViewController ()<ViewControllerDelegate>

@property(nonatomic, retain)UIView *mView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self replace:@"login" transition:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark ViewController Delegate
- (void)replace:(NSString *)pageName transition:(NSString *)type{
    UIImageView *imageView;
    if (type && _mView) {
        UIImage *image = GetImageFormView(_mView);
        if (image) {
            UIView *superview = self.view;
            imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = _mView.frame;
            [superview addSubview:imageView];
        }
    }
    
    if ([@"login" isEqualToString:pageName]) {
        _mView = [self loadLoginView];
    } else if ([@"developer" isEqualToString:pageName]) {
        _mView = [self loadDeveloperView];
    } else if ([@"webview" isEqualToString:pageName]) {
        _mView = [self loadWebviewView];
    }
    
    if (type && _mView && imageView) {
        UIViewAnimationTransition transition = UIViewAnimationTransitionNone;
        if ([type isEqualToString:@"UIViewAnimationTransitionFlipFromLeft"]) {
            transition = UIViewAnimationTransitionFlipFromLeft;
        } else if ([type isEqualToString:@"UIViewAnimationTransitionFlipFromRight"]) {
            transition = UIViewAnimationTransitionFlipFromRight;
        } else if ([type isEqualToString:@"UIViewAnimationTransitionCurlUp"]) {
            transition = UIViewAnimationTransitionCurlUp;
        } else if ([type isEqualToString:@"UIViewAnimationTransitionCurlDown"]) {
            transition = UIViewAnimationTransitionCurlDown;
        }
        
        UIView *superview = self.view;
        [_mView removeFromSuperview];
        
        [UIView beginAnimations:@"transition" context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:transition forView:self.view cache:NO];
        [imageView removeFromSuperview];
        [superview addSubview:_mView];
        [UIView commitAnimations];
    }
}

#pragma mark -
#pragma mark 开发界面
- (UIView *)loadDeveloperView {
    [self.view removeAllSubviews];
    
    DeveloperView *developerView = [[DeveloperView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    developerView.backgroundColor = [UIColor whiteColor];
    [developerView initView:self];
    [self.view addSubview:developerView];
    
    return developerView;
}

#pragma mark -
#pragma mark 登录界面
- (UIView *)loadLoginView {
    [self.view removeAllSubviews];
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    loginView.backgroundColor = [UIColor whiteColor];
    [loginView initView:self];
    [self.view addSubview:loginView];
    return loginView;
}

#pragma mark -
#pragma mark 开发界面
- (UIView *)loadWebviewView {
    [self.view removeAllSubviews];
    
    WebviewView *webviewView = [[WebviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webviewView.backgroundColor = [UIColor whiteColor];
    [webviewView initView:self];
    [self.view addSubview:webviewView];
    
    return webviewView;
}

inline static UIImage* GetImageFormView(UIView *view) {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedImage;
}

@end
