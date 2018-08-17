//
//  BSPUtils.m
//  BSPower
//
//  Created by tanguozhi on 2018-04-01.

#import "BSPUtils.h"

@implementation BSPUtils

static BSPUtils *_sharedBSPUtils = nil;

+(BSPUtils *)sharedBSPUtils{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedBSPUtils = [[BSPUtils alloc] init];
    });
    return _sharedBSPUtils;
}

- (NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    return appName;
}

- (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app version
    NSString *appVerion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return appVerion;
}

- (NSString *)getAppBundleVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //app bundle version
    NSString *appBundleVerion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return appBundleVerion;
}


- (CGSize)getScreenSize {
    // ios 7.1 横屏 width:768 height:1024
    UIDevice *device = [UIDevice currentDevice];
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGRect boudle = [[UIScreen mainScreen] bounds];
    CGSize screenSize = boudle.size;
    
    if ([device.systemVersion floatValue] < 8.0f &&
        (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)) {
        screenSize = CGSizeMake(boudle.size.height, boudle.size.width);
    }
    return screenSize;
}

- (CGFloat)getFitSize{
    CGFloat fitSize = 1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        fitSize = [self getScreenSize].width/320;
    }else{
        fitSize = [self getScreenSize].width/320;
    }
    return fitSize;
}

- (CGFloat)adaptedNumber:(CGFloat)original{
    CGFloat adapte = original * [self getFitSize];
    return (int)adapte;
}
- (CGFloat)restoreAdaptedNumber:(CGFloat)adapted{
    CGFloat original = adapted / [self getFitSize];
    return original;
}
- (CGFloat)adaptedFontSize:(CGFloat)originalSize{
    CGFloat adapted = round(originalSize * [self getFitSize]);
    return adapted;
}
- (CGFloat)restoreAdaptedFontSize:(CGFloat)adapted{
    CGFloat original = round(adapted / [self getFitSize]);
    return original;
}

- (CGFloat)adaptedNumberWith320:(CGFloat)original{
    CGFloat fitSize = [self getScreenSize].width/320.0;
    CGFloat adapte = original * fitSize;
    return (int)adapte;
}
- (CGFloat)restoreAdaptedNumberWith320:(CGFloat)adapted{
    CGFloat fitSize = [self getScreenSize].width/320.0;
    CGFloat original = adapted / fitSize;
    return original;
}

- (CGFloat)adaptedFontSizeWith320:(CGFloat)originalSize{
    CGFloat fitSize = [self getScreenSize].width/320.0;
    CGFloat adapted = round(originalSize * fitSize);
    return adapted;
}
- (CGFloat)restoreAdaptedFontSizeWith320:(CGFloat)adapted{
    CGFloat fitSize = [self getScreenSize].width/320.0;
    CGFloat original = round(adapted / fitSize);
    return original;
}

- (UIColor *)getColorFromHex:(NSString *)hexColor  {
    if (hexColor == nil) {
        return nil;
    }
    
    hexColor = [hexColor stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    unsigned int red, green, blue;
    NSRange range1;
    range1.length = 2;
    range1.location = 0;
    
    NSRange range2;
    range2.location = 2;
    range2.length = 2;
    
    NSRange range3;
    range3.location = 4;
    range3.length = 2;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range1]] scanHexInt:&red];
    [[NSScanner scannerWithString:[hexColor substringWithRange:range2]] scanHexInt:&green];
    [[NSScanner scannerWithString:[hexColor substringWithRange:range3]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
