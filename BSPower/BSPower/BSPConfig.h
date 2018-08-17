//
//  BSPConfig.h
//  BSPower
//
//  Created by tanguozhi on 2018-04-01.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SERVER_URL @"server_url"
#define LOGIN_USER_NAME @"LOGINUSERNAME"
#define LOGIN_USER_PASSWORD @"LOGINUSERPASSWORD"
#define LOGIN_IS_SAVE_PASSWORD @"LOGINISSAVEPASSWORD"

@interface BSPConfig : NSObject

/** 获取XRUtils单例
 */
+(BSPConfig *)sharedBSPConfig;

- (NSString *)getServerUrl;

- (void)setServerUrl:(NSString *)serverUrl;

- (BOOL)getHTTPSValidatesSecureCertificate;

- (void)setHTTPSValidatesSecureCertificate:(BOOL)isValidatesSecureCertificate;
@end
