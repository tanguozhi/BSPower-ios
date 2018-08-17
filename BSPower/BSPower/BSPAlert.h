//
//  BSPAlert.h
//
//  Created by tanguozhi on 2018-04-01.
//
//

#import <UIKit/UIAlertController.h>

@interface BSPAlert : NSObject

/** 获取XRAlert单例
 */
+(BSPAlert *)sharedBSPAlert;


/** 提示框 单按钮
 * @param title 标题
 * @param message 提示信息
 * @param okHanler 确定回回调
 */
- (void)alertWithTitle:(NSString *)title message:(NSString *)message okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler;

/** 提示框 单按钮
 * @param title 标题
 * @param message 提示信息
 * @param okTitle 确定按钮文字
 * @param okHanler 确定回回调
 */
- (void)alertWithTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler;

/** 提示框 双按钮
 * @param title 标题
 * @param message 提示信息
 * @param okHanler 确定回回调
 * @param cancelHandler 取消回回调
 */
- (void)alertWithTitle:(NSString *)title message:(NSString *)message okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler;

/** 提示框 双按钮
 * @param title 标题
 * @param message 提示信息
 * @param okTitle 确定按钮文字
 * @param cancelTitle 取消按钮文字
 * @param okHanler 确定回回调
 * @param cancelHandler 取消回回调
 */
- (void)alertWithTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle okHanler:(void (^ __nullable)(UIAlertAction *action))okHanler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler;

@end
