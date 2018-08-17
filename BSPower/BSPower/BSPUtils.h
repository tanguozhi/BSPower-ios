//
//  BSPUtils.h
//  BSPower
//
//  Created by tanguozhi on 2018-04-01.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSPUtils : NSObject

/** 获取XRUtils单例
 */
+(BSPUtils *)sharedBSPUtils;

/** 获取方法名称
 */
- (NSString *)getAppName;

/** 获取应用版本号
 */
- (NSString *)getAppVersion;

/** 获取应用build版本号
 */
- (NSString *)getAppBundleVersion;
/** 获取屏幕尺寸
 */
- (CGSize)getScreenSize;

/** 获取屏幕适配系数
 */
- (CGFloat)getFitSize;

/** 根据屏幕适配系数进行适配操作
 */
- (CGFloat)adaptedNumber:(CGFloat)original;

/** 根据屏幕适配系数进行还原适配操作
 */
- (CGFloat)restoreAdaptedNumber:(CGFloat)adapted;

/** 根据屏幕适配系数对字体进行适配操作
 */
- (CGFloat)adaptedFontSize:(CGFloat)originalSize;

/** 根据屏幕适配系数对字体进行还原适配操作
 */
- (CGFloat)restoreAdaptedFontSize:(CGFloat)adapted;

/** 以320为基准，根据屏幕适配系数对字体进行适配操作
 */
- (CGFloat)adaptedFontSizeWith320:(CGFloat)originalSize;

/** 以320为基准，根据屏幕适配系数对字体进行还原适配操作
 */
- (CGFloat)restoreAdaptedFontSizeWith320:(CGFloat)adapted;


/** 以320为基准，根据屏幕适配系数进行适配操作
 */
- (CGFloat)adaptedNumberWith320:(CGFloat)original;

/** 以320为基准，根据屏幕适配系数进行还原适配操作
 */
- (CGFloat)restoreAdaptedNumberWith320:(CGFloat)adapted;

/** 16进制字符串转换
 */
- (UIColor *)getColorFromHex:(NSString *)hexColor;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
