//
//  BSPAlert.m
//
//
//  Created by tanguozhi on 2018-04-01.
//
//

#import "BSPAlert.h"
#import <UIKit/UIWindow.h>

@implementation BSPAlert

+(BSPAlert *)sharedBSPAlert{
    static BSPAlert *_sharedBSPAlert = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedBSPAlert = [[BSPAlert alloc] init];
    });
    return _sharedBSPAlert;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    //创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:okHanler];
    [alertControl addAction:okAction];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentViewController:alertControl animated:YES completion:nil];
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    //创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:(UIAlertActionStyleDefault) handler:okHanler];
    [alertControl addAction:okAction];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentViewController:alertControl animated:YES completion:nil];
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    //创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:okHanler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:cancelHandler];
    [alertControl addAction:okAction];
    [alertControl addAction:cancelAction];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentViewController:alertControl animated:YES completion:nil];
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    //创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:(UIAlertActionStyleDefault) handler:okHanler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleDefault) handler:cancelHandler];
    [alertControl addAction:okAction];
    [alertControl addAction:cancelAction];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentViewController:alertControl animated:YES completion:nil];
}


@end
